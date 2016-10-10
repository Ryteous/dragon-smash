love.window.setTitle("Dragon Smash")
love.window.setMode(720, 720)
love.window.setPosition(440, 40)

love.graphics.setNewFont(14)
TILE_SIZE = 64
SCREEN_SIZE = 9

hero = {}
hero.imageLeft = love.graphics.newImage("hero1.png")
hero.imageRight = love.graphics.newImage("hero2.png")
hero.healthMax = 0
hero.magicMax = 0
hero.attacks = 0
hero.defense = 0
hero.experience = 0
hero.level = 1
hero.gold = 0

slime = {}
slime.image = love.graphics.newImage("slime.png")
slime.name = "Slime"
slime.health = 8
slime.attacks = 3
slime.level = 2
slime.gold = 4

redSlime = {}
redSlime.image = love.graphics.newImage("redslime.png")
redSlime.name = "Red Slime"
redSlime.health = 12
redSlime.attacks = 5
redSlime.level = 4
redSlime.gold = 6

dracky = {}
dracky.image = love.graphics.newImage("dracky.png")
dracky.name = "Dracky"
dracky.health = 16
dracky.attacks = 7
dracky.level = 6
dracky.gold = 8

greenDragon = {}
greenDragon.image = love.graphics.newImage("greenDragon.png")
greenDragon.name = "greenDragon"
greenDragon.health = 99999999
greenDragon.attacks = 9999999
greenDragon.level = 999999
greenDragon.gold = 999999

enemies = {}
enemies[1] = slime
enemies[2] = redSlime
enemies[3] = dracky
enemies[4] = greenDragon
enemy = 0

mode = 0
step = 0
steps = 0
restoreMagics = 0
encounter = 0

battleFrame = love.graphics.newImage("battleFrame.png")
menu = {"Attack", "Magic", "Run"}
command = 0
cursorBase = 150
cursorHead = 160
strike = false
heal = false
run = false

tile = {}
for i = 0, 5 do
   tile[i] = love.graphics.newImage("tile"..i..".png")
end
onTile = 0
mapX = 5
mapY = 15
mapW = 19
mapH = 40

map = {
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1}, 
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 2, 4, 4, 4, 4, 5, 4, 4, 4, 4, 3, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
   { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
}

battle = {
   {  1, 1, 1, 1, 1, 1, 1, 1, 1, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  2, 0, 0, 0, 0, 0, 0, 0, 3, },
   {  1, 1, 1, 1, 1, 1, 1, 1, 1, },
}
   
experienceRequired = { 5, 10, 20, 40, 70, 110, 160, 220, 290, 370, 460, 560 }
attacksGained      = { 1,  1,  2,  2,  3,   3,   4,   4,   5,   5,   6,   6 }
defenseGained      = { 1,  1,  1,  2,  2,   2,   3,   3,   3,   4,   4,   4 }
-------AT-LEVEL------  2   3   4   5   6    7    8    9   10   11   12   13

function love.load()
   hero.healthMax = love.math.random(10,12)
   hero.health = hero.healthMax
   hero.magicMax = love.math.random(8,10)
   hero.magics = hero.magicMax
   hero.attacks = love.math.random(5,7)
   hero.defense = love.math.random(1,2)
   encounter = love.math.random(4,24)
end

function drawMap()
   for y=1, SCREEN_SIZE do
      for x=1, SCREEN_SIZE do                                                         
         love.graphics.draw(tile[map[y+mapY][x+mapX]], (x*TILE_SIZE), (y*TILE_SIZE))
      end
   end
end

function drawBattle()
   for y=1, SCREEN_SIZE do
      for x=1, SCREEN_SIZE do
         love.graphics.draw(tile[battle[y][x]], (x*TILE_SIZE), (y*TILE_SIZE))
      end
   end
   love.graphics.draw(battleFrame, 4*TILE_SIZE, 2.5*TILE_SIZE)
end

function levelUp()
   if hero.experience >= experienceRequired[hero.level] then
      hero.attacks = hero.attacks + attacksGained[hero.level]
      hero.defense = hero.defense + defenseGained[hero.level]
      hero.level = hero.level + 1
      print("\nThy level ")
      print("increases to "..hero.level.." !")
      print("\nThy Attack")
      print("increases by "..attacksGained[hero.level].." !")
      print("\nThy Defense")
      print("increases by "..defenseGained[hero.level].." !")
   end
end

function atTile()
   onTile = map[mapY+5][mapX+5]
end

function reset()
   steps = 0
   restoreMagics = 0
   encounter = love.math.random(4,24)
   strike = false
   heal = false
   run = false
end

function resetSelector()
   command = 0
   cursorBase = 150
   cursorHead = 160
   strike = false
   heal = false
end

