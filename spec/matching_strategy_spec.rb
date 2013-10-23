require 'spec_helper'

describe MatchingStrategy do
  context "while matching by email" do
    it "matches two rows which have the same value for an attribute" do
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new('email'))
      first_row = Row.new('email' => "foo@foo.com")
      second_row = Row.new('email' => "foo@foo.com")
      strategy.match?(first_row, second_row).should be_true
    end
    
    it "doesn't match two rows which have different values for the same attribute" do
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new('email'))
      first_row = Row.new('email' => "foo@foo.com")
      second_row = Row.new('email' => "foo@bar.com")
      strategy.match?(first_row, second_row).should_not be_true
    end
  end
end