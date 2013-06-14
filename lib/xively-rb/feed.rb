module Xively
  class Feed
    # The order of these keys is the order attributes are assigned in. (i.e. id should come before datastreams)
    ALLOWED_KEYS = %w(id creator owner_login datastreams description email feed icon location_disposition location_domain location_ele location_exposure location_lat location_lon location_name location_waypoints private status tags title updated created website auto_feed_url product_id device_serial csv_version)
    ALLOWED_KEYS.each { |key| attr_accessor(key.to_sym) }

    include Xively::Templates::JSON::FeedDefaults
    include Xively::Parsers::JSON::FeedDefaults

    include Validations

    def valid?
      pass = true
      if title.blank?
        errors[:title] = ["can't be blank"]
        pass = false
      end

      duplicate_datastream_ids = datastreams.inject({}) {|h,v| h[v.id]=h[v.id].to_i+1; h}.reject{|k,v| v==1}.keys
      if duplicate_datastream_ids.any?
        errors[:datastreams] = ["can't have duplicate IDs: #{duplicate_datastream_ids.join(',')}"]
        pass = false
      end

      datastreams.each do |ds|
        unless ds.valid?
          ds.errors.each { |attr, ds_errors|
            errors["datastreams_#{attr}".to_sym] = ([*errors["datastreams_#{attr}".to_sym]] | [*ds_errors]).compact
          }
          pass = false
        end
      end

      return pass
    end

    def initialize(input = {})
      if input.is_a?(Hash)
        self.attributes = input
      else
        self.attributes = from_json(input)
      end
    end

    def attributes
      h = {}
      ALLOWED_KEYS.each do |key|
        value = self.send(key)
        h[key] = value unless value.nil?
      end
      return h
    end

    def datastreams
      return [] if @datastreams.nil?
      @datastreams
    end

    def attributes=(input)
      return if input.nil?
      input.deep_stringify_keys!
      ALLOWED_KEYS.each { |key| self.send("#{key}=", input[key]) }
      return attributes
    end

    def datastreams=(array)
      return unless array.is_a?(Array)
      @datastreams = []
      array.each do |datastream|
        if datastream.is_a?(Datastream)
          @datastreams << datastream
        elsif datastream.is_a?(Hash)
          @datastreams << Datastream.new(datastream)
        end
      end
    end

    def as_json(options = {})
      options[:version] ||= "1.0.0"
      generate_json(options.delete(:version), options)
    end

    def to_json(options = {})
      MultiJson.dump as_json(options)
    end
  end
end
