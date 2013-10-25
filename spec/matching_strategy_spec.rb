require 'spec_helper'

describe MatchingStrategy do
  context "matching" do
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
        strategy.match?(first_row, second_row).should be_false
      end
    end

    context "while matching using aliases" do
      it "matches two rows which share a value across the alias fields" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email1' => "foo@bar.com")
        second_row = Row.new('Email2' => "foo@bar.com")
        strategy.match?(first_row, second_row).should be_true
      end
    end
  end

  context "when checking if a matching type is invalid" do
    it "returns false if the matching type is valid" do
      allow(MatchingStrategy).to receive(:strategies).and_return({})
      MatchingStrategy.invalid_matching_type?('bar').should be_true
    end

    it "returns true if the matching type is invalid" do
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new("Foo"))
      allow(MatchingStrategy).to receive(:strategies).and_return({'foo' => strategy})
      MatchingStrategy.invalid_matching_type?('foo').should be_false
    end
  end
end
