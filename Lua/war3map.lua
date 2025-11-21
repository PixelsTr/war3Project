App = App or {
    config   = {},
    services = {},
    systems  = {},
    state    = {},
}

function App.bootstrap()
    App.initConfig()          -- 初始化配置
    App.initLogger()          -- 初始化日志系统
    App.initCoreLibs()        -- 初始化核心库
    App.initEventBus()        -- 初始化事件总线
    App.initEngineBridges()   -- 初始化引擎桥接
    App.initSystems()         -- 初始化系统
    App.registerGameContent() -- 注册游戏内容
    App.initUI()              -- 初始化UI
    App.startGame()           -- 启动游戏
end
