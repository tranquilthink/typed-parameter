# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class BooleanType < Base
        def self.value
          { type: :boolean }
        end
      end
    end
  end
end
