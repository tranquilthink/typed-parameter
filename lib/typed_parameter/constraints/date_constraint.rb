# frozen_string_literal: true

module TypedParameter
  module Constraints
    class DateConstraint < Base
      def self.value(value)
        value.to_date
      end
    end
  end
end
