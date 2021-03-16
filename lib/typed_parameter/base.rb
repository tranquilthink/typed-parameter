module TypedParameter
  class Base
    class << self
      def field(name, type, **kargs)
        initialize_constraints(name, type, kargs)
        initialize_swagger_properties(name, type, kargs)
      end

      def permit(params)
        raise Error::ParameterError unless params.class <= ActionController::Parameters

        use_constraints(params).permit!
      end

      def swagger_properties
        __swagger_properties.freeze
      end

      def swagger_requirements
        __swagger_requirements.freeze
      end

      def constraints
        __constraints.freeze
      end

      alias key name

      def ref
        "#/components/schemas/#{key}"
      end

      private

      def initialize_swagger_properties(name, type, kargs)
        swagger_type = TypedParameter::Swagger::TypeGenerator.generate(type)
        swagger_options = swagger_type.merge(kargs.slice(:enum, :description))
        __swagger_properties[name] = swagger_options
        __swagger_requirements << name if kargs[:required]
      end

      def initialize_constraints(name, type, kargs)
        options = kargs.slice(:enum, :required)
        options[:enum] = options[:enum].map(&:to_s) if options[:enum]
        __constraints << [name, type, options]
      end

      def use_constraints(params)
        typed_params = ActionController::Parameters.new

        __constraints.each do |name, type, options|
          value = params[name]
          if options[:required] && (value.nil? || value == '' || (value.is_a?(Array) && value.empty?))
            raise Error::RequiredFieldError, "(#{self.name}) #{name} is required"
          end
          next unless value.present?

          typed_params[name] = TypeConstraint.value(type, value)
          typed_params[name] = EnumConstraint.value(value, options[:enum]) if options[:enum]
        end

        typed_params
      end

      def __constraints
        @__constraints ||= []
      end

      def __swagger_requirements
        @__swagger_requirements ||= []
      end

      def __swagger_properties
        @__swagger_properties ||= {}
      end
    end
  end
end
