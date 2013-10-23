require 'spec_helper'
require 'csv'

describe Rows do
  context "when importing from a CSV file" do
    it "returns a `Rows` object" do
      csv = CSV.open("spec/fixtures/test.csv")
      Rows.new.import_from_csv(csv).class.should == Rows
    end
    
    it "contains every record in the CSV file except the header" do
      csv = CSV.open("spec/fixtures/test.csv")
      rows = Rows.new.import_from_csv(csv)
      rows.size.should == 8
    end
  end
end
