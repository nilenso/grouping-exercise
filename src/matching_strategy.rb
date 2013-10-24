class MatchingStrategy
  def initialize(config)
    @matching_attribute = config[:attribute]
  end

  def match?(first, second)
    first.get(@matching_attribute.key) == second.get(@matching_attribute.key)
  end

  def key_for(first, second)
    "#{first.get(@matching_attribute.key)}#{second.get(@matching_attribute.key)}"
  end
end
