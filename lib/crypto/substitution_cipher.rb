module Crypto
  class SubstitutionCipher
    attr_reader :mapping

    def self.random_mapping
      Hash[(("A".."Z").to_a).zip(("A".."Z").to_a.shuffle)]
    end

    def initialize(mapping = SubstitutionCipher.random_mapping)
      @mapping = mapping
    end

    def encrypt(plain_text)
      plain_text.each_char.map { |c| mapping[c] || c }.join
    end

    def decrypt(cipher_text)
      cipher_text.each_char.map { |c| mapping.invert[c] || c }.join
    end
  end
end