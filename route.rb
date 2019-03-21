require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "erb"
require "./controller/entry_methods.rb"

set :port,8000

get "/" do
  erb :list, {:layout=> :layout}
  erb :daily, {:layout=> :layout}
end
