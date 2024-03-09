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
	--move_player()
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
	draw_world()
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

function draw_world(sx,sy,vw,vh,cam_x,cam_y)

	map(0,0,0,0,127,127,0)

end

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
eeeeeeee00000000011111111111111111111111111111101ff3ff19a1f3fff13666666366666666666666660000000000000000000000000000000000000000
eeeeeeee0000000011ffffffffffffffffffffffffffff11111fff19a1ff31116333333160000006600000110000000000000000000000000000000000000000
eeeeeeee000000001f1ff3fff3fff3fff3fff3fff3fff1f11ff11f19a1f113f16333333161100006600011130000000000000000000000000000000000000000
eeeeeeee000000001ff13f3f3f3f3f3f3f3f3f3f3f3f1ff11fff3119a11f3ff16333333163111006601113130000000000000000000000000000000000000000
eeeeeeee000000001ff31ff3fff3fff3fff3fff3fff1fff11ff3ff19a1f3fff16333333163131116611313130000000000000000000000000000000000000000
eeeeeeee000000001f3ff1ffffffffffffffffffff1f3ff11f3fff19a1ff3ff16333333163131316631313130000000000000000000000000000000000000000
eeeeeeee000000001ff3ff11111111111111111111fff3f11ff3ff19a1fff3f16333333163131316631313130000000000000000000000000000000000000000
eeeeeeee000000001fff3f199999999999999999a1ff3ff11fff3f19a1ff3ff13111111366666666666666660000000000000000000000000000000000000000
00000000000000001ff3ff19dd5dd5dda1f3fff1a1f3fff11fff1119a1111ff13666666136666663000000000000000000000000000000000000000000000000
00000000000000001f3fff19ddd55ddda1ff3ff1a1ff3ff111110009a10001116366661160000001006666000880808000000000000000000000000000000000
00000000000000001ff3ff195dddddd5a1fff3f1a1fff3f110000009a10000016636611160000001064444100888980000000000000000000000000000000000
00000000000000001fff3f19d5d55d5da1ff3ff1a1ff3ff110000009a10000016663311160000001644444410889908000000000000000000000000000000000
00000000000000001ff3ff19d5d55d5da1f3fff1a1f3fff110000009a10000016663311160000001644994410888888000000000000000000000000000000000
00000000000000001f3fff195dddddd5a1ff3ff1a1ff3ff110000009a10000016611131160000001644444410888800000000000000000000000000000000000
00000000000000001ff3ff19ddd55ddda1fff3f1a1fff3f111110009a10001116111113160000001011111100080080000000000000000000000000000000000
00000000000000001fff3f19dd5dd5dda1ff3ff1a1ff3ff11fff1119a1111ff11111111331111113000000000000000000000000000000000000000000000000
00000000000000001ff3ff19aaaaaaaaa9f3fff1a1f3fff11ff3ff19a1f3fff11111111111111111000000000000000000000000000000000000000000000000
00000000000000001f3fff191111111199ff3ff1a1ff3ff11f3fff19a1ff3ff1b3331b3331b33313000000000000000000000000000000000000000000000000
00000000000000001ff3ff19ffffffffff1ff3f1a1fff3f11ff3ff19a1fff3f13333133331333313000000000000000000000000000000000000000000000000
00000000000000001fff3f193fff3fff3ff13ff1a1ff3ff11fff3f19a1ff3ff11111111111111111000000000000000000000000000000000000000000000000
00000000000000001ff3ff19f3f3f3f3f3f31ff1a1f3fff11ff3f119a113fff131b331b300000011000000000000000000000000000000000000000000000000
00000000000000001f3fff19ff3fff3fff3ff1f1a1ff3ff11f311f19a1f11ff13133313300000000000000000000000000000000000000000000000000000000
00000000000000001ff3ff19ffffffffffffff11a1fff3f11113ff19a1fff1111111111111111111000000000000000000000000000000000000000000000000
00000000000000001fff3f191111111111111110a1ff3ff11fff3f19a1ff3ff1331b331b00000000000000000000000000000000000000000000000000000000
00000000000000001ff3ff19aaaaaaaaaaaaaaaaa9f3fff1111111111111111111111111aaaaaaaaaaaaaaaaaaaaaaaa00000000000000000000000000000000
00000000000000001f3fff11111111111111111199ff3ff1ffffffffffffffffffffffff11111111111111111111111100000000000000000000000000000000
00000000000000001ff3f1ffffffffffffffffffff1ff3f1f3fff3fff3fff3fff3fff3ffffffffffffffffffffffffff00000000000000000000000000000000
00000000000000001fff1fff3fff3fff3fff3fff3ff13ff13f3f3f3f3f3f3f3f3f3f3f3f3fff3fff3fff3fff3fff3fff00000000000000000000000000000000
00000000000000001ff1f3f3f3f3f3f3f3f3f3f3f3f31ff1fff3fff3fff3fff3fff3fff3f3f3f3f3f3f3f3f3f3f3f3f300000000000000000000000000000000
00000000000000001f1fff3fff3fff3fff3fff3fff3ff1f1ffffffffffffffffffffffffff3fff3fff3fff3fff3fff3f00000000000000000000000000000000
000000000000000011ffffffffffffffffffffffffffff11111111111111111111111111ffffffffffffffffffffffff00000000000000000000000000000000
00000000000000000111111111111111111111111111111099999999999999999999999911111111111111111111111100000000000000000000000000000000
__map__
0102030303030303030305000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0022131313131313131315000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0006131313131313131325000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0022131313131313131325000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0016131313131313131325000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0022131313131313131325000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0026131313131313131325000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0022131313131313131325100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0032333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
