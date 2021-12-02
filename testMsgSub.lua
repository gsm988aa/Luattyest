-- require"sys"
local function subCallBack()
    print("rev", a)
end

sys.subscribe("TEST", subCallBack)
