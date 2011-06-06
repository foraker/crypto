require "spec_helper"

describe String do
  describe ".letter_pattern" do
    it "returns a generic form of the word pattern" do
      "DOG".letter_pattern.should == "ABC"
      "BANK".letter_pattern.should == "ABCD"
    end

    it "uses the same pattern letter for repeated letters" do
      "BOOK".letter_pattern.should == "ABBC"
      "BONGO".letter_pattern.should == "ABCDB"
    end
  end
end

