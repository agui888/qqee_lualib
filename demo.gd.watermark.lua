package.path='lib/?.lua;'
require"lib"
local gd=require"gd"
-----------------------------------------------------------------------
print(osinfo())
print_r(gd)
-----------------------------------------------------------------------
local magics = {
	{ "\137PNG", gd.createFromPng },
	{ "GIF87a", gd.createFromGif },
	{ "GIF89a", gd.createFromGif },
	{ "\255\216\255\224\0\16\74\70\73\70\0", gd.createFromJpeg },
	{ "\255\216\255\225\19\133\69\120\105\102\0", gd.createFromJpeg },  -- JPEG Exif
}
local function openimg(fname)
	local fp = io.open(fname, "rb")
	if not fp then
		return nil, "Error opening file"
	end
	local header = fp:read(16)
	if not header then
		return nil, "Error reading file"
	end
	fp:close()
	for _, v in ipairs(magics) do
		if header:sub(1, #v[1]) == v[1] then
			return v[2](fname)
		end
	end
	return nil, "Image type not recognized"
end
-----------------------------------------------------------------------


local im = openimg("./1.jpg")
local ix, iy = im:sizeXY()
print(ix,iy)
local white = im:colorAllocate(255, 255, 255)
local black = im:colorAllocate(0, 0, 0)


--ZOOM
local xout=500*0.7
local yout=375*0.7
local imout=gd.createTrueColor(xout, yout)
--gd.copyResized(imout, im, 0, 0, 0, 0, xout, yout, ix, iy)
gd.copyResampled(imout, im, 0, 0, 0, 0, xout, yout, ix, iy)


--imout:jpeg("out.jpg",55)
--imout:png("out.png")
--imout:gif("out.gif")


local smallimgstr=imout:jpegStr(55)
local im_small=gd.createFromJpegStr(smallimgstr)
print(im_small)


--IMAGE
--local imx = openimg("./watermark.png")
local imx = gd.createFromPng("./logo.png")
local sx, sy = imx:sizeXY()
print(sx,sy)
gd.copy(im_small, imx, 5, 25, 0, 0, sx, sy, sx, sy)
--im:jpeg("out.jpg",40)


--FONT
local fontsize=3
local ix, iy = im_small:sizeXY()
local x=ix-330
local y=iy-50
im_small:string(fontsize, x, y, "Powered by : http://www.qq.ee/", white)


im_small:jpeg("out.jpg",45)

-----------------------------------------------------------------------




