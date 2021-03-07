# frozen_string_literal: true

module TypedParameter
  module Constraints
    class Base
      def self.value(value)
        raise NotImplementedError, "need to implement"
      end
    end
  end
end
