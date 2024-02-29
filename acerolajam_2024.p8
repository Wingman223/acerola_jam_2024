pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- acerola jam 2024
-- wingman223

-- global vars
scene=0
screenwidth = 127
screenheight = 127

-- game loop

function _init()
-- code here happens one time
-- this function runs as soon as the game loads
	game_over=false
	make_player()
end

function _update()
-- 30 times every second
	if scene==0 then
		titleupdate()
	elseif scene==1 then
		gameupdate()
	end
end

function _draw()
-- 30 times every second after update
	cls() -- clear screen
	if scene==0 then
		titledraw()
	elseif scene==1 then
		gamedraw()
	end
end
-- update functions
function titleupdate()
	if btnp(4) then
		scene=1
	end
end

function gameupdate()
	-- playercontrol()
	move_player()
end

-- draw functions
function titledraw()
	local titletxt = "title screen"
	local starttxt = "press z to start"
	rectfill(0,0,screenwidth, screenheight, 3)
	print(titletxt, hcenter(titletxt), screenheight/4, 10)
	print(starttxt, hcenter(starttxt), (screenheight/4)+(screenheight/2),7)			
end

function gamedraw()
	draw_player()

	--local gametxt = "game screen"
	--rectfill(0,0,screenwidth, screenheight, 12)
	--rectfill(0,0,screenwidth, 10, 0)
	--print("score: " .. score, 10, 4, 7)
	--print(gametxt, hcenter(gametxt), hcenter(gametxt), 10)

	--playerdraw()
end

-- handle button inputs
function playercontrol()
	if (btn(0)) then player.x-=1 end
	if (btn(1)) then player.x+=1 end
	if (btn(2)) then player.y-=1 end
	if (btn(3)) then player.y+=1 end

	-- check if the player is still onscreen
	if (player.x <= 0) then player.x = 0 end
	if (player.x >= screenwidth - player.width) then player.x = screenwidth - player.height end
	if (player.y <= 0) then player.y = 0 end
	if (player.y >= screenheight - player.height) then player.y = screenheight - player.height end

end

-- draw player sprite
function playerdraw()
	spr(1, player.x, player.y)
end

-- library functions

-->8
-- basic functions

function make_player()
	player={}
	player.x=24 			-- position
	player.y=60
	player.dy=0 			-- fall speed
	player.rise=1		-- sprites
	player.fall=2
	player.dead=3
	player.speed=2 -- fly speed
	player.score=0
end

function draw_player()
	if (game_over) then
		spr(player.dead,player.x,player.y)
	elseif (player.dy<0) then
		spr(player.rise,player.x,player.y)
	else
		spr(player.fall,player.x,player.y)
	end
end

function move_player()
	gravity=0.2
	player.dy+=gravity
	
	-- jump
	if(btnp(2)) then
		player.dy-=5
	end
	
	-- move
	player.y+=player.dy
end
-->8
-- library functions

--- center align from: pico-8.wikia.com/wiki/centering_text
function hcenter(s)
	-- string length time			s the 
	-- pixels in a char's width
	-- cut in half and rounded down
	return (screenwidth / 2)-flr((#s*4)/2)
end

function vcenter(s)
	-- string char's height
	-- cut in half and rounded down
	return (screenheight /2)-flr(5/2)
end

--- collision check
function iscolliding(obj1, obj2)
	local x1 = obj1.x
	local y1 = obj1.y
	local w1 = obj1.w
	local h1 = obj1.h
	
	local x2 = obj2.x
	local y2 = obj2.y
	local w2 = obj2.w
	local h2 = obj2.h

	if(x1 < (x2 + w2)  and (x1 + w1)  > x2 and y1 < (y2 + h2) and (y1 + h1) > y2) then
		return true
	else
		return false
	end
end
__gfx__
00000000003333000022220000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033333300222222008888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700331331332212212288188188000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000333333332222222288888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000333333332222222288811888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700331331332212212288188188000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033113300221122008888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000003333000022220000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
