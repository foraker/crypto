# Ruby on Beer Challenge: Cryptograms

Note: Based heavily on http://www.rubyquiz.com/quiz13.html.

## Goal

Decrypt data/secret_passage.txt before the end of the hour. You are free
to use a combination of programatic and manual techniques.

## Encryption

The secret passage is encrypted using a monoalphabetic substituion
cipher:

[http://en.wikipedia.org/wiki/Substitution_cipher](http://en.wikipedia.org/wiki/Substitution_cipher).

All of the letters are uppercase, and punctuation and numbers were not
encrypted.

Most, but not all, of the words in the attached passage are in the
provided dictionary (see `Dictionary` section of tools).

## Tools

To make this challenge easier, we've provided a few utility classes.

* `SubstitionCipher` handles encryption/decryption. It's constructor
  takes the mapping that should be used to perform the substition. See
  its spec for details.
* `Dictionary` provides a simple interface to check for the presence of
  words in a standard english dictionary (consisting of just over 60,000
  words.
* The String class has been monkey patched to include the
  #letter_pattern method (see the spec for details). 
  `Dictionary#words_by_pattern` returns a list of all words with a given
  pattern.
