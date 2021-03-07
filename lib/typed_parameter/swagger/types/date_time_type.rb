# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class DateTimeType < Base
        def self.value
          { type: :string, format: :datetime }
        end
      end
    end
  end
end
