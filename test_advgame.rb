# test_advgame.rb
# a console front end that allows a user to play a very simple test game with advgame.rb

# the user plays the part of Satish, an explorer and must travel from the entrance to the exit

require 'advgame'

place0 = Place.new("The Entrance", "An abandoned mineshaft", [1, 2, -1, -1])
place1 = Place.new("A Collapsed Passage", "A debris filled caved in passage", [-1, -1, 0, -1])
place2 = Place.new("A Corner", "A tunnel that makes an abrupt right turn", [-1, -1, 3, 0])
place3 = Place.new("The Exit", "An ancient cave mouth", [2, -1, -1, -1])
map = Map.new(place0, place1, place2, place3)
character = Character.new("Satish", "An Explorer", map, 0)

done = false

puts "You must travel through the old mine (from The Entrance to The Exit)."
puts "You may issue the command north or n to move to the north."
puts "You may likewise move in other directions by issuing the commands"
puts "east or e, south or s, or west or w."
puts "You may also issue the command look or l to look at your current location."
puts "The commands are not case sensitive."
puts "These are the only commands that the program will accept."
puts "The game ends after you find your way to The Exit and issue the look or l command there."
STDOUT.flush

while !done do
  print "Your command?: "
  STDOUT.flush
  case gets.chomp.downcase
    when 'north', 'n'
      puts character.move!(:n)
    when 'east', 'e'
      puts character.move!(:e)
    when 'south', 's'
      puts character.move!(:s)
    when 'west', 'w'
      puts character.move!(:w)
    when 'look', 'l'
      puts character.look_at
      done = true if character.location.name == "The Exit"
    else
      puts "I do not understand that command."
  end
  STDOUT.flush  
end
puts "You have won the game! What an accomplishment!"
puts "(Press enter to exit)."
STDOUT.flush
gets