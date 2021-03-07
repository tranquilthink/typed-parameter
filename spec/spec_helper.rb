require 'rubygems'

$LOAD_PATH.unshift File.expand_path("#{File.dirname(__FILE__)}/../lib")

require 'active_support' # 6.1.3
require 'active_support/core_ext'
require 'active_model/railtie'
require 'action_controller/railtie'
require 'typed_parameter'
