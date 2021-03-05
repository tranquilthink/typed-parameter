return if defined? Boolean

class Boolean; end

class TrueClass
  def is_a?(type)
    return true if type == Boolean

    super(type)
  end
end

class FalseClass
  def is_a?(type)
    return true if type == Boolean

    super(type)
  end
end
