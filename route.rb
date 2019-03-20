require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"

set :port,8001

get "/" do

  erb :list, {:layout=> :layout}
  erb :daily, {:layout=> :layout}
end

