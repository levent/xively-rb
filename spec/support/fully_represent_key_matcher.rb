RSpec::Matchers.define :fully_represent_key do |format, formatted_key|
  match do |key|
    case format.to_sym
    when :json
      match_json_key(key, formatted_key)
    end
  end

  failure_message_for_should do |key|
    "expected #{key.attributes.inspect} to fully represent #{formatted_key}"
  end

  description do
    "expected #{formatted_key.class} to be fully represented"
  end

  def match_json_key(key, formatted_key)
    json = MultiJson.load(formatted_key)["key"]
    key.id.should == json["id"]
    key.expires_at.should == json["expires_at"]
    key.key.should == json["api_key"]
    key.user.should == json["user"]
    key.label.should == json["label"]
    key.private_access.should == json["private_access"]
    key.permissions.each_index do |index|
      permission = key.permissions[index]

      permission.referer.should == json["permissions"][index]["referer"]
      permission.source_ip.should == json["permissions"][index]["source_ip"]
      permission.label.should == json["permissions"][index]["label"]
      permission.access_methods.should == json["permissions"][index]["access_methods"]

      permission.resources.each_index do |res_index|
        resource = permission.resources[res_index]

        resource.feed_id.should == json["permissions"][index]["resources"][res_index]["feed_id"]
        resource.datastream_id.should == json["permissions"][index]["resources"][res_index]["datastream_id"]
        resource.datastream_trigger_id.should == json["permissions"][index]["resources"][res_index]["datastream_trigger_id"]
      end
    end
  end
end
