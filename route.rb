require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"

set :port,8000

get "/" do
  erb :list, {:layout=> :layout}
  erb :daily, {:layout=> :layout}
end

post '/' do 
  #save_workshop(params["title"], params["content"])
  @message = "La nueva entrada de titulo #{params[:title]} fue creado exitosamente"
  erb :list
  erb :success

end
