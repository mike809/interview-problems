require "minitest/autorun"

def flatten(new_array = [], array)
  unless array.is_a?(Array)
    raise ArgumentError.new("wrong argument type #{array.class} (expected Array)")
  end

  array.each do |element|
    if element.is_a?(Array)
      new_array = flatten(new_array, element)
    else
      new_array << element
    end
  end
  new_array
end

describe '#flatten' do
  let(:flat_array) { [2,4,5,6] }

  let(:nested_1_level_array) { [2,4,5,6,[2,4]] }
  let(:nested_1_level_array_result ) { [2,4,5,6,2,4] }

  let(:nested_2_level_array) { [2,4,5,6,[2,4],[[2,4],[45,6]]] }
  let(:nested_2_level_array_result) { [2,4,5,6,2,4,2,4,45,6] }

  let(:flatten_arrays) do
    [[2,4,5,6], [2,4,5,6,2,4], [2,4,5,6,2,4,2,4,45,6]]
  end

  describe "when called with a flat array" do
    it "returns the same array" do
      flatten(flat_array).must_equal flat_array
    end
  end

  describe "when called with a nested 1 level array" do
    it "returns a flattened array" do
      flatten(nested_1_level_array).must_equal nested_1_level_array_result
    end
  end

  describe "when called with a nested 2 level array" do
    it "returns a flattened array" do
      flatten(nested_2_level_array).must_equal nested_2_level_array_result
    end
  end
end
