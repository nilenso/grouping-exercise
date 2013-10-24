require 'digest/md5'

class MatchingStrategy
  def initialize(config)
    @matching_attribute = config[:attribute]
  end

  def self.new_with_type(type)
    strategies[type]
  end

  def self.invalid_matching_type?(type)
    !strategies.keys.include?(type)
  end

  def match(first_row, second_row)
    first_row_keys = @matching_attribute.keys.map { |key| first_row.get(key) }
    second_row_keys = @matching_attribute.keys.map { |key| second_row.get(key) }

    first_row_keys.product(second_row_keys).each do |first_row_key, second_row_key|
      if !first_row_key.nil? && !first_row_key.empty? && first_row_key == second_row_key
        return key_for(first_row_key, second_row_key)
      end
    end

    return false
  end

  private

  def key_for(first, second)
    Digest::MD5.hexdigest("#{first}#{second}")
  end

  def self.strategies
    {
      'same_email' => MatchingStrategy.new(attribute: MatchingAttribute.new('Email', aliases: ['Email1', 'Email2']))
    }
  end
end
