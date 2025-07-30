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
