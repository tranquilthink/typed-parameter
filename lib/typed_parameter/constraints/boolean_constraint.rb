# frozen_string_literal: true

module TypedParameter
  module Constraints
    class BooleanConstraint < Base
      TRUE_VALUES  = [true, 'true', '1', 1].freeze
      FALSE_VALUES = [false, 'false', '0', 0].freeze

      def self.value(value)
        return true if TRUE_VALUES.include?(value)
        return false if FALSE_VALUES.include?(value)
      end
    end
  end
end
