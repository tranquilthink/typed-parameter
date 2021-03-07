# frozen_string_literal: true

module TypedParameter
  module Constraints
    class StringConstraint < Base
      def self.value(value)
        value.to_s
      end
    end
  end
end
