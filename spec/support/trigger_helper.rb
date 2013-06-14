def trigger_as_(format, options = {})
  # Default data
  # This data is based on http://api.xively.com/v2/feeds/504
  case format.to_s
  when 'hash'
    data = {"threshold_value"=>"44", "notified_at"=>"", "url"=>"http://www.postbin.org/zc9sca", "trigger_type"=>"eq", "id"=>40, "stream_id"=>"1", "environment_id"=>424, "user"=>"lebreeze"}
  when 'json'
    data = {"threshold_value"=>"44", "notified_at"=>"", "url"=>"http://www.postbin.org/zc9sca", "trigger_type"=>"eq", "id"=>40, "stream_id"=>"1", "environment_id"=>424, "user"=>"lebreeze"}
  end

  # Add extra options we passed
  if options[:with]
    options[:with].each do |field, value|
      data[field.to_s] = value
    end
  end

  # Remove options we don't need
  if options[:except]
    options[:except].each do |field,_|
      data.delete(field.to_s)
    end
  end

  # Return the feed in the requested format
  case format.to_s
  when 'hash'
    data
  when 'json'
    MultiJson.dump(data)
  else
    raise "#{format} undefined"
  end
end

