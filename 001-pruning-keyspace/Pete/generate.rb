#!/usr/bin/env ruby

class Keygen
  include Enumerable

  def initialize
    @index = {}
    %w(1 2 3 4 5 6 7 8 9 A B C D E F).permutation(2).map(&:join).each do |pair|
      @index[pair] = case pair
      when /\d\d/       then  %w(A B C D E F)
      when /[A-F]{2}/   then  %w(1 2 3 4 5 6 7 8 9)
      else                    %w(1 2 3 4 5 6 7 8 9 A B C D E F) - [pair[-1]]
      end
    end
  end

  def each(&block)
    @index.keys.each { |key| generate(key, &block) }
  end

protected

  def generate(base, &block)
    @index[base[-2..-1]].each do |suffix|
      key = "#{base}#{suffix}"
      if key.size >= 8
        yield key
      else
        generate(key, &block)
      end
    end
  end

end

Keygen.new.each { |key| puts key }

