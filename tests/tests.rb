require_relative "../route.rb"
require "erb"
require "rspec"
require "rack/test"

describe "main" do
    
    include Rack::Test::Methods
  
    def app
      Sinatra::Application
    end  
  
    it "Allow access to homepage as a bundle" do
      get '/'
      expect(last_response).to be_ok
    end

    it "Try to get home with all diary posts" do
      response = get "/"
      expect(response.status).to eql(200)
    end
      
    it "Try to get home with all diary posts and contains word Daily" do
      response = get '/'      
      expect(response.body).to include("Diary App")
    end

    it "Try to get all deleted stories" do
        response = get "/trash"
        expect(response.status).to eql(200)
      end
        
    it "Try to get all deleted stories and verify if there is a word Diary App - Deleted" do
        response = get "/trash" 
        expect(response.body).to include("Diary App - Deleted")
    end

    it "Try to save an story" do
        response = post "/", { title: "example story for testing", content: ":)", date: "2019-03-24", time: "00:01" }
        expect(response.status).to eql(302)
        expect(response.body).to eql("")
    end  
end
  