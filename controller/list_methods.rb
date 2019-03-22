require_relative 'entry_methods' 
require "date"

def list_daily
  list = []
  data = read_data
  data.each do |val|
    list.push(val[1])
  end
  list.sort_by{|value| value["datetime"].to_i}
  list.each do |val|
    val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
  end
  list
end