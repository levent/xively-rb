def datapoint_as_(format, options = {})
  case format.to_s
  when 'hash'
    data = {
      "at" => Time.parse('2011-01-02'),
      "value" => "2000"
    }
  when 'json'
    data = {
      'at' => '2011-02-16T16:21:01.834174Z',
      'value' => "2000"
    }
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
