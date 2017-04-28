#!/usr/bin/env ruby

def is_balanced?(expression)
    stack = []
    symbols = { 
        '}' => '{', 
        ']' => '[', 
        ')' => '(' 
    }
    
    expression.each_char do |character|
        if %w.{ ( [..include?(character)
            stack << character
        else
            if stack.last == symbols[character]
                stack.pop
            else
                return false
            end
        end
    end
    stack.empty?
end

t = gets.strip.to_i
for a0 in (0..t-1)
    expression = gets.strip
    puts is_balanced?(expression) ? 'YES' : 'NO'
end
