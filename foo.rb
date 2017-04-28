require 'pry'

class Location
    class << self
      @@all_locations = {}
      @@locations = {}

      def locations
        @@locations
      end
    end

    def location_name
      @location_name
    end

    def parent
      @parent
    end

    def initialize(location)
      @location_name = location[:name]
      @parent = location[:parent_id]

      @@all_locations[location[:id]] = self
      unless location[:parent_id].nil?
        @@all_locations[location[:parent_id]].sublocations << self
        if @@all_locations[location[:parent_id]].parent.nil?
          @@locations[location[:parent_id]] = @@all_locations[location[:parent_id]]
        end
      end
    end

    def sublocations
      @_sublocations ||= []
    end

    def to_s(prefix='')
      presentable_name="#{prefix}#{@location_name}"
      sublocations.each do |location|
        presentable_name << "\n"
        presentable_name << location.to_s(prefix.concat('-'))
      end
      presentable_name
    end
end


locations = [{"id":1,"name":"San Francisco Bay Area","parent_id":nil},{"id":2,"name":"San Jose","parent_id":3},{"id":3,"name":"South Bay","parent_id":1},{"id":4,"name":"San Francisco","parent_id":1},{"id":5,"name":"Manhattan","parent_id":6},{"id":6,"name":"New York","parent_id":nil}]
locations = locations.sort_by {|location| location[:parent_id] || 0 }
locations.map{|input| Location.new(input)}

binding.pry
puts Location.locations.values.sort_by(&:location_name)
