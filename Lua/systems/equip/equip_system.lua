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
