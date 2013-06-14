def datastream_as_(format, options = {})
  case format.to_s
  when 'hash'
    data = {
      "updated" => Time.parse('2011-01-02'),
      "max_value"=>658.0,
      "unit_type"=>"derived SI",
      "min_value"=>0.0,
      "unit_label"=>"percentage",
      "current_value"=>"14",
      "id"=>"0",
      "tags"=>"humidity,Temperature   ,freakin lasers",
      "unit_symbol"=>"%",
      "feed_id" => "24568",
      "feed_creator" => "Dennis",
      "datapoints" => [{
          "value" => "1",
          "at" => Time.parse("2011-03-02T15:59:56.895922Z")
      },
      {
          "value" => "1",
          "at" => Time.parse("2011-03-02T16:00:07.188648Z")
      },
      {
          "value" => "2",
          "at" => Time.parse("2011-03-02T16:00:18.416500Z")
      }]
    }
  when 'json'
    data = datastream_as_json(options[:version] || "1.0.0")
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

def datastream_as_json(version)
  case version
  when "1.0.0"
    {
      'min_value' => '0.0',
      'at' => '2011-02-16T16:21:01.834174Z',
      'tags' => ['humidity', 'Temperature', 'freakin lasers'],
      'current_value' => '14',
      'max_value' => '658.0',
      'datapoints_function' => 'average',
      "datapoints" => [{
          "value" => "1",
          "at" => "2011-03-02T15:59:56.895922Z"
      },
      {
          "value" => "1",
          "at" => "2011-03-02T16:00:07.188648Z"
      },
      {
          "value" => "2",
          "at" => "2011-03-02T16:00:18.416500Z"
      }],
      'id' => '0',
      "unit" => {
      "type" => "derived SI",
      "symbol" => "%",
      "label" => "percentage"
    },
      'version' => '1.0.0'
    }
  when "1.0.0-minimal"
    {
      "current_value" => "294",
      "max_value" => "697.0",
      "min_value" => "0.0",
      "id" => "1"
    }
  when "1.0.0-minimal_timestamp"
    {
      "current_value" => "294",
      "max_value" => "697.0",
      "min_value" => "0.0",
      "id" => "1",
      "at" => "2011-03-02T16:00:18.416500Z"
    }
  when "0.6-alpha"
    {
      "tags" => ["humidity"],
      "values" => [{
        "min_value" => "0.0",
        "recorded_at" => "2011-02-22T14:28:50Z",
        "value" => "129",
        "max_value" => "658.0"
      }],
      "id" => "0",
      "unit" => {
      "type" => "derived SI",
      "symbol" => "%",
      "label" => "percentage"
    },
      'version' => '0.6-alpha'
    }
  else
    raise "Datastream as JSON #{version} not implemented"
  end
end
