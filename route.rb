require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/entry_methods"
require "./controller/list_methods"

set :port,8000

#puts read_data
get "/" do
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
  @data = list_daily
  erb :list
  erb :add_photo
  erb :list_photos
end

get "/add-entry" do
  @data = list_daily
  # TODO: Add new entry
  erb :list
  erb :list_entry
end

get "/delete" do
  # TODO: Add delete logic
  redirect "/"
end

get "/edit" do
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