require 'spec_helper'

describe MatchingStrategy do
  context "while matching by email" do
    it "matches two rows which have the same value for an attribute" do
      strategy = MatchingStrategy.new_with_type('same_email')
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@foo.com")
      strategy.match?(first_row, second_row).should be_true
    end

    it "doesn't match two rows which have different values for the same attribute" do
      strategy = MatchingStrategy.new_with_type('same_email')
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@bar.com")
      strategy.match?(first_row, second_row).should_not be_true
    end
  end

  context "when generating a key for a match" do
    it "generates a 32-character random string" do
      strategy = MatchingStrategy.new_with_type('same_email')
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@bar.com")
      strategy.key_for(first_row, second_row).length.should == 32
    end

    it "generates the same string for the same pair of rows" do
      strategy = MatchingStrategy.new_with_type('same_email')
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@bar.com")
      strategy.key_for(first_row, second_row).should == strategy.key_for(first_row, second_row)
    end

    it "generates a different string for a different pair of rows" do
      strategy = MatchingStrategy.new_with_type('same_email')
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@bar.com")
      third_row = Row.new('Email' => "foo@baz.com")
      strategy.key_for(first_row, second_row).should_not == strategy.key_for(first_row, third_row)
    end
  end
end
