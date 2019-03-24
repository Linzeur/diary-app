require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require_relative "./controller/list_methods"

set :port,8000
enable :sessions

get "/" do
  session[:search] = "" unless session[:search]
  @url = "/"
  params["search"] = session[:search]
  @data = search(params["search"])
  erb :list
  erb :list_entry
  erb :entry
end

get "/edit" do
  session[:search] = "" unless session[:search]
  @url = "/edit" 
  @entry_json = recover_element(params["id"])
  params["search"] = session[:search]
  @data = search(params["search"])
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
    session[:search] = "" unless session[:search]
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
