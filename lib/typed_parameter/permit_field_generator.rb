module TypedParameter
  module PermitFieldGenerator
    class << self
      def generate(name, type)
        type_class = [type].flatten.first

        props = if type.is_a? Array
                  type_class.in?(TypedParameter::ParameterTypes.types) ? [] : generate_properties(type_class)
                else
                  generate_properties(type_class)
                end

        props ? [[name, props]].to_h : name
      end

      def generate_properties(type)
        return if type.in? TypedParameter::ParameterTypes.types
        return type.keys if type.is_a? Hash

        type.fields
      end
    end
  end
end
