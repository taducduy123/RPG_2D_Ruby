
require 'ruby2d'
require_relative 'Character_Class/Player'
require_relative 'KeyHandler'
require_relative 'GameMap'
require_relative 'CommonParameter'
require_relative 'Character_Class/Monster'
require_relative 'Character_Class/Bat'
require_relative 'FindingPath/Node'
require_relative 'FindingPath/PathFinder'
include CCHECK


#
pFinder = PathFinder.new()




#1. Create objects in the game
#------------------------- 1.1. Map Section --------------------------------
map = GameMap.new()

#------------------------- 1.2. Player Section --------------------------------
player = Player.new(1*CP::TILE_SIZE, 1*CP::TILE_SIZE, CP::TILE_SIZE, CP::TILE_SIZE)

#------------------------- 1.3. Monsters Section --------------------------------
monsters = [Bat.new(38*CP::TILE_SIZE, 38*CP::TILE_SIZE, CP::TILE_SIZE, CP::TILE_SIZE, player)
            # Bat.new(1000, 1000, CP::TILE_SIZE, CP::TILE_SIZE, player),
            # Bat.new(1500, 1500, CP::TILE_SIZE, CP::TILE_SIZE, player)
           ]
        
#------------------------- 1.4. Text Section --------------------------------
text = Text.new(
  '',
  x: 0, y: 0,
  #font: 'vera.ttf',
  style: 'bold',
  size: 20,
  color: 'white',
  #rotate: 90,
  #z: 10
)

text1 = Text.new(
  '',
  x: 450, y: 0,
  #font: 'vera.ttf',
  style: 'bold',
  size: 20,
  color: 'white',
  #rotate: 90,
  #z: 10
)


#2. Include necessary tools
#------------------------------------ 2.1. Get user's input -------------------------
get_key_input(player)
#------------------------------------ 2.2. Finding Path -----------------------------
pFinder = PathFinder.new()
#------------------------------------ 2.3. Audio/Sound ------------------------------
music = Music.new('Sound/Dungeon.wav')
music.loop = true
music.play



#3. Core of 2D game
#------------------------------------------------------- Game Loop ------------------------------------------
update do
    #1. Update Player
    player.updatePlayer(monsters, map)

    #2. Update all Monsters
    for i in 0..(monsters.length - 1)
      monsters[i].updateMonster(player, map, pFinder)
    end

    #3. Update Texts
    text.text = "Coordinate: #{player.worldX}  #{player.worldY} "
    text1.text = "Coordinate Monster: #{monsters[0].worldX}    #{monsters[0].worldY}"
    
    
    #4. Update Map
    map.updateMap(player, pFinder)

end



#------------------------------------------------------- Set up window ---------------------------------------
#Setting Window
set width: CP::SCREEN_WIDTH
set height: CP::SCREEN_HEIGHT
set title: "Grid RPG"
set resizable: true
set background: 'black'
#set fullscreen: true


#------------------------------------------------------- Show window ---------------------------------------
show
