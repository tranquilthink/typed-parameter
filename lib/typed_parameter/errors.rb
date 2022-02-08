module TypedParameter
  class Error < StandardError; end

  class RequiredFieldError < Error; end

  class EnumFieldError < Error; end

  class InvalidBlockParameter < Error; end
end
