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


-- 1. 按键h获取用户位置，并喊话
-- 2. 按键h获取用户位置，并喊话，生成5个僵尸
-- 3. 按键h获取用户位置，并喊话，生成5个僵尸，