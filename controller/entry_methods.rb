require 'json'

$path_data = File.dirname(__FILE__) + "/../data/entries.json"

def read_data
  save_data(Hash.new) unless File.exists?($path_data)
  data_file = File.read($path_data)
  data_file = "{}" if data_file == ""
  data = JSON.parse(data_file)
  data
end

def save_data(data)
  File.open($path_data, "w+") do |file|
    file.write data.to_json
  end
end
def add_data(entry)
  data_file = read_data
  #Generate an ID number unique based on the system date
  identifier = Time.now.getutc.to_i
  entry["id"] = identifier.to_s
  data_file[identifier] = entry
  save_data(data_file)
end

def update_data(entry)
  data_file = read_data
  entry_edit = data_file[entry["id"]]
  #Feature: Update entries #5 - Have a list of the previos version
  entry_edit["content_before"] << [entry_edit["title"], entry_edit["content"]]
  entry_edit["title"] = entry["title"]
  entry_edit["content"] = entry["content"]
  entry_edit["highlight"] = entry["highlight"]
  save_data(data_file)
end


