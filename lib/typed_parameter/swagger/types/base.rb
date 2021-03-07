# frozen_string_literal: true

module TypedParameter
  module Swagger
    module Types
      class Base
        def self.value
          raise NotImplementedError, 'You need to implement this method'
        end
      end
    end
  end
end
