require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods"

set :port,8001

get "/" do
  @url = "/"
  @data = list_daily
  erb :list
  erb :list_entry
  erb :entry
end

get "/edit" do
  @url = "/edit" 
  @entry_json = recover_element(params["id"])
  @data = list_daily
  erb :list
  erb :list_entry
  erb :entry
end

get "/view" do
  @url = "/view"
  @entry_json = recover_element(params["id"])
  @data = list_daily
  erb :list
  erb :list_entry
  erb :view
end

post '/' do
  puts params.to_s
  validate_new_or_update_data(params) 
  @data = list_daily
  redirect "/"
end

get "/photo" do
  @url = "/photo"
  @data = list_daily
  erb :list
  erb :list_entry
  erb :list_photos
end

get "/delete" do
  update_delete_data(params["id"] , 1)
  redirect "/"
end

get "/highlight" do
  update_highlight_data(params)
  redirect "/"
end

get "/trash" do
  @url = "/trash"
  @data = list_entry_trash
  erb :list
  erb :list_entry
  erb :entry
end

get "/restore" do
  update_delete_data(params["id"] , 0)
  redirect "/trash"
end




# post "/prueba" do
#   puts params.to_s
#   puts params[:archivo][:filename]
#   File.open(params[:archivo][:filename], "wb") do |file|
#     file.write params[:archivo][:tempfile].read
#   end
#   "Hola"
# end

# It saved for POST