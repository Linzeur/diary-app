require_relative 'entry_methods' 
require "date"

def list_daily
  list = []
  data = read_data
  data.each do |val|
    list.push(val[1])
  end
  list.sort_by{|value| value["datetime"].to_i}
  list.each do |val|
    val["datetime"] = DateTime.parse(val["datetime"]).strftime("%d-%m-%Y %H:%M:%S")
  end
  list
end

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
    msg = "La nueva entrada de titulo #{inputs["title"]} fue creado exitosamente"
  else
    update_data(parameters[:id], inputs["title"], inputs["content"])
    msg = "La entrada de titulo #{inputs["title"]} fue actualizado exitosamente"
  end
  msg
end

def recover_element(id)
  data_file = read_data
  data_file[id]
end