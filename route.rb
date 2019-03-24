require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods"

set :port,8000

get "/" do
  @url = "/"
  @data = list_daily
  erb :list
  erb :list_entry
  erb :entry
end

get "/edit" do
  @url = "/edit" 
  @entry_json = trash_element(params["id"])
  @data = list_daily
  erb :list
  erb :list_entry
  erb :entry
end

get "/view" do
  @url = "/view"
  @entry_json = trash_element(params["id"])
  @data = list_daily
  erb :list
  erb :list_entry
  erb :view
end

post '/' do
  unless params.has_key?("file")
    validate_new_or_update_data(params) 
    @data = list_daily
    redirect "/"
  else
    files = params["file"]
    save_files(files) unless files.empty?
    redirect "/photo"
  end
end

get "/photo" do
  @url = "/photo"
  @list_images = Dir["./public/upload/*"]
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

post "/search" do
  @url = "/search"
  @data = search(params)
  erb :list
  erb :list_entry
  erb :entry
end
