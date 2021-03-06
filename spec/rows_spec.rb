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

    it "creates a Row for each record in the CSV" do
      csv = CSV.open("spec/fixtures/test.csv")
      rows = Rows.new.import_from_csv(csv)
      rows.to_a.map(&:class).uniq.should == [Row]
    end

    it "populates each row with data from the CSV" do
      csv = CSV.open("spec/fixtures/single.csv")
      rows = Rows.new.import_from_csv(csv)
      row = rows.to_a.first
      row.get('A').should == "Foo"
    end
  end

  context "when looking for matching rows" do
    it "returns a RowMatches object" do
      csv = CSV.open("spec/fixtures/matching_two.csv")
      rows = Rows.new.import_from_csv(csv)
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new('Email'))
      matches = rows.match_by(strategy)
      matches.class.should == RowMatches
    end

    it "groups two matching rows together" do
      csv = CSV.open("spec/fixtures/matching_two.csv")
      rows = Rows.new.import_from_csv(csv)
      first_row, second_row, _ = rows.to_a
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new('Email'))
      matches = rows.match_by(strategy).to_hash
      matches[first_row].should == matches[second_row]
    end

    it "groups three matching rows together" do
      csv = CSV.open("spec/fixtures/matching_three.csv")
      rows = Rows.new.import_from_csv(csv)
      first_row, second_row, third_row = rows.to_a
      strategy = MatchingStrategy.new(attribute: MatchingAttribute.new('Email'))
      matches = rows.match_by(strategy).to_hash
      matches[first_row].should == matches[second_row]
      matches[third_row].should == matches[second_row]
    end
  end
end
