#!/usr/bin/env ruby

def xor_cipher(cleartext, key)
  key_bytes = key.bytes.to_a
  cipher_bytes = []
  cleartext.bytes.each_with_index do |byte, i|
    cipher_bytes << (byte ^ key_bytes[i % key_bytes.size])
  end
  cipher_bytes.map(&:chr).join
end

input = $stdin.read
key = File.read('key')
print xor_cipher(input, key)

