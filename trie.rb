#!/usr/bin/env ruby
require 'pry'

def add(name, contacts)
  current_char = contacts
  name.each_char do |char|
    current_char[char] = {count: 0} unless current_char.has_key?(char)
    current_char[char][:count] += 1
    current_char = current_char[char]
  end
  current_char['.'] = {}
end

def find(name, contacts)
  current_char = contacts
  name.each_char do |char|
    unless current_char.has_key?(char)
      puts 0 
      return
    end
    current_char = current_char[char]
  end
  puts current_char[:count]
end

contacts = Hash.new
n = gets.strip.to_i
for a0 in (0..n-1)
  op,contact = gets.strip.split(' ')
  send(op, contact, contacts)
end
