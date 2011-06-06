require "set"

module Crypto
  class Dictionary
    attr_reader :words

    WORDS_FILE = File.join(File.dirname(__FILE__), "..", "..", "data", "2of4brif.txt")

    def initialize(words = nil)
      words = File.open(WORDS_FILE).map(&:strip) if words.nil?
      @words = words.to_set
    end

    def words_by_pattern(pattern)
      @words_by_pattern ||= @words.group_by(&:letter_pattern)
      @words_by_pattern[pattern] || []
    end

    def present?(word)
      @words.include?(word)
    end

    def englishity(text)
      text_words = text.split(/ +/)
      text_words.select { |w| present?(w) }.size.to_f / text_words.size
    end

    def inspect
      # Don't spew every word
      "Dictionary with #{words.size} words"
    end
  end
end
