module TypedParameter
  class Base
    class << self
      def field(name, type, **kargs)
        initialize_permitted_fields(name, type)
        initialize_swagger_properties(name, type, kargs)
        initialize_constraints(name, type, kargs)
      end

      def permit(params)
        raise ArgumentError unless params.class <= ActionController::Parameters

        use_constraints params.permit(fields)
      end

      def fields
        __fields.freeze
      end

      def swagger_properties
        __swagger_properties.freeze
      end

      alias key name

      def ref
        "#/components/schemas/#{key}"
      end

      private

      def initialize_swagger_properties(name, type, kargs)
        swagger_type = TypedParameter::Swagger::TypeGenerator.generate(type)
        swagger_options = swagger_type.merge(kargs)
        __swagger_properties[name] = swagger_options
      end

      def initialize_permitted_fields(name, type)
        __fields << PermitFieldGenerator.generate(name, type)
      end

      def initialize_constraints(name, type, kargs)
        options = kargs.slice(:enum, :required)

        __constraints << [name, type, options]
      end

      def use_constraints(params)
        __constraints.each do |name, type, options|
          value = params[name]
          raise RequiredFieldError, "(#{self.name}) #{name} is required" if options[:required] && !value.present?
          next unless value.present?

          params[name] = TypeConstraint.value(type, value)
          params[name] = EnumConstraint.value(value, options[:enum]) if options[:enum]
        end

        params
      end

      def __fields
        @__fields ||= []
      end

      def __constraints
        @__constraints ||= []
      end

      def __swagger_properties
        @__swagger_properties ||= {}
      end
    end
  end
end
