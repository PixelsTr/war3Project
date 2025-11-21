-- components/index.lua

-- 1. 导入所有子组件
-- 假设 DialogComponent 的主文件在 components/dialog/index.lua
local Dialog = require "components.Dialog.index"

-- 假设 EquipSystem 的主文件在 components/equip/index.lua
local Equip = require "components.equip.index"

local Log = require "components.Logger.index"

-- 2. 创建 Core 模块，用于暴露给 war3map.lua
local Core = {}

-- 3. 统一初始化函数
function Core.Init()
    -- 初始化底层组件 (例如，DialogComponent 需要先注册监听器)
    Dialog.Init()

    -- 初始化业务系统
    Equip.Init()
    -- 初始化 Log
    Log.Init()
    -- 打印日志或执行其他全局初始化
    print("所有游戏组件已初始化完成。")
end

-- 4. 返回 Core 模块，供 war3map.lua 接收
return Core
