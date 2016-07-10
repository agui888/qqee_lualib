package.path='lib/?.lua;'
require"lib"
require"gd"

function code_init()
end

function code_make()
end

--print(tostring(os.time()));print(tostring(os.time()):sub(-9))

local w=140
local h=70

--local im1=gd.createTrueColor(w,h)
--local im2=gd.createTrueColor(w,h)
local im1=gd.create(w,h)
local im2=gd.create(w,h)
local FFF=im1:colorAllocate(255,255,255)
im1:filledRectangle(0,0,w,h,FFF)
im2:filledRectangle(0,0,w,h,FFF)

--COLOR
local cc={}
cc[#cc+1]={27,78,181} --blue
cc[#cc+1]={22,163,35} --green
cc[#cc+1]={214,36,7} --red
math.randomseed(tostring(os.time()):reverse():sub(1,9))
local ccid=math.random(#cc)
local color=im1:colorAllocate(cc[ccid][1],cc[ccid][2],cc[ccid][3])

--FONT
local code=""
local x=15
for i=1,4 do
	local s=tostring(math.random(9))
	code=code..s
	local sz=math.random(35,54)
	local lr=(40-math.random(80))
	local lr=(lr/100) --  -0.4~0.4
	local tp=math.random(50,60)
	im1:stringFT(color,'./ApothecaryFont.0-9.ttf',sz,lr,x,tp,s)
	x=15+i*25+2
end

print(code)
im1:gif("code.gif")
