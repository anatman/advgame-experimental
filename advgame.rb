# advgame.rb

# a simple skeletal adventure game programming/rspec/git/shoes exercise
# prepared for the intermediate ruby class at http://rubylearning.org/class/
# partially based on the minigame exercise from the beginning ruby class

class Thing
  # generic base class for objects, creatures, players, and places
  
  # a Thing has a name (string) and a description (string).
  
  attr_reader :name, :description
  
  def initialize(name = "Default Name", description = "This is a generic default Thing")
    @name = name
    @description = description
  end
  
  def look_at
    # allows you to "look at" a Thing. returns a formatted name and description
    
    "#@name: #@description"
  end
end

class Place < Thing
  # this class is for Places (game rooms and other locations)
  
  # a Place has a name, (string), a description (string) and exits (array of integers)
  
  # exits is a four element array representing possible exits in the order north, east, south, west.
  # exits are represented by integers. -1 means there is no exit in that direction. 0, 1, 2, etc.
  # represent exits to the room with that index in the map.
  
  attr_reader :exits
  
  def initialize(name = "Default Place", description = "A generic default location", exits = [-1, -1, -1, -1])
    @exits = exits
    super(name, description)
  end
  
  def has_exit?(direction)
    # determines whether the cirrent room has an exit in the given direction and if so, where it goes.
    
    # takes a symbol (:n, :e, :s, or :w) representing a direction
    
    # returns nil if there is no exit in the given direction and the number of the room in that direction
    # if there is an exit. if given a nonsymbol or incorrect symbol, also returns nil.
    
    dirs = {:n => 0, :e => 1, :s => 2, :w => 3}
    goto = dirs[direction] # i love goto not being a reserved word!
    goto ? (exits[goto] == -1 ? nil : exits[goto]) : nil
  end
  
  def exits_to
    # returns a string listing the exits from a Place.
    # returns a string saying so if there are no exits.
    
    exit_names = {:n => 'north', :e => 'east', :s => 'south', :w => 'west'}
    exits_list = []
    
    [:n, :e,:s, :w].each do |i|
      exits_list << exit_names[i] if self.has_exit?(i)
    end
    
    exits_list.empty? ? "This place has no exits." : "There are exits in these directions: #{exits_list.join(', ')}."
  end
  
  def look_at
    super + "\n#{exits_to}"
  end
end

class Map
  # this class just holds a map (an array of Places)
  
  attr_reader :places
  
  def initialize(*places)
    @places = places
  end
end

class Character < Thing
  # this class holds the character who serves as the player's viewpoint.
  
  # a Character has a name (String), a description (String), and a location (Place).
  # it also keeps track of the map being used (Map) for internal use
  # the Character determines its location in reference to a Map.
  
  attr_reader :map
  attr_accessor :location
  
  def initialize(name = "Default Character", description = "Default Character description", map = Map.new(Place.new), place = 0)
    super(name, description)
    @map = map
    @location = map.places[place]
  end
  
  def look_at
    super + "\n" + location.look_at
  end
  
  def move!(direction)
    # moves the character in the desired direction if possible and reports the new location or reports failure.
    # this method's name ends with a ! because it modifies the location of the Character itself.
    
    # takes a symbol (:n, :e, :s, or :w) and returns a String
    
    goto = location.has_exit?(direction)
    
    if goto
      # using self.location here modifies the location of the Character itself
      
      self.location = map.places[goto]
      "Your new location is\n" + location.look_at
    else
      "There is no exit in that direction."
    end
  end
end