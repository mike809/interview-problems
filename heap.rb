#!/usr/bin/env ruby

class Heap
  def initialize(type)
    @type = type == :max ? :> : :<
    @elements = [nil]
  end

  def size 
    @elements.size
  end

  def root
    @elements[1]
  end

  def empty?
    @elements.empty?
  end

  def pop
    # # exchange the root with the last element
    exchange(1, @elements.size - 1)
    # # remove the last element of the list
    max = @elements.pop
    # # and make sure the tree is ordered again
    bubble_down(1)
    max
  end

  def <<(element)
    @elements << element
    # bubble up the element that we just added
    bubble_up(@elements.size - 1)
  end

  def bubble_down(index)
    child_index = (index * 2)
    # stop if we reach the bottom of the tree
    return if child_index > @elements.size - 1
    # make sure we get the largest child
    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element.send(@type, left_element)
    # there is no need to continue if the parent element is already bigger than its children
    return if @elements[index].send(@type, @elements[child_index]) || @elements[index] == @elements[child_index]
    
    exchange(index, child_index)
    # repeat the process until we reach a point where the parent
    # is larger than its children
    bubble_down(child_index)
  end

  def bubble_up(index)
    parent_index = (index / 2)
    # return if we reach the root element
    return if index <= 1
    # or if the parent is already greater than the child
    return if @elements[parent_index].send(@type, @elements[index]) || @elements[parent_index] == @elements[index]
    # otherwise we exchange the child with the parent
    exchange(index, parent_index)
    # and keep bubbling up
    bubble_up(parent_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end
end

def insert_in_correct_heap(number, min_heap, max_heap)
  if max_heap.size < 2
    max_heap << number
    return 
  end
  
  if number < max_heap.root
    max_heap << number
  else
    min_heap << number
  end
end

def balance_heaps(min_heap, max_heap)
  if (max_heap.size - min_heap.size).abs > 1
    if max_heap.size > min_heap.size
      min_heap << max_heap.pop
    else
      max_heap << min_heap.pop
    end
  end
end

def median(min_heap, max_heap)
  return min_heap.root if min_heap.size > max_heap.size
  return max_heap.root if min_heap.size < max_heap.size

  (max_heap.root + min_heap.root)/2
end

n = gets.strip.to_i
max_heap = Heap.new(:max)
min_heap = Heap.new(:min)

n.times do 
  a = gets.strip.to_f
  insert_in_correct_heap(a, min_heap, max_heap)
  balance_heaps(min_heap, max_heap)
  puts median(min_heap, max_heap)
end
