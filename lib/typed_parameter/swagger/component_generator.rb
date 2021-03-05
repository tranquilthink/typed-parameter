module TypedParameter
  module Swagger
    module ComponentGenerator
      class << self
        def generate(parameter_class)
          key = parameter_class.key
          properties = Swagger::PropertyGenerator.generate(parameter_class.swagger_properties)

          { "#{key}": { type: :object, properties: properties } }
        end
      end
    end
  end
end
