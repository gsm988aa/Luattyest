-- module(...,package.seeall)

local function timerSS(  )
    print("timerSStimerSStimerSStimerSStimerSStimerSS function test")
end
--sys.timerStart(ss,3000)   --3秒运行一次
sys.timerLoopStart (timerSS,5000)  --循环定时器，每隔5秒运行一次



