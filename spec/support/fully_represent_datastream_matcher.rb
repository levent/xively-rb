RSpec::Matchers.define :fully_represent_datastream do |format, formatted_datastream|
  match do |datastream|
    case format.to_sym
    when :json
      match_json_datastream(datastream, formatted_datastream)
    else
      raise "Unknown Datastream format: '#{format}'"
    end
  end

  failure_message_for_should do |datastream|
    "expected #{datastream} to fully represent #{formatted_datastream}"
  end

  description do
    "expected #{formatted_datastream.class} to be fully represented"
  end

  def match_json_datastream(datastream, formatted_datastream)
    json = MultiJson.load(formatted_datastream)
    case json['version']
    when '0.6-alpha'
      raise "Not implemented"
    else
      datastream.current_value.should == json["current_value"]
      datastream.id.should == json["id"]
      datastream.updated.should == json["at"]
      datastream.min_value.should == json["min_value"]
      datastream.max_value.should == json["max_value"]
    end
  end
end
