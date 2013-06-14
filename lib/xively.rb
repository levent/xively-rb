require 'multi_json'

$:.unshift(File.dirname(File.expand_path(__FILE__)))

$KCODE = 'u' if RUBY_VERSION.to_f < 1.9

require 'xively/helpers'
require 'xively/base'
require 'xively/validations'
require 'xively/object_extensions'
require 'xively/nil_content'
require 'xively/exceptions'
require 'xively/string_extensions'
require 'xively/array_extensions'
require 'xively/hash_extensions'
require 'xively/templates/defaults'
require 'xively/parsers/defaults'
require 'xively/feed'
require 'xively/datastream'
require 'xively/datapoint'
require 'xively/search_result'
require 'xively/trigger'
require 'xively/key'
require 'xively/permission'
require 'xively/resource'
require 'xively/version'

require 'xively/client'
require 'xively/client/feed_handler'
