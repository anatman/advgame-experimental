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
    @thing3 = Thing.new "Jane", "A generic character"
  end
  
  it "should have a generic default name" do
    @thing.name.should == "Default Name"
  end
    
  it "should have a generic default description" do
    @thing.description.should == "This is a generic default Thing"
  end
  
  it "should be possible to create a new Thing with its own name" do
    @thing2.name.should == "Fred"
  end
  
  it "should be possible to create a new Thing with its own description" do
    @thing3.description.should == "A generic character"
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
  
  it "should be possible to create a specific place" do
    @place2.name.should == "This Room"
    @place2.description.should == "This is a specific place"
    @place2.exits.should == [-1, 1, 2, -1]
  end
  
  it "should be able to tell if it has an exit in a given direction" do
    @place2.has_exit?(:n).should == nil
    @place2.has_exit?(:e).should == 1
    @place2.has_exit?(:s).should == 2
    @place2.has_exit?(:w).should == nil
  end
  
  after(:each) do
    @place = nil
    @place2 = nil
  end
end