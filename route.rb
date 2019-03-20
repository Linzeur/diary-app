require "sinatra"
require "erb"

get "/" do
  erb :index
end

set :port,8006