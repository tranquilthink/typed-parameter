# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class StringType < Base
        def self.value
          { type: :string }
        end
      end
    end
  end
end
