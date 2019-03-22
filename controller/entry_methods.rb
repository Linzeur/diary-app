require 'json'
require "date"

$path_data = "./data/entries.json"

def read_data
  data_file = File.read($path_data)
  data_file = "{}" if data_file == "" 
  data = JSON.parse(data_file)
  data
end

def save_data(id, entry)
  data_file = read_data
  data_file[id] = entry
  File.open($path_data, "w+") do |file|
    file.write data_file.to_json
  end
end

def add_data(entry)
  identifier = Time.now.getutc.to_i
  entry["datetime"] = DateTime.parse(entry["datetime"]).strftime("%Y%m%d%H%M%S")
  entry["id"] = identifier
  save_data(identifier, entry)
end

def update_data(id, entry)
  save_data(id, entry)
end
