#!/usr/bin/env ruby

def xor_cipher(cleartext, key)
  key_bytes = key.bytes.to_a
  cipher_bytes = []
  cleartext.bytes.each_with_index do |byte, i|
    cipher_bytes << (byte ^ key_bytes[i % key_bytes.size])
  end
  cipher_bytes.map(&:chr).join
end

key_length = 6

captured_message = File.open('captured_message', 'r:ascii-8bit') { |f| f.read }

grouped_bytes = captured_message.bytes.group_by.with_index { |byte, i| i % key_length }

key_bytes = grouped_bytes.collect { |key_byte, bytes| bytes.group_by{ |i| i }.max { |a,b| a[1].length <=> b[1].length }.first }

# assume space is used and is the most common
key = key_bytes.collect { |b| b ^ 32 }.collect(&:chr).join

puts xor_cipher(captured_message, key)
