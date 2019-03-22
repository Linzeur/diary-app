require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/entry_methods"

set :port,8000

#puts read_data
get "/" do
  erb :list
  erb :entry
end

post "/prueba" do
  puts params.to_s
  puts params[:archivo][:filename]
  File.open(params[:archivo][:filename], "wb") do |file|
    file.write params[:archivo][:tempfile].read
  end
  "Hola"
end

get "/photo" do
  erb :list
  erb :list_photos
end

