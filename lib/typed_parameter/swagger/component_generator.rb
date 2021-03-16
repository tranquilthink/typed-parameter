module TypedParameter
  module Swagger
    module ComponentGenerator
      class << self
        def generate(parameter_class)
          key = parameter_class.key
          properties = Swagger::PropertyGenerator.generate(parameter_class.swagger_properties)

          swagger = { type: :object, properties: properties }
          swagger[:required] = parameter_class.swagger_requirements if parameter_class.swagger_requirements.present?
          { "#{key}": swagger }
        end

        def generate_all!
          parameter_classes = TypedParameter::Base.descendants.reject { |c| c.swagger_properties.empty? }

          parameter_classes.reduce({}) { |prev, curr| prev.merge(generate(curr)) }
        end
      end
    end
  end
end
