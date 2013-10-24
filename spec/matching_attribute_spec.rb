require 'spec_helper'

describe MatchingAttribute do
  context "when fetching all keys for the attribute" do
    it "returns the primary key as well as the aliases" do
      matching_attribute = MatchingAttribute.new("name", aliases: ["first_name", "last_name"])
      matching_attribute.keys.should =~ ["name", "first_name", "last_name"]
    end
  end
end
