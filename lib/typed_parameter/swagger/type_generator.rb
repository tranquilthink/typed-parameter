module TypedParameter
  module Swagger
    module TypeGenerator
      class << self
        def generate(type)
          return array_generate(type) if type.is_a? Array
          return hash_generate(type) if type.is_a? Hash

          swagger_type = Swagger::Types[type.name.to_sym]
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
