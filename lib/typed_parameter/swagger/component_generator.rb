module TypedParameter
  module Swagger
    module ComponentGenerator
      class << self
        def generate(parameter_class)
          key = parameter_class.key
          properties = Swagger::PropertyGenerator.generate(parameter_class.swagger_properties)

          { "#{key}": { type: :object, properties: properties } }
        end

        def generate_all!
          parameter_classes = TypedParameter::Base.descendants.reject { |c| c.fields.empty? }

          parameter_classes.reduce({}) { |prev, curr| prev.merge(generate(curr)) }
        end
      end
    end
  end
end
