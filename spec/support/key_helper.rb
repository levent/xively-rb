def key_as_(format, options = {})
  # Default data
  # This data is based on http://api.xively.com/v2/feeds/504
  case format.to_s
  when 'hash', 'json'
    data = { "id" => 40, "key" => "abcdefghasdfaoisdj109usasdf0a9sf", "label" => "Our awesome label",
      "user" => "lebreeze", "expires_at" => 12345, "private_access" => true,
      "permissions" => [
        { "source_ip" => "127.0.0.1", "referer" => "http://xively.com",
          "access_methods" => %w(get put post delete),
          "resources" => [
            { "feed_id" => 424, "datastream_id" => "1" }
          ]
        }
      ]}
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
    MultiJson.dump({ "key" => data })
  else
    raise "#{format} undefined"
  end
end

