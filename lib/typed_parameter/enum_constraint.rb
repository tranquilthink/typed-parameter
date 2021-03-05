module TypedParameter
  module EnumConstraint
    def self.value(value, enums)
      enums = enums.map(&:to_s) if value.is_a? String
      raise ArgumentError, "#{value} must be in #{enums.join(', ')}" unless value.in? enums

      value
    end
  end
end
