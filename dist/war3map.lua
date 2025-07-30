local Dialog = require("components.dialog.index")

local dlg = Dialog({
    title = "系统提示",
    content = "你确定要退出吗？",
    onConfirm = function()
        print("确认退出")
    end,
    onCancel = function()
        print("继续游戏")
    end
})

dlg:show()

--
-- 自定义单位属性模块
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

-- 监听拾取/丢弃事件

-- equip_events.lua
-- 注册拾取、丢弃等事件，并处理装备穿脱

function InitEquipEvents()
    local trg = CreateTrigger()
    for i = 0, bj_MAX_PLAYER_SLOTS - 1 do
        TriggerRegisterPlayerUnitEvent(trg, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, nil)
    end
    TriggerAddAction(trg, function()
        local unit = GetTriggerUnit()
        local item = GetManipulatedItem()
        local itemId = GetItemTypeId(item)

        -- 判断是否是定义中的装备
        if ItemData[itemId] then
            EquipItem(unit, itemId)
            DisplayTextToPlayer(GetOwningPlayer(unit), 0, 0, "你装备了：" .. ItemData[itemId].name)
        end
    end)
end

-- 穿戴逻辑（加属性、卸载）

-- equip_system.lua
-- 管理装备穿戴与卸载、属性计算逻辑

UnitEquips = {} -- 用于记录每个单位穿戴的装备（按槽位）

-- 初始化单位的穿戴记录（在单位创建时调用）
function InitUnitEquipState(unit)
    UnitEquips[unit] = {
        weapon = nil,
        shield = nil
    }
end

-- 添加属性辅助函数
function AddUnitStat(unit, key, value)
    -- 示例：此处直接修改英雄攻击力（可根据实际属性系统扩展）
    if key == "atk" then
        UnitAddAttack(unit, value)
    elseif key == "str" then
        ModifyHeroStat(bj_HEROSTAT_STR, unit, bj_MODIFYMETHOD_ADD, value)
    elseif key == "def" then
        -- 假设你后续会自建防御系统
    end
end

-- 穿戴装备
function EquipItem(unit, itemId)
    local meta = ItemData[itemId]
    if not meta then return end

    local slot = meta.slot
    if not UnitEquips[unit] then InitUnitEquipState(unit) end

    -- 若已有旧装备，先卸下
    local oldId = UnitEquips[unit][slot]
    if oldId then
        UnEquipItem(unit, oldId)
    end

    -- 穿戴新装备并加属性
    UnitEquips[unit][slot] = itemId
    for key, value in pairs(meta) do
        AddUnitStat(unit, key, value)
    end
end

-- 卸下装备
function UnEquipItem(unit, itemId)
    local meta = ItemData[itemId]
    if not meta then return end

    for key, value in pairs(meta) do
        AddUnitStat(unit, key, -value) -- 移除属性加成
    end
end

-- 装备基础数据（属性、名称等）

-- 所有装备的属性配置，使用物品ID作为索引

ItemData = {
    ['I001'] = {
        name = "烈焰之剑", -- 装备名称
        slot = "weapon", -- 装备类型（武器槽位）
        atk = 25, -- 额外攻击力
        str = 5, -- 力量加成
        quality = "epic" -- 品质，仅供UI或掉落系统使用
    },
    ['I002'] = {
        name = "守护者之盾",
        slot = "shield",
        def = 10,
        hp = 100,
        quality = "rare"
    }
}
