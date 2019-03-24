require_relative 'entry_methods' 
require "date"

def list_daily
  list = []
  data = read_data
  data.each do |val|
    if val[1]["is_deleted"] == 0
      list.push(val[1])
    end
  end
  list = sort_parse(list)
end

def list_entry_trash
  list = []
  data = read_data
  now_date = DateTime.now()
  data.each do |val|
    if val[1]["is_deleted"] == 1
      temp_datetime = DateTime.parse(val[1]["deleted_datetime"])
      if ( (now_date - temp_datetime) < 1  )
        list.push(val[1])
      end
    end
  end
  list = sort_parse(list)
end

def sort_parse(list)
  list = list.sort_by{|value| value["datetime"].to_i}.reverse
  list.each do |val|
    val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
    val["content"] = val["content"].gsub(/(<|>)/,{"<"=>"&lt;",">"=>"&gt;"})
  end
  list
end

def validate_new_or_update_data(parameters)
  inputs = Hash.new
  inputs["title"] = parameters[:title]
  inputs["content"] = parameters[:content]
  unless parameters.has_key?("id")
    date = parameters[:date] + " " + parameters[:time]
    inputs["datetime"] = DateTime.parse(date).strftime("%Y%m%d%H%M%S")
    inputs["content_before"] = [] 
    inputs["highlight"] = 0
    inputs["highlight"] = 1 if parameters.has_key?("highlight")
    inputs["is_deleted"] = 0
    inputs["deleted_datetime"] = ""
    add_data(inputs)
  else
    update_data(parameters)
  end
end

def recover_element(id)
  data_file = read_data
  data_file[id]["datetime"] = DateTime.parse(data_file[id]["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
  data_file[id]
end

def trash_element(id)
  val=recover_element(id)
  if val["is_deleted"] == 0
    val
  elsif  (DateTime.now() -  DateTime.parse(val["deleted_datetime"]) < 1)  
    val
  else
    val={}
  end
end

def save_files(files)
  files.each.with_index do |file, index|
    filename = (Time.now.getutc.to_i + index).to_s + "." + file[:type].gsub("image/", "")
    File.open("./public/upload/" + filename, "wb") do |file_to_save|
      file_to_save.write file[:tempfile].read
    end
  end
end


