class String
    def letter_pattern
      alphabet = ("A".."Z").to_enum
      mapping = { }

      pattern = each_char.map do |letter|
        mapping[letter] ||= alphabet.next
      end

      pattern.join
    end
end
