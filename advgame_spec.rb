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
  
  after(:each) do
    @thing = nil
  end
end