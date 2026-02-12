package main

import ("bytes"; "context"; "encoding/json"; "fmt"; "io"; "net/http"; "os"; "time"; "github.com/liushuangls/go-anthropic/v2")

type SlackEvent struct { Type string `json:"type"`; Challenge string `json:"challenge"`; Event struct { Text string `json:"text" `} `json:"event"` }
type AIResponse struct { Category string `json:"category"`; Filename string `json:"filename"`; Content string `json:"content"` }

func main() {
	http.HandleFunc("/slack/events", func(w http.ResponseWriter, r *http.Request) {
		body, _ := io.ReadAll(r.Body)
		var p SlackEvent
		json.Unmarshal(body, &p)
		if p.Type == "url_verification" { w.Header().Set("Content-Type", "text/plain"); w.Write([]byte(p.Challenge)); return }
		if p.Event.Text != "" { fmt.Printf("Input: %s\n", p.Event.Text); go handleAIWorker(p.Event.Text) }
		w.WriteHeader(http.StatusOK)
	})
	port := os.Getenv("PORT")
	if port == "" { port = "8080" }
	fmt.Printf("OpenClaw-Lite active on %s\n", port)
	http.ListenAndServe(":"+port, nil)
}

func handleAIWorker(input string) {
	res, err := askClaude(input)
	if err != nil { fmt.Printf("AI Error: %v\n", err); return }
	triggerGitHubAction(res)
}

func askClaude(input string) (AIResponse, error) {
	client := anthropic.NewClient(os.Getenv("ANTHROPIC_API_KEY"))
	now := time.Now().Format("2006-01-02")
	sys := fmt.Sprintf(`あなたはCTO近藤の専属ジュニアエンジニアです。入力から以下の【CTO流TILテンプレート】でMarkdownを生成し、JSONのみで返せ。
【テンプレート】
## ✅ TIL（%s）：[タイトル]
**MODE：STD**
## 今日の状態
* [睡眠や体調]
## 今日の前提
* [状況/目標]
## 今日やること（予定）
* [予定]
## 今日やったこと
* [結果]
## メモ（軽め）
* [哲学]
## 3行日記（当日）
**体調**・[状態] **よかった**・[点] **わるかった**・[点]
【JSON形式】{"category":"01_TIL","filename":"YYYYMMDD_topic.md","content":"..."}`, now)
	resp, err := client.CreateMessages(context.Background(), anthropic.MessagesRequest{
		Model: anthropic.ModelClaude3Dot5SonnetLatest,
		System: sys,
		Messages: []anthropic.Message{{Role: anthropic.RoleUser, Content: []anthropic.MessageContent{anthropic.NewTextMessageContent(input)}}},
		MaxTokens: 1536,
	})
	if err != nil { return AIResponse{}, err }
	var aiRes AIResponse
	err = json.Unmarshal([]byte(resp.Content[0].Text), &aiRes)
	return aiRes, err
}

func triggerGitHubAction(res AIResponse) {
	url := "https://api.github.com/repos/conti0513/development_public/dispatches"
	data, _ := json.Marshal(map[string]interface{}{"event_type": "ai-exec-command", "client_payload": map[string]interface{}{"category": res.Category, "filename": res.Filename, "content": res.Content}})
	req, _ := http.NewRequest("POST", url, bytes.NewBuffer(data))
	req.Header.Set("Authorization", "Bearer "+os.Getenv("GITHUB_PAT"))
	req.Header.Set("Accept", "application/vnd.github+json")
	req.Header.Set("User-Agent", "OpenClaw-Lite-Brain")
	c := &http.Client{}
	r, _ := c.Do(req)
	defer r.Body.Close()
	fmt.Printf("GitHub Dispatched: %d\n", r.StatusCode)
}