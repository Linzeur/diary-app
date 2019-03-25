require_relative 'entry_methods' 
require "date"

def validate_new_or_update_data(parameters)
  inputs = Hash.new
  inputs["title"] = parameters[:title]
  inputs["content"] = parameters[:content]
  unless parameters.has_key?("id")
    date = parameters[:date] + " " + parameters[:time]
    inputs["datetime"] = DateTime.parse(date).strftime("%Y%m%d%H%M%S")
    inputs["content_before"] = []
    #Highlight is a optional value
    inputs["highlight"] = 0
    inputs["highlight"] = 1 if parameters.has_key?("highlight")
    inputs["is_deleted"] = 0
    inputs["deleted_datetime"] = ""
    add_data(inputs)
  else
    #Highlight is a optional value
    inputs["highlight"] = 0
    inputs["highlight"] = 1 if parameters.has_key?("highlight")
    inputs["id"] = parameters[:id]
    update_data(inputs)
  end
end

#Feature: Delete entries #6 - After 1 day, the entries deleted will not show more
def validate_diff_days(date_begin)
  diff_days = 0
  diff_days = DateTime.now - DateTime.parse(date_begin) unless date_begin == ""
  (diff_days < 1)
end

def recover_element(id, as_text)
  data_file = read_data
  val = data_file[id]
  val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
  #Bug: Distorted display #42 - Replace characters <, > or \r\n with their equivalents
  val["content"] = val["content"].gsub(/(<|>|\r\n)/, {"<"=>"&lt;", ">"=>"&gt;", "\r\n"=>"<br/>"}) if as_text
  val = Hash.new unless validate_diff_days(val["deleted_datetime"])
  val
end

def update_delete_data(id, is_deleted)
  data_file = read_data
  val = data_file[id]
  if validate_diff_days(val["deleted_datetime"])
    val["is_deleted"] = is_deleted
    if is_deleted == 1
      val["deleted_datetime"] = Time.now.strftime("%Y%m%d%H%M%S")
    else
      val["deleted_datetime"] = ""
    end
    save_data(data_file)
  end
end

def update_highlight_data(params)
  data_file = read_data
  val = data_file[params["id"]]
  if validate_diff_days(val["deleted_datetime"])
    val["highlight"] = 0
    val["highlight"] = 1 if params["flag"].to_i == 0
    save_data(data_file)
  end
end

def list_daily
  list = []
  data = read_data
  data.each do |val|
    list << val[1]  if val[1]["is_deleted"] == 0
  end
  list = sort_parse(list)
end

def list_entry_trash
  list = []
  data = read_data
  now_date = DateTime.now()
  data.each do |val|
    if val[1]["is_deleted"] == 1
      #Feature: Delete entries #6 - Before 1 day, the entries deleted can show
      temp_datetime = DateTime.parse(val[1]["deleted_datetime"])
      list << val[1] if ((now_date - temp_datetime) < 1)
    end
  end
  list = sort_parse(list)
end

def sort_parse(list)
  list = list.sort_by{|value| value["datetime"].to_i}.reverse
  list.each do |val|
    val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
    val["content"] = val["content"].gsub(/(<|>)/, {"<"=>"&lt;", ">"=>"&gt;"})
  end
  list
end

def search(searched)
  #Feature: Search entries #33 - The input text can contain characters < or >
  searched = searched.gsub(/(<|>)/, {"<"=>"&lt;", ">"=>"&gt;"})
  list, list_filter = [],[]
  list = list_daily
  list.each do |val|
    #Feature: Search entries #33 - Search by Title and Content
    list_filter.push(val)  if val["title"].include?(searched) || val["content"].to_s.include?(searched)
  end
  list_filter
end

def save_files(files, url)
  directory_name = "./public/upload/"
  Dir.mkdir(directory_name) unless File.exists?(directory_name)
  list_new_images = "<br/><b>Estos son los links de las siguientes imagenes cargadas:</b><br/>"
  files.each.with_index do |file, index|
    #Generate an ID number unique based on the system date
    identifier = Time.now.getutc.to_i + index
    filename = identifier.to_s + "." + file[:type].gsub("image/", "")
    File.open(directory_name + filename, "wb") do |file_to_save|
      #The key :tempfile has as value the uploaded files' content from client
      file_to_save.write file[:tempfile].read
    end
    list_new_images += "<br/>=>#{url}/upload/#{filename}"
  end
  list_new_images
end


