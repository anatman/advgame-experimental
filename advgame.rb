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
    "#@name:\n#@description"
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
    # determines whether the cirrent room has an exit in the given direction and if so, wher it goes.
    
    # takes a symbol (:n, :e, >s, or :w) representing a direction
    
    # returns nil if there is no exit in the given direction and the number of the room in that direction
    # if there is an exit. if given a nonsymbol or incorrect symbol, also returns nil.
    
    dirs = {:n => 0, :e => 1, :s => 2, :w => 3}
    goto = dirs[direction] # i love goto not being a reserved word!
    goto ? (exits[goto] == -1 ? nil : goto) : nil
  end
end

class Map
  # this class just holds a map (an array of Places)
  
  attr_reader :places
  
  def initialize(*places)
    @places = places
  end
end