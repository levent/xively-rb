require 'multi_json'

$:.unshift(File.dirname(File.expand_path(__FILE__)))

$KCODE = 'u' if RUBY_VERSION.to_f < 1.9

require 'xively-rb/helpers'
require 'xively-rb/base'
require 'xively-rb/validations'
require 'xively-rb/object_extensions'
require 'xively-rb/nil_content'
require 'xively-rb/exceptions'
require 'xively-rb/string_extensions'
require 'xively-rb/array_extensions'
require 'xively-rb/hash_extensions'
require 'xively-rb/templates/defaults'
require 'xively-rb/parsers/defaults'
require 'xively-rb/feed'
require 'xively-rb/datastream'
require 'xively-rb/datapoint'
require 'xively-rb/search_result'
require 'xively-rb/trigger'
require 'xively-rb/key'
require 'xively-rb/permission'
require 'xively-rb/resource'
require 'xively-rb/version'

require 'xively-rb/client'
require 'xively-rb/client/feed_handler'
