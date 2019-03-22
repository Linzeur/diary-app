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
  entry["id"] = identifier
  data_file[identifier] = entry
  save_data(data_file)
end

def update_data(id, title, content)
  data_file = read_data
  entry_edit = data_file[id]
  entry_edit["content_before"] << [entry_edit["title"], entry_edit["content"]]
  entry_edit["title"] = title
  entry_edit["content"] = content
  save_data(data_file)
end