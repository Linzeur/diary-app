require_relative 'entry_methods' 
require "date"

def list_daily
  list = []
  data = read_data
  data.each do |val|
    if val[1]["is_deleted"]==0
      list.push(val[1])
    end
  end
  list.sort_by{|value| value["datetime"].to_i}
  list.each do |val|
    val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
  end
  list
end

def list_entry_trash
  list = []
  data = read_data
  now_date = DateTime.now()
  data.each do |val|
    val[1]["datetime"] = DateTime.parse(val[1]["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
    if val[1]["is_deleted"] == 1
      temp_datetime = DateTime.parse(val[1]["deleted_datetime"])
      if ( (now_date - temp_datetime) < 1  )
        list.push(val[1])
      end
    end
  end
  list.sort_by{|value| value["datetime"].to_i}
  list
end

# list_entry_trash
def validate_new_or_update_data(parameters)
  inputs = Hash.new
  inputs["title"] = parameters[:title]
  inputs["content"] = parameters[:content]
  unless parameters.has_key?("id")
    inputs["datetime"] = DateTime.parse(parameters[:date] + " " + parameters[:time]).strftime("%Y%m%d%H%M%S")
    inputs["content_before"] = [] 
    inputs["highlight"] = 0
    inputs["is_deleted"] = 0
    inputs["deleted_datetime"] = ""
    add_data(inputs)
  else
    update_data(parameters[:id], inputs["title"], inputs["content"])
  end
end

def recover_element(id)
  data_file = read_data
  data_file[id]
end
