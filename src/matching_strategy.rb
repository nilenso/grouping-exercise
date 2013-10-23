class MatchingStrategy
  def initialize(config)
    @attribute = config[:attribute]
  end
  
  def match?(first, second)
    first.get(@attribute) == second.get(@attribute)
  end
  
  def key_for(first, second)
    "#{first.get(@attribute)}#{second.get(@attribute)}"
  end
end