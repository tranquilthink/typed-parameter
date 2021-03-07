# frozen_string_literal: true

module TypedParameter
  module Constraints
    class DatetimeConstraint < Base
      def self.value(value)
        value.to_datetime
      end
    end
  end
end
