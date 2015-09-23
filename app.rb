require 'sinatra'
require 'json'
require 'pry'
require 'active_support/all'
require 'nokogiri'

get '/' do
  "Hello World"
end

post '/' do
  
  if !params["file"].nil? && !params["file"].empty?
    file_data = params["file"][:tempfile]
    if file_data.respond_to?(:read)
      contents = file_data.read
    elsif file_data.respond_to?(:path)
      contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
  elsif !params["text"].nil? && !params["text"].empty?
    contents = params["text"]
  else
    status 406
    body "File or text required"
    return
  end
  
  begin
    case params["i"]
    when "xml"
      xml_data = Nokogiri::XML(contents)
      data_hash = Hash.from_xml(xml_data.to_s)
    when "json"
      data_hash = JSON.parse(contents)
    else
      status 400
      body "Input type is not supported"
      return
    end
  rescue Exception => e  
    status 400
    body e.message
    # puts e.backtrace.inspect
    return
  end
  
  begin
    case params["o"]
    when "xml"
      converted_contents = data_hash.to_xml
    when "json"
      converted_contents = data_hash.to_json
    else
      status 400
      body "Output type is not supported"
      return
    end
  rescue Exception => e
    status 400
    body e.message
    # puts e.backtrace.inspect
    return
  end
  
  status 200
  body converted_contents
end