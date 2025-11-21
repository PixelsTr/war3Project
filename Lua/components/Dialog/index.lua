-- libs/Dialog.lua

Dialog = {}

-- 存储所有已创建的对话框及其回调函数
local DialogRegistry = {} 

-- 组件初始化（只运行一次）
function Dialog.Init()
    local t = CreateTrigger()
    
    -- 监听所有玩家的对话框事件
    TriggerRegisterDialogEvent(t, nil) 
    
    -- 所有对话框的点击都导向 HandleClick 函数
    TriggerAddAction(t, Dialog.HandleClick)
end

-- ---------------------------------
-- 公共方法
-- ---------------------------------

-- 创建一个新的对话框
-- @param owner: player (对话框的拥有者)
-- @param title: string (对话框标题)
-- @param callback: function (点击按钮时的回调函数)
-- @return dialog: dialog object
function Dialog.Create(owner, title, callback)
    local d = CreateDialog()
    DialogSetTitle(d, title)
    
    -- 将对话框对象和回调函数注册到全局表中
    DialogRegistry[d] = {
        owner = owner,
        callback = callback
    }
    
    return d
end

-- 显示对话框
function Dialog.Show(dialog)
    local entry = DialogRegistry[dialog]
    if entry then
        DialogDisplay(entry.owner, dialog, true)
    end
end

-- 添加按钮
function Dialog.AddButton(dialog, text)
    return DialogAddButton(dialog, text)
end

-- ---------------------------------
-- 事件处理
-- ---------------------------------

-- 核心点击事件处理函数
function Dialog.HandleClick()
    local clickedDialog = GetTriggerDialog()
    local clickedButton = GetClickedButton()
    
    local entry = DialogRegistry[clickedDialog]
    
    if entry and entry.callback then
        -- 调用创建该对话框时传入的回调函数
        entry.callback(entry.owner, clickedButton)
    end
    
    return true
end

return Dialog