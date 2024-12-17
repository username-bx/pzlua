-- 引用 LuaSocket
local socket = require("luasocket.socket")
local http = require("luasocket.http")

-- 发送一个 HTTP GET 请求的示例
local response, status = http.request("http://example.com")

if status == 200 then
    print("请求成功!")
    print("响应内容：\n" .. response)
else
    print("请求失败，状态码：" .. status)
end
