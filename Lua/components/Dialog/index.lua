-- Dialog moudle
-- button(id) => dialog:show(id)
-- 

local Dialog = {}
Dialog.__index = Dialog


function Dialog:new(opts)
    local self = setmetatable({}, Dialog) -- 创建实例并绑定原型
    self.title = opts.title or ""
    return self
end
