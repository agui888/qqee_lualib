package.path='lib/?.lua;'
require"lib"
socket=require"socket"
server=require"server"
-----------------------------------------------------------------------
local time=os.time
local date=os.date
local sub=string.sub
local gsub=string.gsub
local match=string.match
local find=string.find
local len=string.len
local lower=string.lower
local concat=table.concat
local insert=table.insert
local remove=table.remove
-----------------------------------------------------------------------
print(osinfo())
print_r(server)







-----------------------------------------------------------------------
--UDP
local client_call_back_udp=function(client)
	local C=server.wrap(client)
	while true do
		--print(C:receive()) --abcdeZ. nil     nil
		--print(C:receivefrom()) --abcdeZ. 127.0.0.1       19730
		--print("getsockname", C:getsockname())  --getsockname     127.0.0.1       888   inet
		
		local data,ip,port=C:receivefrom()
		print(data,ip,port)
		print(C:sendto(data,ip,port)) --7       nil
	end
end
local ss=socket.udp()
--print(tostring(ss))
ss:setoption("reuseaddr",true)
ss:setsockname("*",888) --print("setsockname",ss:setsockname("*",888)) --1
--print("setsockname",ss:setsockname("127.0.0.1", 888))
--print("setpeername",ss:setpeername("*",888))

server.addserver(ss,client_call_back_udp,0)

--[[
server.addthread(function()
	while true do
		server.sleep(20)
		hot.f_20s()
	end
end)
]]

print("--------===== Start OK , "..date("%Y/%m/%d %H:%M:%S").." =====--------")
--log_it('Start OK')
collectgarbage("collect")
server.loop()

