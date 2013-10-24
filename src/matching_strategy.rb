require 'digest/md5'

class MatchingStrategy
  def initialize(config)
    @matching_attribute = config[:attribute]
  end

  def self.new_with_type(type)
    strategies[type]
  end

  def match?(first, second)
    first_key = first.get(@matching_attribute.key)
    second_key = second.get(@matching_attribute.key)

    if first_key.nil? || first_key.empty?
      false
    else
      first_key == second_key
    end
  end

  def key_for(first, second)
    first_key = first.get(@matching_attribute.key)
    second_key = second.get(@matching_attribute.key)
    Digest::MD5.hexdigest("#{first_key}#{second_key}")
  end

  private

  def self.strategies
    { 'same_email' => MatchingStrategy.new(attribute: MatchingAttribute.new('Email')) }
  end
end
