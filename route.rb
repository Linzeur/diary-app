require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/list_methods.rb"

set :port,8000

get "/" do
  @data = list_daily
  erb :list, {:layout=> :layout}
  erb :daily, {:layout=> :layout}
end

