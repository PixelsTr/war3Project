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
