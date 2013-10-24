require 'spec_helper'
require 'csv'

describe RowMatches do
  context "when converting to CSV" do
    it "returns a CSV object with the appropriate headers" do
      row = Row.new("Email" => "foo@bar.com")
      matches = RowMatches.new([row])
      csv = matches.to_csv
      CSV.parse(csv).first.should == ["Email"]
    end

    it "returns a CSV object with the appropriate values" do
      row = Row.new("Email" => "foo@bar.com", "Name" => "Homer")
      matches = RowMatches.new([row])
      csv = matches.to_csv
      CSV.parse(csv).should == [["Email", "Name"], ["foo@bar.com", "Homer"]]
    end
  end
end
