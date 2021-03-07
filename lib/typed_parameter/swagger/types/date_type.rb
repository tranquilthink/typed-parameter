# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class DateType < Base
        def self.value
          { type: :string, format: :date }
        end
      end
    end
  end
end
