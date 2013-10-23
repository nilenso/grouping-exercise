class Row
  def initialize(attributes)
    @attributes = attributes
  end
  
  def get(attribute_name)
    @attributes[attribute_name]
  end
end