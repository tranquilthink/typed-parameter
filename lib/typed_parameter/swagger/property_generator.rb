module TypedParameter
  module Swagger
    module PropertyGenerator
      class << self
        def generate(swagger_properties)
          swagger_properties.transform_values do |options|
            next { "$ref": ref(options[:ref]) } if options[:ref].present?

            if options[:type] == :array
              items = options[:items].dup
              if items[:ref].present?
                ref = items.delete(:ref)
                items['$ref'] = ref(ref)
                options[:items] = items
              end
            end

            options
          end
        end

        def ref(ref_component)
          "#/components/schemas/#{ref_component.key}"
        end
      end
    end
  end
end
