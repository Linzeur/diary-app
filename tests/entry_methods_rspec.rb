require './controller/entry_methods.rb'

RSpec.describe "Test logic_methods" do

  #Validate functionality 1
  
  it "should return something because something" do

    expect(result).to be true
  end
 # Verify functionality 2

  it "should return something because something" do

      expect(result).to include(File.read("../about.html"))
  end

end