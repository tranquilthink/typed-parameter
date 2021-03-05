# frozen_string_literal: true

module TypedParameter
  class Constraints
    def self.value(_v)
      nil
    end

    class IntegerConstraint < self
      def self.value(value)
        value.to_i
      end
    end

    class FloatConstraint < self
      def self.value(value)
        value.to_f
      end
    end

    class StringConstraint < self
      def self.value(value)
        value.to_s
      end
    end

    class BooleanConstraint < self
      TRUE_VALUES  = [true, 'true', '1', 1].freeze
      FALSE_VALUES = [false, 'false', '0', 0].freeze

      def self.value(value)
        return true if TRUE_VALUES.include?(value)
        return false if FALSE_VALUES.include?(value)
      end
    end

    class DateConstraint < self
      def self.value(value)
        value.to_date
      end
    end

    class DateTimeConstraint < self
      def self.value(value)
        value.to_datetime
      end
    end
  end
end
