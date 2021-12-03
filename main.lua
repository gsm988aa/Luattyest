
PROJECT = "main"
VERSION = "1.0.4"

log.info("main", PROJECT, VERSION)

-- 引入必要的库文件(lua编写), 内部库不需要require
sys = require "sys"

if wdt then
    --添加硬狗防止程序卡死，在支持的设备上启用这个功能
    wdt.init(15000)--初始化watchdog设置为15s
    sys.timerLoopStart(wdt.feed, 10000)--10s喂一次狗
end


-- require "uart5"
require "uart6"
sys.init(0, 0)
-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
