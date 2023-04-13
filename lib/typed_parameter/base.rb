module TypedParameter
  class Base
    class << self
      def field(name, type, **kargs)
        if block_given? 
          raise Error::InvalidBlockParameter unless [type].flatten[0].in?([Hash, Object])
          
          block_param_name = "#{self.to_s}_Partial_#{name.to_s.camelize}" 
          class_eval("class ::#{block_param_name} < ::TypedParameter::Base; end")
          block_param = block_param_name.constantize
          yield(block_param)

          if type.is_a?(Array)
            target = [block_param]
          else
            target = block_param
          end
        else
          target = type
        end


        initialize_constraints(name, target, kargs)
        initialize_swagger_properties(name, target, kargs)
      end

      def permit(params)
        raise Error, "params class must be ActionController::Parameters" unless params.class <= ActionController::Parameters

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
          raise Error::RequiredFieldError, "(#{self.name}) #{name} is required" if options[:required] && empty_value?(value)

          next unless value.present?

          typed_params[name] = TypeConstraint.value(type, value)
          typed_params[name] = EnumConstraint.value(value, options[:enum]) if options[:enum]
        end

        typed_params
      end

      def empty_value?(value)
        value.nil? || value == '' || (value.is_a?(Array) && value.empty?)
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
