#!/usr/bin/env ruby
require 'pry'
require "minitest/autorun"

# Make a library to:

# read input from a string literal
# print out in the format (See full output below):
# Title: <Title>, Organization: <Organization>, Location: <City>, <State>, Pay: <Min>-<Max>
# always print out sorted by Title
# You should copy the Input section to as a multi-line string literal in your code. When run, the output of your program should match the 'Output' section exactly.

# Feel free to use your IDE/Editor of choice. Once you have it working, please push it to a Github, Bitbucket, etc. repository and send us a link to your work.

# Input:

# Lead Chef, Chipotle, Denver, CO, 10, 15
# Stunt Double, Equity, Los Angeles, CA, 15, 25
# Manager of Fun, IBM, Albany, NY, 30, 40
# Associate Tattoo Artist, Tit 4 Tat, Brooklyn, NY, 250, 275
# Assistant to the Regional Manager, IBM, Scranton, PA, 10, 15
# Lead Guitarist, Philharmonic, Woodstock, NY, 100, 200
# Expected Output:

# All Opportunities
# Title: Assistant to the Regional Manager, Organization: IBM, Location: Scranton, PA, Pay: 10-15
# Title: Associate Tattoo Artist, Organization: Tit 4 Tat, Location: Brooklyn, NY, Pay: 250-275
# Title: Lead Chef, Organization: Chipotle, Location: Denver, CO, Pay: 10-15
# Title: Lead Guitarist, Organization: Philharmonic, Location: Woodstock, NY, Pay: 100-200
# Title: Manager of Fun, Organization: IBM, Location: Albany, NY, Pay: 30-40
# Title: Stunt Double, Organization: Equity, Location: Los Angeles, CA, Pay: 15-25


## TODO Add validations and specs

class Opportunity
  attr_reader :title

  class << self
    @@opportunities = []

    def first
      all.first
    end

    def last
      all.last
    end

    def each_with_index(*args)
      all.each_with_index(args)
    end

    def push(opportunity)
      @@opportunities.push(opportunity)
    end

    def all
      @@opportunities.sort
    end

    def delete_all
      @@opportunities = []
    end
  end

  def initialize(args)
    return unless args.count == 6
    @title = args[0]
    @organization = args[1]
    @location_city = args[2]
    @location_state = args[3]
    @pay_min = args[4]
    @pay_max = args[5]

    self.class.push(self)
  end

  private def location
    "#{@location_city}, #{@location_state}"
  end

  private def pay
    "#{@pay_min}-#{@pay_max}"
  end

  def <=>(other)
    @title <=> other.title
  end

  def output
    "Title: %s, Organization: %s, Location: %s, Pay: %s" % [@title, @organization, location, pay]
  end
end

describe Opportunity do
  let(:input) do
    [
      ['Lead Chef', 'Chipotle', 'Denver', 'CO', 10, 15],
      ['Stunt Double', 'Equity', 'Los Angeles', 'CA', 15, 25],
      ['Manager of Fun', 'IBM', 'Albany', 'NY', 30, 40],
      ['Associate Tattoo Artist', 'Tit 4 Tat', 'Brooklyn', 'NY', 250, 275],
      ['Assistant to the Regional Manager', 'IBM', 'Scranton', 'PA', 10, 15],
      ['Lead Guitarist', 'Philharmonic', 'Woodstock', 'NY', 100, 200]
    ]
  end

  let(:output) do
    [
      'Title: Assistant to the Regional Manager, Organization: IBM, Location: Scranton, PA, Pay: 10-15',
      'Title: Associate Tattoo Artist, Organization: Tit 4 Tat, Location: Brooklyn, NY, Pay: 250-275',
      'Title: Lead Chef, Organization: Chipotle, Location: Denver, CO, Pay: 10-15',
      'Title: Lead Guitarist, Organization: Philharmonic, Location: Woodstock, NY, Pay: 100-200',
      'Title: Manager of Fun, Organization: IBM, Location: Albany, NY, Pay: 30-40',
      'Title: Stunt Double, Organization: Equity, Location: Los Angeles, CA, Pay: 15-25'
    ]
  end

  before do
    input.each do |post|
      Opportunity.new(post)
    end
  end

  after do
    Opportunity.delete_all
  end

  describe 'when we get the output of an opportunity' do
    it 'is correctly formatted' do
      (Opportunity.first.output).must_equal output.first
    end
  end

  describe 'when we get all the outputs' do
    it 'returns a the opportunities in alphabetical order by title' do
      Opportunity.each_with_index do |opportunity, index|
        opportunity.output.must_equal output[index]
      end
    end

    describe 'when we add another opportunity' do
      let(:extra_input) { ['X-Ray Technician', 'Mount Sinai Hospital', 'Manhattan', 'NY', 100, 200] }
      let(:extra_output) { 'Title: X-Ray Technician, Organization: Mount Sinai Hospital, Location: Manhattan, NY, Pay: 100-200' }

      before do
        Opportunity.new(extra_input)
      end

      it 'adds it in the right order' do
        (Opportunity.last.output).must_equal extra_output
      end
    end
  end
end


input = """Lead Chef, Chipotle, Denver, CO, 10, 15
Stunt Double, Equity, Los Angeles, CA, 15, 25
Manager of Fun, IBM, Albany, NY, 30, 40
Associate Tattoo Artist, Tit 4 Tat, Brooklyn, NY, 250, 275
Assistant to the Regional Manager, IBM, Scranton, PA, 10, 15
Lead Guitarist, Philharmonic, Woodstock, NY, 100, 200
"""

input.each_line do |line|
  line = line.chomp.split(', ')
  ## One liner
  puts "Title: %s, Organization: %s, Location: %s, %s, Pay: %s-%s" % line

  ## More complete approach
  puts Opportunity.new(line).output
  puts
end




$memo = { 0 => 1, 1 => 1 }
def fibo(n, memo = { 0 => 1, 1 => 1 })
  return memo[n] if memo.has_key?(n)
  return memo[n] = fibo(n-1, memo) + fibo(n-2, memo)
end












