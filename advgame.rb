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
end

class Place < Thing
  # this class is for Places (game rooms and other locations)
  
  # a Place has a name, (string), a description (string) and exits (array of symbols)
  
  attr_reader :exits
  
  def initialize(name = "Default Place", description = "A generic default location", exits = [])
    @exits = exits
    super(name, description)
  end
end