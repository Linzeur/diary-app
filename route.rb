require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"

get "/" do

  erb :list, {:layout=> :layout}
  erb :daily, {:layout=> :layout}
  
end

set :port,8006