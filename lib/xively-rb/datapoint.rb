module Xively
  class Datapoint
    ALLOWED_KEYS = %w(feed_id datastream_id at value)
    ALLOWED_KEYS.each { |key| attr_accessor(key.to_sym) }

    include Xively::Templates::JSON::DatapointDefaults
    include Xively::Parsers::JSON::DatapointDefaults

    # validates_presence_of :datastream_id
    # validates_presence_of :value

    include Validations

    def valid?
      pass = true
      [:datastream_id, :value, :feed_id].each do |attr|
        if self.send(attr).blank?
          errors[attr] = ["can't be blank"]
          pass = false
        end
      end
      return pass
    end

    def initialize(input = {})
      if input.is_a? Hash
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

    def attributes=(input)
      return if input.nil?
      input.deep_stringify_keys!
      ALLOWED_KEYS.each { |key| self.send("#{key}=", input[key]) }
      return attributes
    end

    def as_json(options = {})
      generate_json(options[:version])
    end

    def to_json(options = {})
      MultiJson.dump as_json(options)
    end
  end
end

