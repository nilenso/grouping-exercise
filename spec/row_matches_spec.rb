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
        matches.add_match("thisisakey", [first_row])
        csv = matches.to_csv
        CSV.parse(csv).last(2).should include ["foo@bar.com", "thisisakey"]
      end
    end
  end
end
