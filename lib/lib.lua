--[[
----------------------------------------------------------
local format=string.format
local byte=string.byte
local gsub=string.gsub
local char=string.char
local find=string.find
local len=string.len

local md5=md5
local print_r=print_r
local cat=cat
local trim=trim
local file_exists=file_exists
local system=system
local bin2hex=bin2hex
local hex2bin=hex2bin
local hex2ip=hex2ip
local urlencode=urlencode
local urldecode=urldecode
local jsonencode=jsonencode
local jsondecode=jsondecode
----------------------------------------------------------
]]
local format=string.format
local byte=string.byte
local gsub=string.gsub
local char=string.char
local find=string.find
----------------------------------------------------------
--[[
function print_r(arr,times,arr_name)
	if type(arr)=="string" then print(arr) return end
	if type(arr)~="table" then print("print_r error : Not a table. ["..tostring(arr).."]") return end
	local times_new=times or 0
	local tabs=string.rep("\t",1)
	--local tabs=string.rep("\t",times_new)
	arr_old_name=arr_name or ""
	print(tabs .. arr_old_name .. "{")
	for k1,v1 in pairs(arr) do
		if type(v1)~="table" and type(v1)~="function" then
			print(tabs .. "\t" .. k1 .. " ==> " .. tostring(v1))
			elseif type(v1)=="function" then
				print(tabs .. "\t" .. k1 .. " ==> function()  ")-- .. string.dump(v1))
		else
			print_r(v1,times_new+1,k1)
		end
	end
	print(tabs .. "}")
end
]]
function print_r(tt, indent, done)
	done = done or {}
	local step=6
	indent = indent or step
	if type(tt)=="table" then
		if indent==step then io.write("{\n") end
		for key, value in pairs (tt) do
			io.write(string.rep (" ", indent))
			if type (value) == "table" and not done[value] then
				done[value] = true
				io.write(string.format("[%s] => \n", tostring(key)))
				io.write(string.rep(" ", indent+step))
				io.write("(\n")
				print_r(value, indent+step, done)
				io.write(string.rep (" ", indent+step))
				io.write(")\n")
			else
				io.write(string.format("[%s]  ==>  %s\n",tostring (key), tostring(value)))
			end
		end
		io.write("}\n")
	else
	io.write(tostring(tt).."\n")
	end
end

function cat(file)
    local fhd,s=nil
    pcall(function() fhd=io.open(file,"r")
        s = fhd:read("*a")
        fhd:close()
	end)
    return s
end

function trim(s)
	if not s then return nil end
	return (gsub(tostring(s),"^[%s\t]*(.-)[%s\t]*$","%1"))
end

function file_exists(file) --true/false
    local fhd=io.open(file,"r")
    if fhd~=nil then
        fhd:close()
		return true
    end
    return false
end

function system(cmd)
    local handle=io.popen(cmd)
    local s=handle:read("*a")
    handle:close()
    return s
end

function bin2hex(s,space)
	local fmt="%02X"..(space or "")
	--local fmt="%02X "
	s=gsub(s,"(.)",function(x) return format(fmt,byte(x)) end)
	return s
end

function hex2bin(hexstr,fmtx)
	local h2b={["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["A"]=10,["B"]=11,["C"]=12,["D"]=13,["E"]=14,["F"]=15}
	--local fmt=(fmtx or "(.)(.)") --"(.)(.)%s"
	--local fmt=(fmtx and "(.)(.)"..fmtx or "(.)(.)")
	local fmt="(.)(.)"
	if fmtx~=nil then
		fmt="(.)(.)"..fmtx
		hexstr=hexstr..fmtx
	end
	local s=gsub(hexstr,fmt,function(h,l)
		return string.char(h2b[h]*16+h2b[l])
	end)
	return s
end

function hex2ip(FFFFFFFF) --18665EB6
	if #FFFFFFFF~=8 then return nil end
	local s=gsub(FFFFFFFF,"(%w%w)",function(h)
		return tostring(tonumber("0x"..h))..'.'
	end)
	return string.sub(s,1,-2)
end

function urlencode(s)
	s=string.gsub(s,"([^%w%.%- ])",function(c)
		return string.format("%%%02X",string.byte(c))
	end)
	return string.gsub(s," ","+")
end

function urldecode(s)
	s=gsub(s,"+"," ")
	return gsub(s,"%%(%x%x)",function(h) return char(tonumber(h,16)) end)
end

--[[
local net=require"net"
o.server=net
]]

--windows/linux/osx/bsd/nil    x64/x86
function osinfo()
	local platform
	local arch="x86"
	local s=os.getenv("PROCESSOR_ARCHITECTURE")
	if s then
		platform="windows"
		arch=s
	else
		s=system([[uname -a]])
		if s then
			s=string.lower(s)
			if find(s,"linux") then
				platform="linux"
				local r={}
				r[#r+1]=cat("/etc/redhat-release")
				r[#r+1]=cat("/usr/share/coreos/lsb-release")
				r[#r+1]=cat("/rom/etc/openwrt_release")
				r[#r+1]=cat("/etc/issue")
				r[#r+1]=cat("/etc/debian_version")
				r[#r+1]=cat("/etc/openwrt_version")
				r[#r+1]=cat("/proc/version")
				r[#r+1]=s
				s=string.lower(table.concat(r,","))
				if find(s,"openwrt") or find(s,"pandorabox") then
					platform="openwrt"
				end
			elseif find(s,"darwin") then
				platform="osx"
			elseif find(s,"bsd") then
				platform="bsd"
			else
				platform=nil
			end
			if file_exists("/usr/lib64") or file_exists("/lib64") then arch="x64" end
		end
	end
	return platform,arch
end

local osname,arch=osinfo() --windows x86
print(osname,arch)
local libname="?.so"
if osname=="windows" then
	libname="?.dll"
elseif osname=="osx" then
	libname="?.dylib"
end

print(package.cpath)
package.cpath='lib/'..osname..'/'..arch..'/'..libname..';lib/'..osname..'/'..libname
print(package.cpath)


local __json=require"json"
jsonencode=__json.encode
jsondecode=__json.decode

local __md5=require"md5"
md5=__md5.sumhexa
--md5bin=__md5.sum

--socket=require"socket"
--server=require"server"
----------------------------------------------------------
--setmetatable({},{__index=o})
--return o
