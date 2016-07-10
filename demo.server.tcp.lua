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
--TCP
local client_call_back_tcp=function(client)
	local C=server.wrap(client)
	--C:send("220 OK READY\r\n")
	--C_id=client_id+1
	local client_ip=C.socket:getpeername()
	print(client_ip)
	while true do
		local command=C:receive()
		if command then
			print("["..command.."]")
			if #command==0 then
				break
			end
		else
			print("Client.Close!")
			break
		end
	end
	C:send("YES\r\n")
	C:close()
end
local port=80
local ss=socket.bind("*",port)
--ss:setoption("reuseaddr",true)

server.addserver(ss,client_call_back_tcp,0)

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

