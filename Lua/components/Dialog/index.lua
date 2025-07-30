local Dialog = {}
Dialog.__index = Dialog

-- 构造函数
function Dialog:new(opts)
    local self = setmetatable({}, Dialog)
    self.title = opts.title or "标题"
    self.content = opts.content or ""
    self.onConfirm = opts.onConfirm
    self.onCancel = opts.onCancel
    return self
end

-- 展示方法
function Dialog:show()
    -- 创建一个War3对话框并展示（这里只是伪代码）
    local dlg = DialogCreate()
    DialogSetMessage(dlg, self.content)
    DialogAddButton(dlg, "确定", 0)
    DialogAddButton(dlg, "取消", 1)
    DialogDisplay(GetLocalPlayer(), dlg, true)

    TriggerRegisterDialogEvent(self:getTrigger(), dlg)
end

-- 触发器处理
function Dialog:getTrigger()
    local trig = CreateTrigger()
    TriggerAddAction(trig, function()
        local btn = GetClickedButton()
        local clicked = GetButtonText(btn)

        if clicked == "确定" and self.onConfirm then
            self.onConfirm()
        elseif clicked == "取消" and self.onCancel then
            self.onCancel()
        end
    end)
    return trig
end

-- 工厂方法
return function(opts)
    return Dialog:new(opts)
end
