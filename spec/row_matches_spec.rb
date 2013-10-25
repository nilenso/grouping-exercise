require 'spec_helper'
require 'csv'

describe RowMatches do
  context "when converting to CSV" do
    it "returns a CSV object with the appropriate headers" do
      row = Row.new("Email" => "foo@bar.com")
      matches = RowMatches.new([row])
      csv = matches.to_csv
      CSV.parse(csv).first.should == ["Email", "ID"]
    end

    it "returns a CSV object with the appropriate values" do
      row = Row.new("Email" => "foo@bar.com")
      matches = RowMatches.new([row])
      csv = matches.to_csv
      CSV.parse(csv).last.should include "foo@bar.com"
    end

    context "when setting the group ID" do
      it "sets a 32-character string" do
        row = Row.new("Email" => "foo@bar.com")
        matches = RowMatches.new([row])
        csv = matches.to_csv
        row_csv = CSV.parse(csv).last
        row_csv.last.size.should == 32

      end

      it "sets a unique string if the row isn't part of a match" do
        first_row = Row.new("Email" => "foo@bar.com")
        second_row = Row.new("Email" => "baz@bar.com")
        matches = RowMatches.new([first_row, second_row])
        csv = matches.to_csv
        first_row_csv, second_row_csv = CSV.parse(csv).last(2)
        first_row_csv.last.should_not == second_row_csv.last
      end

      it "sets the match key if the row is part of a match" do
        first_row = Row.new("Email" => "foo@bar.com")
        second_row = Row.new("Email" => "baz@bar.com")
        matches = RowMatches.new([first_row, second_row])
        matches.add_match(first_row, second_row)
        csv = matches.to_csv
        first_row_csv, second_row_csv = CSV.parse(csv).last(2)
        first_row_csv.last.should == second_row_csv.last
      end
    end
  end

  context "when generating a key for a match" do
    it "generates the same string for a pair of matching rows" do
      first_row = Row.new('Email' => "foo@foo.com")
      second_row = Row.new('Email' => "foo@foo.com")
      matches = RowMatches.new([first_row, second_row])
      matches.add_match(first_row, second_row)
      matches.to_hash[first_row].should == matches.to_hash[second_row]
    end

    it "generates the same string for a trio of rows - when the 1st and 2nd match, the 2nd and 3rd match, but the 1st and 3rd do not match" do
      first_row = Row.new('Email1' => "foo@foo.com")
      second_row = Row.new('Email1' => "foo@foo.com", 'Email2' => "foo@bar.com")
      third_row = Row.new('Email1' => "foo@bar.com")
      matches = RowMatches.new([first_row, second_row, third_row])
      matches.add_match(first_row, second_row)
      matches.add_match(second_row, third_row)
      matches.to_hash[first_row].should == matches.to_hash[second_row]
      matches.to_hash[third_row].should == matches.to_hash[second_row]
    end
  end
end
