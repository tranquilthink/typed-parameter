module TypedParameter
  module EnumConstraint
    def self.value(value, enums)
      return array_value(value, enums) if value.is_a? Array
      return value if value.to_s.in? enums

      raise EnumFieldError, "#{value} must be in #{enums.join(', ')}"
    end

    def self.array_value(values, enums)
      values.each do |value|
        next if value.to_s.in? enums

        raise EnumFieldError, "#{value} must be in #{enums.join(', ')}"
      end

      values
    end
  end
end
