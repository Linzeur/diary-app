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