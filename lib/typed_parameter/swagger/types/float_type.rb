# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class FloatType < Base
        def self.value
          { type: :number, format: :float }
        end
      end
    end
  end
end
