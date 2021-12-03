
-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "uart5_timeout"
VERSION = "1.0.5"

log.info("main", PROJECT, VERSION)

-- 引入必要的库文件(lua编写), 内部库不需要require
local sys = require "sys"

log.info("main", "uart5 demo")

-- 串口ID,串口读缓冲区
local UART_ID, sendQueue = 1, {}
local UART_ID2, sendQueue2 = 2, {}
local UART_ID3, sendQueue3 = 3, {}
local UART_ID4, sendQueue4 = 4, {}
local UART_ID5, sendQueue5 = 5, {}
-- 串口超时，串口准备好后发布的消息
--例子是100ms，按需求改
local uartimeout = 80
local recvReady = "UART_RECV_ID"
local recvReady2 = "UART_RECV_ID2"
local recvReady3 = "UART_RECV_ID3"
local recvReady4 = "UART_RECV_ID4"
local recvReady5 = "UART_RECV_ID5"
--初始化
local result = uart.setup(
    UART_ID,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)

local result2 = uart.setup(
    UART_ID2,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)

local result3 = uart.setup(
    UART_ID3,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result4 = uart.setup(
    UART_ID4,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)
local result5 = uart.setup(
    UART_ID5,--串口id
    9600,--波特率
    8,--数据位
    1--停止位
)

-- -- 注册串口事件回调uart.on(id, event    事件名称, func回调方法)
-- 回调方法
uart.on(UART_ID, "receive", function(uid, length)
    local s
    while true do--保证读完不能丢包
        s = uart.read(uid, length)
        if #s == 0 then break end
        table.insert(sendQueue, s)

        log.info("uart", "receive", id, #s, s)

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
    sys.timerStart(sys.publish, uartimeout, recvReady2)
end)


uart.on(UART_ID3, "receive", function(uid, length)
    local s3
    while true do--保证读完不能丢包
        s3 = uart.read(uid, length)
        if #s3 == 0 then break end
        table.insert(sendQueue3, s3)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady3)
end)

uart.on(UART_ID4, "receive", function(uid, length)
    local s4
    while true do--保证读完不能丢包
        s4 = uart.read(uid, length)
        if #s4 == 0 then break end
        table.insert(sendQueue4, s4)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady4)
end)

uart.on(UART_ID5, "receive", function(uid, length)
    local s5
    while true do--保证读完不能丢包
        s5 = uart.read(uid, length)
        if #s5 == 0 then break end
        table.insert(sendQueue5, s5)
    end
    sys.timerStart(sys.publish, uartimeout, recvReady5)
end)


-- 向串口发送收到的字符串
sys.subscribe(recvReady, function()
    --拼接所有收到的数据
    local str = table.concat(sendQueue)

    -- 串口的数据读完后清空缓冲区
    sendQueue = {}

    --注意打印会影响运行速度，调试完注释掉
    print("sendQueue")
    log.info("uartTask1.read length", #str, str:sub(1,100))
    str = "updataObj"
    uart.write(UART_ID,str) --回复

    --在这里处理接收到的数据，这是例子
end)
-- 向串口发送收到的字符串
sys.subscribe(recvReady2, function()
    --拼接所有收到的数据

    local str2 = table.concat(sendQueue2)
    -- 串口的数据读完后清空缓冲区
    sendQueue2 = {}
    --注意打印会影响运行速度，调试完注释掉
    log.info("uartTask2.read length", #str, str:sub(1,100))
    -- uart.write(UART_ID2,str2) --回复
    --在这里处理接收到的数据，这是例子
end)

-- 向串口发送收到的字符串
sys.subscribe(recvReady3, function()
    --拼接所有收到的数据
    local str3 = table.concat(sendQueue3)
    -- 串口的数据读完后清空缓冲区
    sendQueue3 = {}
    --注意打印会影响运行速度，调试完注释掉
    log.info("uartTask3.read length", #str, str:sub(1,100))
    -- uart.write(UART_ID3,str3) --回复
    --在这里处理接收到的数据，这是例子
end)

-- 向串口发送收到的字符串
sys.subscribe(recvReady4, function()
    --拼接所有收到的数据
    local str4 = table.concat(sendQueue4)
    -- 串口的数据读完后清空缓冲区
    sendQueue4 = {}
    --注意打印会影响运行速度，调试完注释掉
    log.info("uartTask4.read length", #str, str:sub(1,100))
    -- uart.write(UART_ID4,str4) --回复
    --在这里处理接收到的数据，这是例子
end)

-- 向串口发送收到的字符串
sys.subscribe(recvReady5, function()
    --拼接所有收到的数据
    local str5 = table.concat(sendQueue5)
    -- 串口的数据读完后清空缓冲区
    sendQueue5 = {}
    --注意打印会影响运行速度，调试完注释掉
    log.info("uartTask5.read length", #str, str:sub(1,100))
    -- uart.write(UART_ID5,str5) --回复
    --在这里处理接收到的数据，这是例子
end)

-- local function timerSS(  )
--     print("timerSStimerSStimerSStimerSStimerSStimerSS function test")
-- end
-- --sys.timerStart(ss,3000)   --3秒运行一次
-- sys.timerLoopStart (timerSS,5000)  --循环定时器，每隔5秒运行一次

-- local sendtemperature = "updataObj"
sys.timerLoopStart(uart.write,1000, UART_ID, "updataObj")
-- sys.timerLoopStart(uart.write,1000, UART_ID2, "updataObj")
-- sys.timerLoopStart(uart.write,1000, UART_ID3, "updataObj")
-- sys.timerLoopStart(uart.write,1000, UART_ID4, "updataObj")
-- sys.timerLoopStart(uart.write,1000, UART_ID5, "updataObj")

-- local function timerSSUARTS(  )
--     uart.write(UART_ID1,sendtemperature)
--     sys.wait(10)
--     uart.write(UART_ID2,sendtemperature)
--     sys.wait(10)
--     uart.write(UART_ID3,sendtemperature)
--     sys.wait(10)
--     uart.write(UART_ID4,sendtemperature)
--     sys.wait(10)
--     uart.write(UART_ID,sendtemperature)
--     sys.wait(10)
-- end
-- --sys.timerStart(ss,3000)   --3秒运行一次
-- sys.timerLoopStart (timerSSUARTS,1000)  --循环定时器，每隔1秒运行一次

-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
-- sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
