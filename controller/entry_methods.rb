require 'json'

$path_data = "./data/entries.json"
def read_data
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
  identifier = Time.now.getutc.to_i
  entry["id"] = identifier.to_s
  data_file[identifier] = entry
  save_data(data_file)
end

def update_data(parameters)
  data_file = read_data
  entry_edit = data_file[parameters[:id]]
  entry_edit["content_before"] << [entry_edit["title"], entry_edit["content"]]
  entry_edit["title"] = parameters[:title]
  entry_edit["content"] = parameters[:content]
  entry_edit["highlight"] = 1  if parameters.has_key?("highlight")
  save_data(data_file)
end

def update_delete_data(id, is_deleted)
  data_file = read_data
  data_file[id]["is_deleted"] = is_deleted
  if is_deleted==1
    data_file[id]["deleted_datetime"] = Time.now.strftime("%Y%m%d%H%M%S")
  else
    data_file[id]["deleted_datetime"] = ""
  end
  save_data(data_file)
end

def update_highlight_data(params)
    data_file = read_data
    data_file[params["id"]]["highlight"] = 0
    data_file[params["id"]]["highlight"] = 1 if params["flag"].to_i == 0
    save_data(data_file)
end


