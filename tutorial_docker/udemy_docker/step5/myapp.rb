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
