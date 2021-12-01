-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "uart_timeout"
VERSION = "1.0.0"

log.info("main", PROJECT, VERSION)

-- 引入必要的库文件(lua编写), 内部库不需要require
local sys = require "sys"

if wdt then
    --添加硬狗防止程序卡死，在支持的设备上启用这个功能
    wdt.init(15000)--初始化watchdog设置为15s
    sys.timerLoopStart(wdt.feed, 10000)--10s喂一次狗
end

log.info("main", "uart demo")

-- 串口ID,串口读缓冲区
local UART_ID, sendQueue = 1, {}
local UART_ID2, sendQueue2 = 2, {}
local UART_ID3, sendQueue3 = 3, {}

-- 串口超时，串口准备好后发布的消息
--例子是100ms，按需求改
local uartimeout, recvReady = 100, "UART_RECV_ID"
--初始化
local result = uart.setup(
    UART_ID,--串口id
    115200,--波特率
    8,--数据位
    1--停止位
)

local result2 = uart.setup(
    UART_ID2,--串口id
    115200,--波特率
    8,--数据位
    1--停止位
)

local result3 = uart.setup(
    UART_ID3,--串口id
    115200,--波特率
    8,--数据位
    1--停止位
)


uart.on(UART_ID, "receive", function(uid, length)
    local s
    while true do--保证读完不能丢包
        s = uart.read(uid, length)
        if #s == 0 then break end
        table.insert(sendQueue, s)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady)
end)


uart.on(UART_ID2, "receive", function(uid, length)
    local s2
    while true do--保证读完不能丢包
        s2 = uart.read(uid, length)
        if #s2 == 0 then break end
        table.insert(sendQueue2, s2)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady)
end)


uart.on(UART_ID3, "receive", function(uid, length)
    local s3
    while true do--保证读完不能丢包
        s3 = uart.read(uid, length)
        if #s3 == 0 then break end
        table.insert(sendQueue3, s3)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady)
end)


-- 向串口发送收到的字符串
sys.subscribe(recvReady, function()
    --拼接所有收到的数据
    local str = table.concat(sendQueue)
    local str2 = table.concat(sendQueue2)
    local str3 = table.concat(sendQueue3)
    -- 串口的数据读完后清空缓冲区
    sendQueue = {}
    sendQueue2 = {}
    sendQueue3 = {}
    --注意打印会影响运行速度，调试完注释掉
    --log.info("uartTask.read length", #str, str:sub(1,100))
    uart.write(UART_ID,str) --回复
    uart.write(UART_ID2,str2) --回复
    uart.write(UART_ID3,str3) --回复
    --在这里处理接收到的数据，这是例子
end)


-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
