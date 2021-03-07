require 'typed_parameter/constraints/base'
require 'typed_parameter/constraints/integer_constraint'
require 'typed_parameter/constraints/float_constraint'
require 'typed_parameter/constraints/string_constraint'
require 'typed_parameter/constraints/date_constraint'
require 'typed_parameter/constraints/datetime_constraint'
require 'typed_parameter/constraints/boolean_constraint'

module TypedParameter
  module Constraints
    class << self
      def register(key, constraint)
        @constraints ||= {}
        @constraints[key] = constraint
      end

      def get(name)
        @constraints[name].freeze
      end
    end
  end
end

TypedParameter::Constraints.register :Integer, TypedParameter::Constraints::IntegerConstraint
TypedParameter::Constraints.register :String, TypedParameter::Constraints::StringConstraint
TypedParameter::Constraints.register :Float, TypedParameter::Constraints::FloatConstraint
TypedParameter::Constraints.register :Date, TypedParameter::Constraints::DateConstraint
TypedParameter::Constraints.register :Datetime, TypedParameter::Constraints::DatetimeConstraint
TypedParameter::Constraints.register :Boolean, TypedParameter::Constraints::BooleanConstraint
