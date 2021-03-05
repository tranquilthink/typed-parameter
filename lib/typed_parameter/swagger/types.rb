module TypedParameter
  module Swagger
    class Types
      def self.value
        raise NotImplementedError, 'You need to implement this method'
      end

      class IntegerType
        def self.value
          { type: :integer }
        end
      end

      class FloatType
        def self.value
          { type: :number, format: :float }
        end
      end

      class StringType
        def self.value
          { type: :string }
        end
      end

      class BooleanType
        def self.value
          { type: :boolean }
        end
      end

      class DateTimeType
        def self.value
          { type: :string, format: :datetime }
        end
      end

      class DateType
        def self.value
          { type: :string, format: :date }
        end
      end
    end
  end
end
