require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods"

set :port,8000
enable :sessions

# Initialize session variables


get "/" do
  @url = "/"
  session[:search] = "" unless session[:search]
  params["search"] = session[:search]
  @data = search(params["search"])
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
  @entry_json = recover_element(params["id"])
  if params.has_key?("view")
    @url = "/trash"
    @data = list_entry_trash
  else
    @url = "/"
    params["search"] = session[:search]
    @data = search(params["search"])
  end
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

post "/search" do
  session[:search] = params["search"]
  redirect "/"
end

get "/photo" do
  @url = "/photo"
  @list_images = Dir["./public/upload/*"]
  session[:search] = ""
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
  session[:search] = ""
  @data = list_entry_trash
  erb :list
  erb :list_entry
  erb :entry
end

get "/restore" do
  update_delete_data(params["id"] , 0)
  redirect "/trash"
end
