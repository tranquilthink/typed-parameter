return if defined? Boolean

class Boolean; end

class TrueClass
  def is_a?(type)
    type == Boolean || super(type)
  end
end

class FalseClass
  def is_a?(type)
    type == Boolean || super(type)
  end
end
