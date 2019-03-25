require '../controller/list_methods.rb'

RSpec.describe "Test logical of functions" do

  # Validate if a date is greater than 1 day
  # Using string as date with format dd-MM-YYYY HH:mm:ss
  it "should return true when the now date is greater the entered date by less to 1 day" do
    date = "25-03-2019 00:20:00"
    expect(validate_diff_days(date)).to be true
  end

  it "should return false when the now date is greater the entered date by more to 1 day" do
    date = "24-03-2019 00:20:00"
    expect(validate_diff_days(date)).to be false
  end

  it "should return true when the now date is lower the entered date " do
    date = "28-03-2019 00:20:00"
    expect(validate_diff_days(date)).to be true
  end

 # Validate if the order of data by date is descendent
 # The data to pass has to be a array with hash as element
 # That hash has to have a key named "datetime"
 # And its value is a date in format YYYYMMddHHmmss
 # Also it has key named "content"
  it "should return the data ordered by date from the most current to the oldest" do
      data = [{"datetime"=> "20190325205648", "content"=> "asddasdas"}, 
              {"datetime"=> "20190324102030", "content"=> "asddasdas"}, 
              {"datetime"=> "20190325212018", "content"=> "asddasdas"}]
      data_ordered = [{"datetime"=> "25-03-2019 21:20:18", "content"=> "asddasdas"}, 
                      {"datetime"=> "25-03-2019 20:56:48", "content"=> "asddasdas"}, 
                      {"datetime"=> "24-03-2019 10:20:30", "content"=> "asddasdas"}]
      expect(sort_parse(data)).equal?(data_ordered)
  end

end