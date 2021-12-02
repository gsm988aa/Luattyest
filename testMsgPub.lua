-- require"sys"
local  a = 22222222
local function pub()
    print("pub")
    sys.publish("TEST",a)       --可以发布多个变量sys.publish("TEST",1,2,3)
end
pub()


