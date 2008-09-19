# advgame_spec.rb

# Rspec tests for a simple skeletal adventure game programming/Rspec/Git/Shoes exercise
# prepared for the intermediate Ruby class at http://rubylearning.org/class/
# partially based on the minigame exercise from the beginning Ruby class

require 'advgame'

describe Thing do
  # make sure you have a fresh default Thing to work with for each test
  before(:each) do
    @thing = Thing.new
  end
  
  it "should have a generic default name" do
    @thing.name.should == "Default Name"
  end
    
  it "should have a generic default description" do
    @thing.description.should == "This is a generic default Thing"
  end
  
  it "should be possible to create a new Thing with its own name" do
    @thing2 = Thing.new "Fred"
    @thing2.name.should == "Fred"
    @thing2 = nil
  end
  
  it "should be possible to create a new Thing with its own description" do
    @thing3 = Thing.new "Jane", "A generic character"
    @thing3.description.should == "A generic character"
    @thing3 = nil
  end
  
  after(:each) do
    @thing = nil
  end
end