require "spec_helper"
require "benchmark"

module Crypto
  describe Dictionary do
    describe "#initialize" do
      it "takes a list of words as a parameter" do
        dictionary = Dictionary.new(["MY", "WORDS"])
        dictionary.words.to_a.should =~ ["MY", "WORDS"]
      end

      it "loads data/2of4brif.txt if no words list is provided" do
        dictionary = Dictionary.new
        dictionary.words.size.should > 50_000
      end

      it "default words list doesn't include newlines" do
        dictionary = Dictionary.new
        dictionary.words.first.should_not match(/\n$/)
      end
    end

    describe "#words_by_pattern" do
      it "returns all words for the given pattern" do
        dictionary = Dictionary.new(["NAN", "BAB", "BED"])
        dictionary.words_by_pattern("ABA").should =~ ["NAN", "BAB"]
      end

      it "returns an empty array if there are no matches" do
        Dictionary.new([]).words_by_pattern("A").should == []
      end
    end

    describe "#present?" do
      it "returns true if the word exists" do
        dictionary = Dictionary.new(["WORD"])
        dictionary.should be_present("WORD")
      end

      it "should be fast" do
        # Falls on it's face super hard if words list implemented as an array
        dictionary = Dictionary.new
        time = Benchmark.realtime { 10.times { dictionary.present?("") } }
        time.should < 0.001
      end
    end

    describe "#englishity" do
      it "returns the percentage of words that are in the dictionary" do
        dictionary = Dictionary.new(["MY", "WORD"])
        dictionary.englishity("MY WORD TOO MUCH").should == 0.5
      end
    end
  end
end
