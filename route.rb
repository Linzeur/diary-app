require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods"

set :port,8001

#puts read_data
get "/" do
  @url = "/"
  @data = list_daily
  erb :list
  erb :list_entry
  erb :entry
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
post '/' do
  @message = validate_new_or_update_data(params) 
  @data = list_daily
  erb :list
  erb :list_entry
  redirect "/"
end

get "/photo" do
  @url = "/photo"
  @data = list_daily
  erb :list
  erb :list_entry
  erb :list_photos
end

get "/add-entry" do
  @data = list_daily
  erb :list
  erb :list_entry
end

get "/delete" do
  update_delete_data(params["id"] , 1)
  redirect "/"
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
  @entry_json = recover_element(params["id"])
  @data = list_daily
  erb :list
  erb :list_entry
  erb :view
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