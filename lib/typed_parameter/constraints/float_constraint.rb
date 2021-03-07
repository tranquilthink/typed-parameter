# frozen_string_literal: true

module TypedParameter
  module Constraints
    class FloatConstraint < Base
      def self.value(value)
        value.to_f
      end
    end
  end
end
