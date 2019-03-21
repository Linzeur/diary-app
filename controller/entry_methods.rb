require 'json'

$path_data = "./data/entries.json"

def read_data
  data_file = File.read($path_data)
  data_file = "{}" if data_file == "" 
  data = JSON.parse(data_file)
  data
end

def save_data(entry)
  data_file = read_data
  identifier = Time.now.getutc.to_i
  entry["id"] = identifier
  data_file[identifier] = entry
  File.open($path_data, "w+") do |file|
    file.write data_file.to_json
  end
end

def update_data(id, entry)
  data_file = read_data
  data_file[id] = entry
  File.open($path_data, "w+") do |file|
    file.write data_file.to_json
  end
end
