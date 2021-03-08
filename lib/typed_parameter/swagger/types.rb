require 'typed_parameter/swagger/types/base'
require 'typed_parameter/swagger/types/integer_type'
require 'typed_parameter/swagger/types/float_type'
require 'typed_parameter/swagger/types/string_type'
require 'typed_parameter/swagger/types/date_type'
require 'typed_parameter/swagger/types/date_time_type'
require 'typed_parameter/swagger/types/boolean_type'

module TypedParameter
  module Swagger
    module Types
      class << self
        def register(key, type)
          @swagger_types ||= {}
          @swagger_types[key] = type
        end

        def [](key)
          @swagger_types[key].freeze
        end
      end
    end
  end
end

TypedParameter::Swagger::Types.register :Integer, TypedParameter::Swagger::Types::IntegerType
TypedParameter::Swagger::Types.register :String, TypedParameter::Swagger::Types::StringType
TypedParameter::Swagger::Types.register :Float, TypedParameter::Swagger::Types::FloatType
TypedParameter::Swagger::Types.register :Date, TypedParameter::Swagger::Types::DateType
TypedParameter::Swagger::Types.register :DateTime, TypedParameter::Swagger::Types::DateTimeType
TypedParameter::Swagger::Types.register :Boolean, TypedParameter::Swagger::Types::BooleanType
