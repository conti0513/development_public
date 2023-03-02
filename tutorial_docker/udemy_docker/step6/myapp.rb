require 'sinatra'

tasks = [
  {
    title: 'フロントエンドの実装',
    createdAt: Time.now
  },
  {
    title: 'バックエンドの実装',
    createdAt: Time.now
  }
]

get '/' do
  'Hello world!'
end

get '/api/hello' do
  {
    message: 'Hello world!'
  }.to_json
end

get '/api/tasks' do
  {
    tasks: tasks
  }.to_json
end

post '/api/tasks' do
  request_body = JSON.parse request.body.read

  task = {
    title: request_body['title'],
    createdAt: Time.now
  }

  tasks.push task
  
  task.to_json
end
