module TypedParameter
  module ParameterTypes
    class << self
      def register(type)
        @types ||= []
        @types << type
      end

      def types
        @types.freeze
      end
    end
  end
end

TypedParameter::ParameterTypes.register Integer
TypedParameter::ParameterTypes.register String
TypedParameter::ParameterTypes.register Float
TypedParameter::ParameterTypes.register Date
TypedParameter::ParameterTypes.register DateTime
TypedParameter::ParameterTypes.register Boolean
