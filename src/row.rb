class Row
  def initialize(attributes)
    @attributes = attributes
  end

  def get(attribute_name)
    @attributes[attribute_name]
  end

  def to_a
    @attributes.values
  end

  def headers
    @attributes.keys
  end
end
