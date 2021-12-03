-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "uart_irq"
VERSION = "1.0.1"

log.info("uart6irq", PROJECT, VERSION)

-- 引入必要的库文件(lua编写), 内部库不需要require
local sys = require "sys"

if wdt then
    --添加硬狗防止程序卡死，在支持的设备上启用这个功能
    wdt.init(15000)--初始化watchdog设置为15s
    sys.timerLoopStart(wdt.feed, 10000)--10s喂一次狗
end

log.info("main", "uart6 demo")
local uartid1 = 1 -- 根据实际设备选取不同的uartid
local uartid2 = 2 -- 根据实际设备选取不同的uartid
local uartid3 = 3 -- 根据实际设备选取不同的uartid
local uartid4 = 4 -- 根据实际设备选取不同的uartid
local uartid5 = 5 -- 根据实际设备选取不同的uartid
--初始化
local result1 = uart.setup(
    uartid1,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result2 = uart.setup(
    uartid2,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result3 = uart.setup(
    uartid3,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result4 = uart.setup(
    uartid4,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result5 = uart.setup(
    uartid5,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)

--循环发数据
sys.timerLoopStart(uart.write,1000, uartid1, "updataTem")
sys.timerLoopStart(uart.write,1000, uartid2, "updataTem")
sys.timerLoopStart(uart.write,1000, uartid3, "updataTem")
sys.timerLoopStart(uart.write,1000, uartid4, "updataTem")
sys.timerLoopStart(uart.write,1000, uartid5, "updataTem")
-- 收取数据会触发回调, 这里的"receive" 是固定值
uart.on(uartid1, "receive", function(id, len)
    local s1 = ""
    repeat
        -- 如果是air302, len不可信, 传1024
        -- s = uart.read(id, 1024)
        s1 = uart.read(id, len)
        if #s1 > 0 then -- #s 是取字符串的长度
            -- 如果传输二进制/十六进制数据, 部分字符不可见, 不代表没收到
            -- 关于收发hex值,请查阅 https://doc.openluat.com/article/583
            log.info("uart", "receive", id, #s1, s1)
            -- log.info("uart", "receive", id, #s, s:toHex())
        end
    until s1 == ""
end)
uart.on(uartid2, "receive", function(id, len)
    local s2 = ""
    repeat
        -- 如果是air302, len不可信, 传1024
        -- s = uart.read(id, 1024)
        s2 = uart.read(id, len)
        if #s2 > 0 then -- #s 是取字符串的长度
            -- 如果传输二进制/十六进制数据, 部分字符不可见, 不代表没收到
            -- 关于收发hex值,请查阅 https://doc.openluat.com/article/583
            log.info("uart", "receive", id, #s2, s2)
            -- log.info("uart", "receive", id, #s, s:toHex())
        end
    until s2 == ""
end)
uart.on(uartid3, "receive", function(id, len)
    local s3 = ""
    repeat
        -- 如果是air302, len不可信, 传1024
        -- s = uart.read(id, 1024)
        s3 = uart.read(id, len)
        if #s3 > 0 then -- #s 是取字符串的长度
            -- 如果传输二进制/十六进制数据, 部分字符不可见, 不代表没收到
            -- 关于收发hex值,请查阅 https://doc.openluat.com/article/583
            log.info("uart", "receive", id, #s3, s3)
            -- log.info("uart", "receive", id, #s, s:toHex())
        end
    until s3 == ""
end)
uart.on(uartid4, "receive", function(id, len)
    local s4 = ""
    repeat
        -- 如果是air302, len不可信, 传1024
        -- s = uart.read(id, 1024)
        s4 = uart.read(id, len)
        if #s4 > 0 then -- #s 是取字符串的长度
            -- 如果传输二进制/十六进制数据, 部分字符不可见, 不代表没收到
            -- 关于收发hex值,请查阅 https://doc.openluat.com/article/583
            log.info("uart", "receive", id, #s4, s4)
            -- log.info("uart", "receive", id, #s, s:toHex())
        end
    until s4 == ""
end)
uart.on(uartid5, "receive", function(id, len)
    local s5 = ""
    repeat
        -- 如果是air302, len不可信, 传1024
        -- s = uart.read(id, 1024)
        s5 = uart.read(id, len)
        if #s5 > 0 then -- #s 是取字符串的长度
            -- 如果传输二进制/十六进制数据, 部分字符不可见, 不代表没收到
            -- 关于收发hex值,请查阅 https://doc.openluat.com/article/583
            log.info("uart", "receive", id, #s5, s5)
            -- log.info("uart", "receive", id, #s, s:toHex())
        end
    until s5 == ""
end)
-- 并非所有设备都支持sent事件
-- uart.on(uartid, "sent", function(id)
--     log.info("uart", "sent", id)
-- end)

-- sys.taskInit(function()
--     while 1 do
--         sys.wait(500)
--     end
-- end)


-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
