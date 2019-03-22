require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/entry_methods.rb"
require "./controller/list_methods.rb"

 set :port,8000

get "/" do
  @data = list_daily
  erb :list
  erb :list_entry
  erb :daily
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

  @id = params["id"] 
  "Ok #{@id}"

  update_delete_data(@id, 1)

  redirect "/"
end

get "/edit" do
  # TODO: Add edit logic
end