function worldEvents()
   if mode == 0 then
      if step == 0 then
         step = 1
      else
         step = 0
      end
      if restoreMagics == 8 and hero.magics < hero.magicMax then
         hero.magics = hero.magics + 1
         restoreMagics = 0
      end
      if steps == encounter then
         if onTile == 4 then
            enemy = love.math.random(2,3)
         elseif onTile == 5 then
            enemy = 4
         else
            enemy = love.math.random(1,2)
         end
         resetSelector()
         print("\nA "..enemies[enemy].name.." draws near!")
         print("Command?")
         mode = 1
      end
   end
end

function battleEvents()
   if mode == 1 then
      if command == 0 then
         if strike == true then
            enemies[enemy].health = enemies[enemy].health - hero.attacks
            print("\nHero attacks!")
            print("The "..enemies[enemy].name.."'s Hit Points")
            print("have been reduced by "..hero.attacks..".")
            if enemies[enemy].health > 0 then
               hit = enemies[enemy].attacks - hero.defense
               hero.health = hero.health - hit 
               print("\nThe "..enemies[enemy].name.." attacks!")
               print("Thy Hit decreased by "..hit..".")
            end
         end
      elseif command == 1 and heal == true then
         if hero.magics >= 4 then
            if hero.health < hero.healthMax then
               hero.magics = hero.magics - 4
               hero.health = hero.health + love.math.random(7,10)
               hero.health = hero.health - enemies[enemy].attacks
               print("\nHero chanted the spell")
               print("of HEAL.")
               print("\nThe "..enemies[enemy].name.." attacks!")
               print("Thy Hit decreased by "..enemies[enemy].attacks..".")               
            else 
               print("\nThy hits cannot be raised.")
            end
         else
            print("\nThy MP is too low.")
         end
      elseif command == 2 then
         if run == true then
            print("\nHero started to run away.")
            reset()
            mode = 0
         end
         run = false
      end
      if hero.health <= 0 then
         print("\nThou art dead.")
         love.event.quit()
      elseif enemies[enemy].health <= 0 then
         hero.experience = hero.experience + enemies[enemy].level
         hero.gold = hero.gold + enemies[enemy].gold
         print("\nThou hast done well in")
         print("defeating the "..enemies[enemy].name..".")
         print("\nThy Experience")
         print("increases by "..enemies[enemy].level..".")
         print("\nThy GOLD")
         print("increases by "..enemies[enemy].gold..".")
         levelUp()
         reset()
         mode = 0
      elseif strike == true or heal == true then
         print("\nCommand?")
      end
      resetSelector()
   end
end

function love.draw()
   if mode == 0 then
      drawMap()
      if step == 0 then
         love.graphics.draw(hero.imageLeft, 5*TILE_SIZE, 5*TILE_SIZE)
      else
         love.graphics.draw(hero.imageRight, 5*TILE_SIZE, 5*TILE_SIZE)
      end
   end
   if mode == 1 then
      drawBattle()
      love.graphics.draw(enemies[enemy].image, 5*TILE_SIZE, 4*TILE_SIZE)
      for i = 1, 3 do 
         love.graphics.print(menu[i], 168*i, 670)
      end
      love.graphics.polygon("fill", cursorBase, 670, cursorHead, 680, cursorBase, 690)
   end
   love.graphics.print("LEVEL : "..hero.level, 80, 10)
   love.graphics.print("HEALTH : "..hero.health, 240, 10)
   love.graphics.print("ATTACK : "..hero.attacks, 400, 10)
   love.graphics.print("DEFENSE :"..hero.defense, 400, 30)
   love.graphics.print("EXPERIENCE : "..hero.experience, 80, 30)
   love.graphics.print("MAGICS : "..hero.magics, 240, 30)
   love.graphics.print("GOLD : "..hero.gold, 600, 30)
end

function love.keypressed(key)
   if mode == 0 then
      if key == ('w') then
         if mapY > 0 then
            mapY = mapY-1
            steps = steps + 1
            restoreMagics = restoreMagics + 1
            atTile()
            worldEvents()
         end
      elseif key == ('s') then
         if mapY < mapH-SCREEN_SIZE then
            mapY = mapY+1
            steps = steps + 1
            restoreMagics = restoreMagics + 1
            atTile()
            worldEvents()
         end
      elseif key == ('a')  then
         if mapX > 0 then
            mapX = mapX-1
            steps = steps + 1
            restoreMagics = restoreMagics + 1
            atTile()
            worldEvents()
         end
      elseif key == ('d') then
         if mapX < mapW-SCREEN_SIZE then
            mapX = mapX+1
            steps = steps + 1
            restoreMagics = restoreMagics + 1
            atTile()
            worldEvents()
         end
      end
   end
   if mode == 1 then
      if key == ('a') then
         if command > 0 then
            cursorBase = cursorBase - 168
            cursorHead = cursorHead - 168
            command = command - 1
         end
      elseif key == ('d') then
         if command < 2 then
            cursorHead = cursorHead + 168
            cursorBase = cursorBase + 168
            command = command + 1
         end
      elseif key == ('return') then
         if command == 0 then
            strike = true
            battleEvents()
         elseif command == 1 then
            heal = true
            battleEvents()
         elseif command == 2 then
            run = true
            battleEvents()
         end   
      end
   end
end