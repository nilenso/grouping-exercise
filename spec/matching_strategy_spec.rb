require 'spec_helper'

describe MatchingStrategy do
  context "matching" do
    context "while matching by email" do
      it "matches two rows which have the same value for an attribute" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@foo.com")
        strategy.match(first_row, second_row).should_not be_nil
      end

      it "doesn't match two rows which have different values for the same attribute" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@bar.com")
        strategy.match(first_row, second_row).should be_false
      end
    end

    context "while matching using aliases" do
      it "matches two rows which share a value across the alias fields" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email1' => "foo@bar.com")
        second_row = Row.new('Email2' => "foo@bar.com")
        strategy.match(first_row, second_row).should_not be_nil
      end
    end

    context "when returning a key for a match" do
      it "generates a 32-character random string" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@foo.com")
        strategy.match(first_row, second_row).length.should == 32
      end

      it "generates the same string for the same pair of rows" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@foo.com")
        strategy.match(first_row, second_row).should == strategy.match(first_row, second_row)
      end

      it "generates a different string for a different pair of rows" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@foo.com")
        third_row = Row.new('Email' => "foo@baz.com")
        fourth_row = Row.new('Email' => "foo@baz.com")
        strategy.match(first_row, second_row).should_not == strategy.match(third_row, fourth_row)
      end

      it "generates the same string when the order of the pair is reversed" do
        strategy = MatchingStrategy.new_with_type('same_email')
        first_row = Row.new('Email' => "foo@foo.com")
        second_row = Row.new('Email' => "foo@foo.com")
        strategy.match(first_row, second_row).should == strategy.match(second_row, first_row)
      end
    end
  end
end
