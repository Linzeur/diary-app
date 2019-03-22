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

post '/' do
  inputs = Hash.new
  inputs["title"] = params["title"]
  inputs["datetime"] = params["date"] + " " + params["time"]
  inputs["content"] = params["content"]
  inputs["content_before"] = [] 
  inputs["highlight"] = 0
  inputs["is_deleted"] = 0
  inputs["deleted_datetime"] = ""
  add_data(inputs)
  @message = "La nueva entrada de titulo #{params[:title]} fue creado exitosamente"
  erb :list
  erb :success

end
get "/photo" do
  @data = list_daily
  erb :list
  erb :add_photo
  erb :entry
end


get "/add-entry" do
  @data = list_daily
  # TODO: Add new entry
  erb :list
  erb :list_entry
end

get "/delete" do
  update_delete_data(params["id"] , 1)
  redirect "/"
end

get "/edit" do
  # TODO: Add edit logic
end

get "/highlight" do
  update_highlight_data(params)
  redirect "/"
end
