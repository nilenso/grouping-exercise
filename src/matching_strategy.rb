class MatchingStrategy
  def initialize(config)
    @matching_attribute = config[:attribute]
  end

  def self.new_with_type(type)
    strategies[type]
  end

  def match?(first, second)
    first.get(@matching_attribute.key) == second.get(@matching_attribute.key)
  end

  def key_for(first, second)
    "#{first.get(@matching_attribute.key)}#{second.get(@matching_attribute.key)}"
  end

  private

  def self.strategies
    { 'same_email' => MatchingStrategy.new(attribute: MatchingAttribute.new('Email')) }
  end
end
