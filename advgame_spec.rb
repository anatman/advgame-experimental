# advgame_spec.rb

# Rspec tests for a simple skeletal adventure game programming/Rspec/Git/Shoes exercise
# prepared for the intermediate Ruby class at http://rubylearning.org/class/
# partially based on the minigame exercise from the beginning Ruby class

require 'advgame'

describe Thing do
  # make sure you have a fresh default Thing to work with for each test
  before(:each) do
    @thing = Thing.new
    # thing2 and thing3 are for testing nondefault initialization
    @thing2 = Thing.new "Fred"
    @thing3 = Thing.new "Jane", "A different generic Thing"
  end
  
  it "should have a generic default name" do
    @thing.name.should == "Default Name"
  end
    
  it "should have a generic default description" do
    @thing.description.should == "This is a generic default Thing"
  end
  
  it "should be able to create a new Thing with its own name" do
    @thing2.name.should == "Fred"
  end
  
  it "should be able to create a new Thing with its own description" do
    @thing3.description.should == "A different generic Thing"
  end
  
  it "should be able to name and describe itself when looked at" do
    @thing.look_at.should == "Default Name: This is a generic default Thing"
    @thing2.look_at.should == "Fred: This is a generic default Thing"
    @thing3.look_at.should == "Jane: A different generic Thing"
  end
  
  after(:each) do
    @thing = nil
    @thing2 = nil
    @thing3 = nil
  end
end

describe Place do
  before(:each) do
    @place = Place.new
    @place2 = Place.new("This Room", "This is a specific place", [-1, 1, 2, -1]) 
  end
  
  it "should have a generic default name" do
    @place.name.should == "Default Place"
  end
  
  it "should have a generic default description" do
    @place.description.should == "A generic default location"
  end
  
  it "should have an exits array" do
    @place.exits.should be_an_instance_of(Array)
  end
  
  it "should default to an exits array of [-1, -1, -1, -1] (no exits)" do
    @place.exits.should == [-1, -1, -1, -1]
  end
  
  it "should be able to create a specific place" do
    @place2.name.should == "This Room"
    @place2.description.should == "This is a specific place"
    @place2.exits.should == [-1, 1, 2, -1]
  end
  
  it "should be able to tell if it has an exit in a given direction" do
    @place2.has_exit?(:n).should == nil
    @place2.has_exit?(:e).should == 1
    @place2.has_exit?(:s).should == 2
    @place2.has_exit?(:w).should == nil
    @place2.has_exit?(:r).should == nil # testing a bad input
    @place2.has_exit?('n').should == nil # testing a bad input of an unexpected type
  end
  
  it "should be able to report when it has no exits" do
    @place.exits_to.should == "This place has no exits."
    @place2.exits_to.should_not == "This place has no exits."
  end
  
  it "should be able to list the exits if they exist" do
    @place2.exits_to.should == "There are exits in these directions: east, south."
  end
  
  it "should list the exits if any when looked at" do
    @place.look_at.should == "Default Place: A generic default location\nThis place has no exits."
    @place2.look_at.should == "This Room: This is a specific place\nThere are exits in these directions: east, south."
  end
  
  after(:each) do
    @place = nil
    @place2 = nil
  end
end

describe Map do
  before(:each) do
    @place0 = Place.new("The Entrance", "An abandoned mineshaft", [1, 2, -1, -1])
    @place1 = Place.new("A Collapsed Passage", "A debris filled caved in passage", [-1, -1, 0, -1])
    @place2 = Place.new("A Corner", "A tunnel that makes an abrupt right turn", [-1, -1, 3, 0])
    @place3 = Place.new("The Exit", "An ancient cave mouth", [2, -1, -1, -1])
    @map = Map.new
    @map2 = Map.new(@place0, @place1, @place2, @place3)
  end
  
  it "should default to an empty array" do
    @map.places.should be_an_instance_of(Array)
    @map.places.should be_empty
  end
  
  it "should be able to populate the map" do
    @map2.places.size.should == 4
    @map2.places[0].should == @place0
    @map2.places[1].should == @place1
    @map2.places[2].name.should == "A Corner"
    @map2.places[3].description.should == "An ancient cave mouth"
  end
  
  after(:each) do
    [@place0, @place1, @place2, @place3, @map, @map2].each { |i| i = nil }
  end
end

describe Character do
  before(:each) do
    @place0 = Place.new("The Entrance", "An abandoned mineshaft", [1, 2, -1, -1])
    @place1 = Place.new("A Collapsed Passage", "A debris filled caved in passage", [-1, -1, 0, -1])
    @map = Map.new(@place0, @place1)
    @character = Character.new
    @character2 = Character.new("Satish", "An Explorer", @map, 0)
  end
  
  it "should be a Thing" do
    @character.name.should == "Default Character"
    @character.description.should == "Default Character description"
  end
  
  it "should be able to create a specific Character" do
    @character2.name.should == "Satish"
    @character2.description.should == "An Explorer"
  end
  
  it "should have a location" do
    @character.location.look_at.should == "Default Place: A generic default location\nThis place has no exits."
    @character2.location.look_at.should == "The Entrance: An abandoned mineshaft\nThere are exits in these directions: north, east."
  end
  
  it "should name and describe itself and its location when looked at" do
    @character.look_at.should == "Default Character: Default Character description\nDefault Place: A generic default location\nThis place has no exits."
    @character2.look_at.should == "Satish: An Explorer\nThe Entrance: An abandoned mineshaft\nThere are exits in these directions: north, east."
  end
  
  after(:each) do
    [@place0, @place1, @map, @character, @character2].each { |i| i = nil }
  end
end