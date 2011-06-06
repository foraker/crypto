require "spec_helper"

module Crypto
  describe SubstitutionCipher do
    describe "self.mappings" do
      subject { SubstitutionCipher.random_mapping }

      it "has 26 mappings" do
        subject.size.should == 26
      end

      it "contains each of the 26 uppercase letters as keys" do
        subject.keys.should =~ ("A".."Z").to_a
      end

      it "contains each of the 26 uppercase letters as values" do
        subject.keys.should =~ ("A".."Z").to_a
      end

      it "does not map letters to themselves" do
        subject.keys.should_not == subject.values.to_a
      end
    end

    describe "#initialize" do
      it "takes a mapping" do
        mapping = SubstitutionCipher.random_mapping
        cipher = SubstitutionCipher.new(mapping)
        cipher.mapping.should == mapping
      end

      it "generates a random mapping if none is provided" do
        mapping = SubstitutionCipher.random_mapping
        SubstitutionCipher.stub(:random_mapping).and_return(mapping)
        SubstitutionCipher.new.mapping.should == mapping
      end
    end

    describe "#encrypt" do
      it "returns a substituted message" do
        cipher = SubstitutionCipher.new({"A" => "B", "C" => "D"})
        cipher.encrypt("AC").should == "BD"
      end

      it "does not doubly encrypt letters" do
        # This type of thing happens if you repeatedly gsub and overwite previous encryptions
        cipher = SubstitutionCipher.new({"A" => "B", "B" => "C"})
        cipher.encrypt("AB").should == "BC"
      end

      it "doesn't modify characters not present in the mappings" do
        cipher = SubstitutionCipher.new({})
        cipher.encrypt("A").should == "A"
      end
    end

    describe "#decrypt" do
      it "returns an unsubstitued message" do
        cipher = SubstitutionCipher.new({"A" => "B", "C" => "D"})
        cipher.decrypt("BD").should == "AC"
      end

      it "does not re-encrypt letters" do
        # This type of thing happens if you repeatedly gsub and overwite previous encryptions
        cipher = SubstitutionCipher.new({"A" => "B", "B" => "C"})
        cipher.decrypt("BC").should == "AB"
      end

      it "does not modify characters not present in the mappings" do
        cipher = SubstitutionCipher.new({})
        cipher.decrypt("A").should == "A"
      end
    end

    describe "sanity" do
      it "decrypt(encrypt(text)) == text" do
        text = "Only one thing is impossible for God: To find any sense in any copyright law on the planet." # Mark Twain
        cipher = SubstitutionCipher.new
        cipher.decrypt(cipher.encrypt(text)).should == text
      end
    end
  end
end