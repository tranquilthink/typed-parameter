require 'typed_parameter/boolean' # For Booelan Class Define

require 'typed_parameter/version'
require 'typed_parameter/parameter_types'
require 'typed_parameter/constraints'
require 'typed_parameter/enum_constraint'
require 'typed_parameter/type_constraint'
require 'typed_parameter/permit_field_generator'
require 'typed_parameter/base'

require 'typed_parameter/swagger/types'
require 'typed_parameter/swagger/type_generator'
require 'typed_parameter/swagger/property_generator'
require 'typed_parameter/swagger/component_generator'

module TypedParameter
  class Error < StandardError; end
end
