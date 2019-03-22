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
  data[id] = entry
  File.open($path_data, "w+") do |file|
    file.write data.to_json
  end
end

def add_data(entry)
  data_file = read_data
  identifier = Time.now.getutc.to_i
  entry["datetime"] = DateTime.parse(entry["datetime"]).strftime("%Y%m%d%H%M%S")
  entry["id"] = identifier
  save_data(identifier, entry)
end

def update_data(id, entry)
  data_file = read_data
  save_data(id, entry)
end

def update_delete_data(id, is_deleted)
  data_file = read_data
  if is_deleted==1
    data_file[id]["is_deleted"] = is_deleted
    data_file[id]["deleted_datetime"] = Time.now.strftime("%Y%m%d%H%M%S")
  else
    data_file[id]["is_deleted"] = is_deleted
    data_file[id]["deleted_datetime"] = ""
  end
  File.open($path_data, "w+") do |file|
    file.write data_file.to_json
  end
end

def update_highlight_data(id, highlight_flag)
    data_file = read_data
    data_file[id]["highlight"] = highlight_flag
    File.open($path_data, "w+") do |file|
    file.write data_file.to_json
    end
end


