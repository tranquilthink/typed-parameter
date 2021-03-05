module TypedParameter
  module PermitFieldGenerator
    class << self
      BASE_TYPES = TypedParameter::ParameterTypes::BASE_TYPES

      def generate(name, type)
        props = generate_properties(type)

        props = [] if type.is_a?(Array) && type[0].in?(BASE_TYPES)
        return name unless props

        [[name, props]].to_h
      end

      def generate_properties(type)
        return if type.in? BASE_TYPES
        return generate_properties(type[0]) if type.is_a? Array
        return type.keys if type.is_a? Hash

        type.fields
      end
    end
  end
end
