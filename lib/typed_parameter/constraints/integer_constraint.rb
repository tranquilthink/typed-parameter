# frozen_string_literal: true

module TypedParameter
  module Constraints
    class IntegerConstraint < Base
      def self.value(value)
        value.to_i
      end
    end
  end
end
