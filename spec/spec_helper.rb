require 'rubygems'

$LOAD_PATH.unshift File.expand_path("#{File.dirname(__FILE__)}/../lib")

require 'active_model/railtie'
require 'action_controller/railtie'
# require 'mongoid'
require 'typed_parameter'
