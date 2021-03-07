# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class IntegerType < Base
        def self.value
          { type: :integer }
        end
      end
    end
  end
end
