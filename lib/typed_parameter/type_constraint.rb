module TypedParameter
  module TypeConstraint
    class << self
      def value(type, value)
        type_class = [type].flatten.first
        array_type = type.is_a?(Array)
        parameter_type = type_class < TypedParameter::Base

        if parameter_type
          array_type ? parameter_array(type_class, value) : type.permit(value)
        else
          constraint = "TypedParameter::Constraints::#{type_class}Constraint".safe_constantize
          constraint ||= TypedParameter::Constraints::StringConstraint # Default

          array_type ? constraint_array(constraint, value) : constraint.value(value)
        end
      end

      def parameter_array(parameter_class, values)
        values.map { |value| parameter_class.permit(value) }
      end

      def constraint_array(constraint, values)
        values.map { |value| constraint.value(value) }
      end
    end
  end
end
