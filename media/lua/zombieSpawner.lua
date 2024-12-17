-- ZombieSpawner.lua
-- 这个脚本会在玩家附近定期生成僵尸

-- 获取玩家对象
local player = getPlayer()

-- 僵尸生成函数
function spawnZombiesNearPlayer(player)
    local x = player:getX()
    local y = player:getY()
    local z = player:getZ()

    -- 设定生成僵尸的半径范围
    local radius = 10
    local count = 5  -- 设定每次生成的僵尸数量

    for i = 1, count do
        -- 随机生成僵尸的位置（在玩家周围的半径范围内）
        local zombieX = x + math.random(-radius, radius)
        local zombieY = y + math.random(-radius, radius)
        local zombieZ = z

        -- 创建僵尸并加入游戏世界
        local zombie = IsoZombie.new(zombieX, zombieY, zombieZ)
        getCell():addZombie(zombie)
    end
end

-- 每个游戏刻（tick）检查并生成僵尸
function onGameTick()
    -- 每隔一段时间生成僵尸
    spawnZombiesNearPlayer(player)
end

-- 注册游戏刻事件，定期调用 onGameTick 函数
Events.OnTick.Add(onGameTick)




local https = require("ssl.https")  -- 使用 ssl.https 来发送 GET 请求
local json = require("dkjson")     -- 使用 dkjson 来解析 JSON 数据

-- 替换为你的 Bot Token 和频道 ID
local bot_token = "YOUR_BOT_TOKEN"
local channel_id = "YOUR_CHANNEL_ID"

-- 构造 Discord API 请求 URL
local url = "https://discord.com/api/v10/channels/" .. channel_id .. "/messages"

-- 设置请求头
local headers = {
    ["Authorization"] = "Bot " .. bot_token,
    ["User-Agent"] = "LuaScript (https://yourbotwebsite.com, v1.0)",
}

-- 发送 GET 请求并获取响应
local response_body, status_code, response_headers = https.request{
    url = url,
    headers = headers,
}

-- 检查请求是否成功
if status_code == 200 then
    -- 解析 JSON 响应
    local messages, pos, err = json.decode(response_body, 1, nil)

    if err then
        print("Error decoding JSON: " .. err)
    else
        -- 输出消息内容
        for _, message in ipairs(messages) do
            print(message.author.username .. ": " .. message.content)
        end
    end
else
    print("Failed to fetch messages. Status code: " .. status_code)
end




-- 模拟玩家喊话的函数
function playerShouts(message)
    local player = getPlayer()  -- 获取当前玩家对象

    if player then
        local x = player:getX()  -- 玩家当前的 X 坐标
        local y = player:getY()  -- 玩家当前的 Y 坐标
        local z = player:getZ()  -- 玩家当前的 Z 坐标（楼层）

        -- 在当前玩家位置创建一个声音事件
        -- SoundType为 0 表示普通的喊话声音，玩家可以听到
        -- 这里可以调整音量范围以及声音持续时间
        local sound = "player shout: " .. message  -- 这里设置要显示的喊话内容
        getCell():getWorld():addSound(player, x, y, z, 20, 10, sound)  -- 创建声音事件，20 是音量，10 是持续时间
    end
end

-- 让玩家喊话"帮助！"的示例
playerShouts("帮助！")


local function onKeyPress(key)
    if key == "H" then  -- 当按下 "H" 键时
        playerShouts("这里有僵尸！")  -- 让玩家喊话
    end
end

-- 监听按键事件
Events.OnKeyPressed.Add(onKeyPress)

