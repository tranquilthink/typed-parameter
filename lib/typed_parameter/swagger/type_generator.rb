module TypedParameter
  module Swagger
    module TypeGenerator
      class << self
        BASE_TYPES = TypedParameter::ParameterTypes::BASE_TYPES
        CUSTOM_TYPES = TypedParameter::ParameterTypes::CUSTOM_TYPES

        def generate(type)
          return array_generate(type) if type.is_a? Array
          return hash_generate(type) if type.is_a? Hash

          swagger_type = "TypedParameter::Swagger::Types::#{type.name}Type".safe_constantize
          swagger_type&.value || { ref: type }
        end

        def hash_generate(hash)
          h = hash.transform_values { |value| generate(value) }

          { type: :object, properties: h }
        end

        def array_generate(type)
          { type: :array, items: generate(type[0]) } 
        end
      end
    end
  end
end
