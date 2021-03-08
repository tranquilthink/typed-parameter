module TypedParameter
  module TypeConstraint
    class << self
      def value(type, value)
        type_class = [type].flatten.first

        if type_class < TypedParameter::Base
          type.is_a?(Array) ? parameter_array(type_class, value) : type.permit(value)
        else
          constraint = TypedParameter::Constraints[type_class.name.to_sym]
          constraint ||= TypedParameter::Constraints::StringConstraint # Default

          type.is_a?(Array) ? constraint_array(constraint, value) : constraint.value(value)
        end
      end

      private

      def parameter_array(parameter_class, values)
        values.map { |value| parameter_class.permit(value) }
      end

      def constraint_array(constraint, values)
        values.map { |value| constraint.value(value) }
      end
    end
  end
end
