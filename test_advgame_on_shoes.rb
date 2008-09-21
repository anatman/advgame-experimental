# test_advgame_on_shoes.rb
require 'advgame'

place0 = Place.new("The Entrance", "An abandoned mineshaft", [1, 2, -1, -1])
place1 = Place.new("A Collapsed Passage", "A debris filled caved in passage", [-1, -1, 0, -1])
place2 = Place.new("A Corner", "A tunnel that makes an abrupt right turn", [-1, -1, 3, 0])
place3 = Place.new("The Exit", "An ancient cave mouth", [2, -1, -1, -1])
map = Map.new(place0, place1, place2, place3)
character = Character.new("loogink", "An Explorer", map, 0)

Shoes.app :width => 420, :height => 550, :title => 'Adventure Game v0.1' do
  @pos = [100, 150], [100, 100], [250, 150], [250, 200]
  
  def pos name
    x, y = case name
      when "The Entrance" then @pos[0]
      when "A Collapsed Passage" then @pos[1]
      when "A Corner" then @pos[2]
      when "The Exit" then  @pos[3]
      else
    end
  end
  
  fill gold.to_s..coral.to_s
  rect :width => 400, :height => 300, :left => 10, :top => 10, :curve => 10
  rooms = []
  stroke white
  strokewidth 4
  [[0, 1], [0, 2], [2, 3]].each{|a, b| line @pos[a][0] + 15, @pos[a][1] + 15, @pos[b][0] + 15, @pos[b][1] + 15}
  
  map.places.each{|place| rooms << oval(0, 0, 30, :fill => green)}
  rooms.each_with_index{|room, i| room.move @pos[i][0], @pos[i][1]}
  
  x, y = pos character.location.name
  @avatar = image Dir.pwd + '/loogink.png', :left => x, :top=> y
  
s =<<-EOS
You must travel through the old mine (from The Entrance to The Exit). \
You may issue the command n to move to the north. \
You may likewise move in other directions by issuing the commands \
e (east ) or s (south) or w (west). \
You may also issue the command l to look at your current location. \
The commands are not case sensitive. \
These are the only commands that the program will accept. \
The game ends after you find your way to The Exit and issue the l command there.
EOS

  @msg = para s, :left => 0, :top => 320
  
  keypress do |k|
    case k
      when 'n', 'e', 's', 'w'
        @msg.text = character.move!(k.to_sym)
        @avatar.move *pos(character.location.name)
      when 'l'
        @msg.text = character.look_at
        if character.location.name == "The Exit"
          alert 'You have won the game! What an accomplishment!'
          exit
        end
      else
        @msg.text = "I do not understand that command."
    end
  end
end
