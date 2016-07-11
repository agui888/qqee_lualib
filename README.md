# QQEE_LUALIB

***

### Luajit framework (cross platform & <2MB). Same code runs in different OS.
###### Windows / Linux / OSX / OpenWrt / BSD

***

####1/3. Why qqee_lualib ?   

* Luajit faster than Python above 1000%. and low memory used.

* Lua source file can be compiled to byte-code (protect sources).

* QQee_lualib has many modules: json / net / database / image / encrypt ... (upgrading)

####2/3. How use it ?    

* 1/4. Download qqee_lualib package and extract it. <a href="https://github.com/qqee/qqee_lualib/archive/master.zip">[Click To Download]</a>  

* 2/4. Select luajit executable file ( ./bin/ directory ) and copy to the directory where the [README.md] was located.

* 3/4. Delete not be used directorys from [./lib/].

* 4/4. Read [demo.*.lua] files. Write your own code. run it with [./luajit yourcode.lua].

* Compiled to byte-code : [./luajit -b file.lua compiled.lua].

* Delete [./jit/] directory.

####3/3. APIs list.

* lib. (Must be loaded first. Pure Lua code.)

```lua
require"lib"
--------------
print_r(tablename) --print table. same of php.
cat(filename)  --same of shell 'cat'.
trim(string)
file_exists(file) --return true/false
system(cmd)
bin2hex(str,spacecode_or_null)
hex2bin(hexstr,format_str_or_null)
hex2ip("FFFFFFFF")
urlencode(str)
urldecode(str)
jsonencode(table)
jsondecode(string)
md5(str)
```

* www_qq_ee. (Pure C code.)

```lua
local qqee=require"www_qq_ee"
--------------
local s,err=qqee.replace("ABCDEFG","CDE","++++++++++",1)
local where=qqee.find("ABCDEFG","CDE") --nil/0~n
local _10=qqee._16to10("FFFFFFFFFFFFFFFF")
local _16=qqee._10to16(65535)
local md5str=qqee.md5("ABCDEFG")
local str=qqee.trim("  ABC EF  ")
local str=qqee.trimall("  ABC EF  ")
local true_false=qqee.stringisnumber("123456789")
local arr=qqee.split("a,b,c,d,e",",")
local t_us=qqee.us() --length 13
local zone=qqee.timezone() -- -12~12
local str=qqee.upper("abcdef")
local str=qqee.lower("ABCDEF")
local sha=qqee.sha1("abcdef")
local str=qqee.urlencode("abcdef")
local str=qqee.urldecode("%u67f3\u67f3%e7%90")
local str=qqee.base64encode("abcdef")
local str=qqee.base64decode("abcdef")
local s=qqee.ip4stringtouint32("1.2.3.4",1)
local s=qqee.ip4uint32tostring(4294967295)
local s=qqee.random(1,99999)
local s=qqee.bin2hex("abcdefg")
local s=qqee.hex2bin("5ab12e0c3f")

--64bit int support. [ + - * / % & | ^ = < > ]
local str=qqee.int32("18446744073709551615","-","10")
local str=qqee.uint32("18446744073709551615","*","20")
local str=qqee.int64("18446744073709551615","/","30")
local str=qqee.uint64("18446744073709551615","%","100")

local bool=qqee.mkdir("/root/a/b/c")
local arr,nums=qqee.ls("/temp/",0all_1file_2dir,1includeSubpath)
local bool=qqee.exists("Z:\\TEMP")
qqee.isdir("Z:\\TEMP")
local bool=qqee.chmod("Z:\\TEMP",777)
qqee.sleep(1000) --ms
```

* socket. (luasocket lite version.) <a href="http://w3.impa.br/~diego/software/luasocket/">[Home-page]</a>  <a href="http://w3.impa.br/~diego/software/luasocket/socket.html">[Document-SOCKET]</a>  <a href="http://w3.impa.br/~diego/software/luasocket/tcp.html">[Document-TCP]</a>  <a href="http://w3.impa.br/~diego/software/luasocket/udp.html">[Document-UDP]</a>  <a href="http://w3.impa.br/~diego/software/luasocket/dns.html">[Document-DNS]</a>

```lua
local socket=require"socket"
--------------
local ss=socket.bind("*",port)
ss:setoption("reuseaddr",true)
ss:send("YES\r\n")
ss:close()
local ss=socket.udp()
ss:setsockname("*",888)
ss:sendto(data,ip,port)

socket.tcp()
socket.tcp6()
socket.udp()
socket.udp4()
socket.udp6()
socket.sleep()
socket.connect()
socket.connect4()
socket.connect6()
socket.gettime()
socket.select()

socket.dns.tohostname()
socket.dns.toip()
socket.dns.gethostname()
socket.dns.getaddrinfo()
socket.dns.getnameinfo()
```

* server.    

```lua
local server=require"server"
--------------
server.addserver(socket,client_call_back_function,0)
server.addthread(funct)
local socket=server.wrap(client)
server.sleep(20) --s
server.loop()
```

* sqlite.    

```lua
local sqlite=require"sqlite"
--------------
sqlite.sqlite_exec()
sqlite.sqlite_open()
sqlite.sqlite_close()
```

* vedis. (An embedded mem/file NoSQL database/queue-list) <a href="https://vedis.symisc.net/">[Go to the home page]</a>

```lua
local vedis=require"vedis"
--------------
vedis.vedis_del()
vedis.vedis_get()
vedis.vedis_exec()
vedis.vedis_commit()
vedis.vedis_append()
vedis.vedis_set()
vedis.vedis_open()
vedis.vedis_rollback()
vedis.vedis_begin()
vedis.vedis_close()
```

* gd. (libgd/luagd full version. With jpeg/png/gif/freetype) <a href="http://www.luteus.biz/Download/LoriotPro_Doc/LUA/LUA_For_Windows/luagd/index.html">[Go to the document page]</a>

```lua
local gd=require"gd"
```


***
