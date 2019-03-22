require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods.rb"

set :port,8001

get "/" do
  @data = list_daily
  erb :list
  erb :list_entry
  erb :daily
end

post '/' do 
  #save_workshop(params["title"], params["content"])
  inputs = Hash.new 
  inputs["title"] = params["title"]
  inputs["datetime"] = params["date"] + params["time"]
  inputs["content"] = params["content"]
  inputs["content_before"] = [] 
  inputs["highlight"] = 0
  inputs["is_deleted"] = 0
  inputs["deleted_datetime"] = ""
  @message = "La nueva entrada de titulo #{params[:title]} fue creado exitosamente"
  erb :list
  erb :success

end
get "/photo" do
  @data = list_daily
  erb :list
  erb :add_photo
  erb :daily
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
  # TODO: Add edit logic
end
