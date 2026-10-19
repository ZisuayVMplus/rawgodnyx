local UI = (function()

local a = { cache = {} }
do
    do
        local function b()
            local c = {}
            c.__index = c
            function c.new()
                return setmetatable({ _tasks = {}, _dead = false }, c)
            end
            local function d(e)
                local f = typeof(e)
                if f == "RBXScriptConnection" then
                    e:Disconnect()
                elseif f == "Instance" then
                    e:Destroy()
                elseif f == "function" then
                    e()
                elseif f == "thread" then
                    if coroutine.status(e) ~= "dead" then
                        pcall(task.cancel, e)
                    end
                elseif f == "Tween" then
                    e:Cancel()
                elseif f == "table" then
                    if type(e.Destroy) == "function" then
                        e:Destroy()
                    elseif type(e.Clean) == "function" then
                        e:Clean()
                    elseif type(e.Disconnect) == "function" then
                        e:Disconnect()
                    end
                end
            end
            function c:Give(e)
                if self._dead then
                    pcall(d, e)
                    return e
                end
                table.insert(self._tasks, e)
                return e
            end
            function c:Connect(e, f)
                return self:Give(e:Connect(f))
            end
            function c:Sub()
                return self:Give(c.new())
            end
            function c:Clean()
                local e = self._tasks
                self._tasks = {}
                for f = #e, 1, -1 do
                    local g, h = pcall(d, e[f])
                    if not g then
                        warn("[shadcn] maid task failed to clean: " .. tostring(h))
                    end
                end
            end
            function c:Destroy()
                self._dead = true
                self:Clean()
            end
            function c:Count()
                return #self._tasks
            end
            return c
        end
        function a.Maid()
            local c = a.cache.a
            if not c then
                c = { c = b() }
                a.cache.a = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c = game:GetService("TweenService")
            local function d(e)
                return Color3.fromHex(e)
            end
            local e = {}
            e.Themes = {
                Dark = {
                    Background = d("0d0f12"),
                    Foreground = d("d3d6de"),
                    Card = d("15171b"),
                    CardForeground = d("d3d6de"),
                    Primary = d("2156d7"),
                    PrimaryForeground = d("fafafa"),
                    Secondary = d("24262b"),
                    SecondaryForeground = d("d3d6de"),
                    Muted = d("24262b"),
                    MutedForeground = d("888c94"),
                    Accent = d("24262b"),
                    AccentForeground = d("d3d6de"),
                    Destructive = d("dc2626"),
                    DestructiveForeground = d("fafafa"),
                    Border = d("2e3036"),
                    Input = d("2e3036"),
                    Ring = d("51628c"),
                    Sidebar = d("131418"),
                    SidebarForeground = d("d3d6de"),
                    SidebarAccent = d("212429"),
                    SidebarBorder = d("2e3036"),
                    SidebarPrimary = d("4477f2"),
                    SidebarPrimaryForeground = d("fafafa"),
                    Shadow = d("000000"),
                    SwitchThumb = d("d3d6de"),
                    Popover = d("1a1b20"),
                },
                Light = {
                    Background = d("ececee"),
                    Foreground = d("232324"),
                    Card = d("f4f4f5"),
                    CardForeground = d("232324"),
                    Primary = d("27272a"),
                    PrimaryForeground = d("fafafa"),
                    Secondary = d("e4e4e7"),
                    SecondaryForeground = d("232324"),
                    Muted = d("e4e4e7"),
                    MutedForeground = d("6a6a6b"),
                    Accent = d("dcdce0"),
                    AccentForeground = d("232324"),
                    Destructive = d("dc2626"),
                    DestructiveForeground = d("fafafa"),
                    Border = d("d4d4d8"),
                    Input = d("d4d4d8"),
                    Ring = d("71717a"),
                    Sidebar = d("e4e4e7"),
                    SidebarForeground = d("232324"),
                    SidebarAccent = d("d4d4d8"),
                    SidebarBorder = d("d4d4d8"),
                    SidebarPrimary = d("27272a"),
                    SidebarPrimaryForeground = d("fafafa"),
                    Shadow = d("000000"),
                    SwitchThumb = d("ffffff"),
                    Popover = d("f4f4f5"),
                },
                White = {
                    Background = d("ffffff"),
                    Foreground = d("262626"),
                    Card = d("ffffff"),
                    CardForeground = d("262626"),
                    Primary = d("18181b"),
                    PrimaryForeground = d("fafafa"),
                    Secondary = d("f4f4f5"),
                    SecondaryForeground = d("262626"),
                    Muted = d("f4f4f5"),
                    MutedForeground = d("737373"),
                    Accent = d("f4f4f5"),
                    AccentForeground = d("262626"),
                    Destructive = d("ef4444"),
                    DestructiveForeground = d("fafafa"),
                    Border = d("e4e4e7"),
                    Input = d("e4e4e7"),
                    Ring = d("18181b"),
                    Sidebar = d("fafafa"),
                    SidebarForeground = d("262626"),
                    SidebarAccent = d("f4f4f5"),
                    SidebarBorder = d("e4e4e7"),
                    SidebarPrimary = d("18181b"),
                    SidebarPrimaryForeground = d("fafafa"),
                    Shadow = d("000000"),
                    SwitchThumb = d("ffffff"),
                    Popover = d("ffffff"),
                },
            }
            e.Accents = {
                Default = {
                    Light = {
                        Primary = d("2156d7"),
                        PrimaryForeground = d("fafafa"),
                        Ring = d("2156d7"),
                        SidebarPrimary = d("2156d7"),
                        SidebarPrimaryForeground = d("fafafa"),
                    },
                },
                Zinc = {
                    Dark = {
                        Primary = d("fafafa"),
                        PrimaryForeground = d("18181b"),
                        Ring = d("d4d4d8"),
                        SidebarPrimary = d("fafafa"),
                        SidebarPrimaryForeground = d("18181b"),
                    },
                    Light = {
                        Primary = d("27272a"),
                        PrimaryForeground = d("fafafa"),
                        Ring = d("71717a"),
                        SidebarPrimary = d("27272a"),
                        SidebarPrimaryForeground = d("fafafa"),
                    },
                },
                Blue = {
                    Dark = { Primary = d("3b82f6"), PrimaryForeground = d("f8fafc"), Ring = d("1d4ed8") },
                    Light = { Primary = d("2563eb"), PrimaryForeground = d("f8fafc"), Ring = d("2563eb") },
                },
                Green = {
                    Dark = { Primary = d("22c55e"), PrimaryForeground = d("052e16"), Ring = d("15803d") },
                    Light = { Primary = d("16a34a"), PrimaryForeground = d("f0fdf4"), Ring = d("16a34a") },
                },
                Orange = {
                    Dark = { Primary = d("ea580c"), PrimaryForeground = d("fafaf9"), Ring = d("ea580c") },
                    Light = { Primary = d("f97316"), PrimaryForeground = d("fafaf9"), Ring = d("f97316") },
                },
                Rose = {
                    Dark = { Primary = d("e11d48"), PrimaryForeground = d("fff1f2"), Ring = d("e11d48") },
                    Light = { Primary = d("e11d48"), PrimaryForeground = d("fff1f2"), Ring = d("e11d48") },
                },
                Violet = {
                    Dark = {
                        Primary = d("5d0ec0"),
                        PrimaryForeground = d("f5f3ff"),
                        Ring = d("71717b"),
                        SidebarPrimary = d("8e51ff"),
                        SidebarPrimaryForeground = d("f5f3ff"),
                    },
                    Light = {
                        Primary = d("7008e7"),
                        PrimaryForeground = d("f5f3ff"),
                        Ring = d("9f9fa9"),
                        SidebarPrimary = d("7f22fe"),
                        SidebarPrimaryForeground = d("f5f3ff"),
                    },
                },
                Yellow = {
                    Dark = { Primary = d("facc15"), PrimaryForeground = d("422006"), Ring = d("854d0e") },
                    Light = { Primary = d("facc15"), PrimaryForeground = d("422006"), Ring = d("facc15") },
                },
            }
            local f = {}
            e.Token = setmetatable({}, {
                __index = function(g, h)
                    if e.Themes.Dark[h] == nil then
                        error("unknown theme token: " .. tostring(h), 2)
                    end
                    local i = f[h]
                    if not i then
                        i = table.freeze({ __token = h })
                        f[h] = i
                    end
                    return i
                end,
            })
            function e.TokenOf(g)
                return if type(g) == "table" then g.__token else nil
            end
            e.Mode = "Dark"
            e.Accent = "Default"
            e.Overrides = {}
            e.Palette = {}
            e.Defaults = { Mode = "Dark", Accent = "Default" }
            local function g(h)
                local i = 0.2126 * h.R + 0.7152 * h.G + 0.0722 * h.B
                return if i > 0.55 then d("09090b") else d("fafafa")
            end
            function e.Build()
                local h = e.Themes[e.Mode] or e.Themes.Dark
                local i, j = table.clone(h), e.Accent
                if typeof(j) == "Color3" then
                    i.Primary = j
                    i.PrimaryForeground = g(j)
                    i.Ring = j
                    i.SidebarPrimary = j
                    i.SidebarPrimaryForeground = i.PrimaryForeground
                else
                    local k = e.Accents[j]
                    local l = k and k[e.Mode]
                    if k and not l and e.Mode ~= "Dark" then
                        l = k.Light
                    end
                    if l then
                        for m, n in pairs(l) do
                            i[m] = n
                        end
                        if not l.SidebarPrimary and l.Primary then
                            i.SidebarPrimary = l.Primary
                            i.SidebarPrimaryForeground = i.PrimaryForeground
                        end
                    end
                end
                for k, l in pairs(e.Palette[e.Mode] or {}) do
                    i[k] = l
                end
                for k, l in pairs(e.Overrides) do
                    i[k] = l
                end
                return i
            end
            e.Radius = { Sm = 4, Md = 6, Lg = 7, Xl = 10, Xxl = 13, Full = 999 }
            e.TextSize = { Xs = 12, Sub = 13, Sm = 14, Title = 15, Base = 16, Lg = 18 }
            e.Fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            e.Current = e.Themes.Dark
            local h, i, j, k = 120, {}, {}, {}
            function e.Tween(l, m, n)
                local o = c:Create(l, n or e.Fast, m)
                o:Play()
                return o
            end
            function e.Color(l)
                return e.Current[l]
            end
            local function l(m)
                local n = i[m]
                if n then
                    for o, p in pairs(n) do
                        local q = j[p]
                        if q then
                            q[m] = nil
                        end
                    end
                    i[m] = nil
                end
                local o = k[m]
                if o then
                    o:Disconnect()
                    k[m] = nil
                end
            end
            local function m(n, o, p)
                local q = i[n]
                if not q then
                    q = {}
                    i[n] = q
                    k[n] = n.Destroying:Connect(function()
                        l(n)
                    end)
                end
                local r = q[o]
                if r and r ~= p then
                    local s = j[r]
                    local t = s and s[n]
                    if t then
                        t[o] = nil
                        if next(t) == nil then
                            s[n] = nil
                        end
                    end
                end
                q[o] = p
                local s = j[p]
                if not s then
                    s = {}
                    j[p] = s
                end
                local t = s[n]
                if not t then
                    t = {}
                    s[n] = t
                end
                t[o] = true
            end
            function e.Bind(n, o, p)
                m(n, o, p);
                (n)[o] = e.Current[p]
            end
            function e.Rebind(n, o, p)
                m(n, o, p)
                e.Tween(n, { [o] = e.Current[p] })
            end
            function e.Apply(n, o)
                local p, q = e.Current, {}
                e.Current = n
                for r, s in pairs(j) do
                    local t = n[r]
                    if t and t ~= p[r] then
                        for u, v in pairs(s) do
                            local w = q[u]
                            if not w then
                                w = {}
                                q[u] = w
                            end
                            for x in pairs(v) do
                                w[x] = t
                            end
                        end
                    end
                end
                local r = 0
                for s in pairs(q) do
                    r += 1
                end
                local s = not o and r <= h
                for t, u in pairs(q) do
                    if s then
                        e.Tween(t, u)
                    else
                        for v, w in pairs(u) do
                            (t)[v] = w
                        end
                    end
                end
            end
            function e.Prune() end
            function e.Count()
                local n = 0
                for o in pairs(i) do
                    n += 1
                end
                return n
            end
            function e.Reset()
                for n in pairs(k) do
                    l(n)
                end
                table.clear(i)
                table.clear(j)
                e.Mode = "Dark"
                e.Accent = "Default"
                e.Overrides = {}
                e.Palette = {}
                e.Defaults = { Mode = "Dark", Accent = "Default" }
                e.Current = e.Themes.Dark
            end
            return e
        end
        function a.Theme()
            local c = a.cache.b
            if not c then
                c = { c = b() }
                a.cache.b = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f =
                "rbxassetid://12187365364", "rbxasset://fonts/families/RobotoMono.json", "shadcn/fonts", {
                    { name = "Regular", weight = 400, enum = Enum.FontWeight.Regular },
                    { name = "Medium", weight = 500, enum = Enum.FontWeight.Medium },
                    { name = "SemiBold", weight = 600, enum = Enum.FontWeight.SemiBold },
                    { name = "Bold", weight = 700, enum = Enum.FontWeight.Bold },
                }
            local g, h =
                {
                    Regular = Font.new(c, Enum.FontWeight.Regular),
                    Medium = Font.new(c, Enum.FontWeight.Medium),
                    SemiBold = Font.new(c, Enum.FontWeight.SemiBold),
                    Bold = Font.new(c, Enum.FontWeight.Bold),
                    Heading = Font.new(c, Enum.FontWeight.SemiBold),
                    HeadingMedium = Font.new(c, Enum.FontWeight.Medium),
                    Mono = Font.new(d, Enum.FontWeight.Regular),
                    Family = "Inter",
                    Url = [[https://gitlab.com/Andrxssy/library/-/raw/main/roblox/fonts/]],
                }, nil
            local function i()
                for j, k in ipairs(f) do
                    (g)[k.name] = Font.new(c, k.enum)
                end
                g.Family = "Inter"
            end
            local function j()
                local k, l, m, n, o = writefile, readfile, isfile, makefolder, getcustomasset
                if not (k and m and n and o) then
                    return nil
                end
                pcall(n, "shadcn")
                pcall(n, e)
                local p = {}
                for q, r in ipairs(f) do
                    local s = e .. "/Outfit-" .. r.name .. ".ttf"
                    local t = m(s) and l and #l(s) > 1000
                    if not t then
                        local u, v = pcall(function()
                            return game:HttpGet(g.Url .. "Outfit-" .. r.name .. ".ttf")
                        end)
                        if not u or type(v) ~= "string" or string.sub(v, 1, 4) ~= "\0\1\0\0" then
                            return nil
                        end
                        k(s, v)
                    end
                    table.insert(p, { name = r.name, weight = r.weight, style = "normal", assetId = o(s) })
                end
                local q = e .. "/Outfit.json"
                k(q, game:GetService("HttpService"):JSONEncode({ name = "Outfit", faces = p }))
                return o(q)
            end
            function g.Load(k)
                local l = k or "Inter"
                if h == l then
                    return g.Family
                end
                h = l
                if l ~= "Outfit" then
                    i()
                    return g.Family
                end
                local m, n = pcall(j)
                if not m or not n then
                    i()
                    return g.Family
                end
                for o, p in ipairs(f) do
                    (g)[p.name] = Font.new(n, p.enum)
                end
                g.Family = "Outfit"
                return g.Family
            end
            function g.Reset()
                h = nil
                i()
            end
            return g
        end
        function a.Fonts()
            local c = a.cache.c
            if not c then
                c = { c = b() }
                a.cache.c = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c = {}
            c.Url = [[https://gitlab.com/Andrxssy/library/-/raw/main/roblox/shadcn-icons.luau]]
            local d, e, f =
                {
                    add = "plus",
                    subtract = "minus",
                    close = "x",
                    ["close-circle"] = "circle-x",
                    ["checkbox-circle"] = "circle-check",
                    ["check-double"] = "check-check",
                    ["error-warning"] = "alert-circle",
                    alert = "triangle-alert",
                    information = "info",
                    question = "circle-help",
                    loader = "loader-circle",
                    home = "home",
                    dashboard = "layout-dashboard",
                    apps = "layout-grid",
                    ["side-bar"] = "panel-left",
                    menu = "menu",
                    more = "ellipsis",
                    ["more-2"] = "ellipsis-vertical",
                    ["arrow-down-s"] = "chevron-down",
                    ["arrow-up-s"] = "chevron-up",
                    ["arrow-left-s"] = "chevron-left",
                    ["arrow-right-s"] = "chevron-right",
                    ["expand-up-down"] = "chevrons-up-down",
                    user = "user",
                    ["user-settings"] = "user-cog",
                    team = "users",
                    group = "users",
                    settings = "settings",
                    equalizer = "sliders-horizontal",
                    palette = "palette",
                    brush = "brush",
                    eye = "eye",
                    ["eye-off"] = "eye-off",
                    lock = "lock",
                    ["lock-unlock"] = "lock-open",
                    shield = "shield",
                    ["shield-check"] = "shield-check",
                    sword = "sword",
                    crosshair = "crosshair",
                    focus = "focus",
                    ["focus-3"] = "crosshair",
                    mic = "mic",
                    ["mic-off"] = "mic-off",
                    ["volume-up"] = "volume-2",
                    ["volume-mute"] = "volume-x",
                    heart = "heart",
                    ["heart-pulse"] = "heart-pulse",
                    ["first-aid-kit"] = "briefcase-medical",
                    ["map-pin"] = "map-pin",
                    compass = "compass",
                    search = "search",
                    notification = "bell",
                    ["notification-off"] = "bell-off",
                    time = "clock",
                    timer = "timer",
                    calendar = "calendar",
                    file = "file",
                    ["file-list"] = "file-text",
                    folder = "folder",
                    save = "save",
                    download = "download",
                    upload = "upload",
                    refresh = "refresh-cw",
                    restart = "rotate-cw",
                    ["delete-bin"] = "trash-2",
                    edit = "pencil",
                    pencil = "pencil",
                    code = "code",
                    terminal = "terminal",
                    ["terminal-box"] = "square-terminal",
                    bug = "bug",
                    flashlight = "zap",
                    flash = "zap",
                    fire = "flame",
                    star = "star",
                    sun = "sun",
                    moon = "moon",
                    contrast = "sun-moon",
                    ["logout-box"] = "log-out",
                    ["logout-box-r"] = "log-out",
                    ["login-box"] = "log-in",
                    ["shut-down"] = "power",
                    fullscreen = "maximize",
                    ["fullscreen-exit"] = "minimize",
                    link = "link",
                    global = "globe",
                    earth = "earth",
                    gamepad = "gamepad-2",
                    keyboard = "keyboard",
                    mouse = "mouse",
                    cursor = "mouse-pointer",
                    computer = "monitor",
                    smartphone = "smartphone",
                    database = "database",
                    server = "server",
                    cpu = "cpu",
                    ["money-dollar-circle"] = "circle-dollar-sign",
                    coin = "coins",
                    ["shopping-cart"] = "shopping-cart",
                    gift = "gift",
                    trophy = "trophy",
                    ["vip-crown"] = "crown",
                    magic = "wand-sparkles",
                    sparkling = "sparkles",
                    robot = "bot",
                    ghost = "ghost",
                    skull = "skull",
                    walk = "footprints",
                    run = "person-standing",
                    car = "car",
                    plane = "plane",
                    rocket = "rocket",
                    anchor = "anchor",
                    leaf = "leaf",
                    plant = "sprout",
                    drop = "droplet",
                    windy = "wind",
                    ["box-3"] = "box",
                    archive = "archive",
                    inbox = "inbox",
                    mail = "mail",
                    ["chat-3"] = "message-circle",
                    message = "message-square",
                    ["send-plane"] = "send",
                    share = "share-2",
                    filter = "filter",
                    ["list-check"] = "list-checks",
                    ["list-unordered"] = "list",
                    layout = "layout-panel-left",
                    ["drag-move"] = "move",
                    grid = "grid-3x3",
                    image = "image",
                    camera = "camera",
                    video = "video",
                    music = "music",
                    play = "play",
                    pause = "pause",
                    stop = "square",
                }, {
                    ["alert-circle"] = "exclamationmarkCircle",
                    ["circle-alert"] = "exclamationmarkCircle",
                    ["app-window"] = "macwindow",
                    bell = "bell",
                    check = "checkmark",
                    ["chevron-down"] = "chevronDown",
                    ["chevron-up"] = "chevronUp",
                    ["chevron-left"] = "chevronLeft",
                    ["chevron-right"] = "chevronRight",
                    ["chevrons-up-down"] = "chevronUpChevronDown",
                    ["circle-check"] = "checkmarkCircle",
                    ["circle-x"] = "xmarkCircle",
                    component = "cubeTransparent",
                    box = "cube",
                    crosshair = "scope",
                    target = "target",
                    download = "squareAndArrowDown",
                    upload = "squareAndArrowUp",
                    eye = "eye",
                    ["eye-off"] = "eyeSlash",
                    heart = "heart",
                    ["heart-pulse"] = "waveformPathEcg",
                    home = "house",
                    house = "house",
                    info = "infoCircle",
                    keyboard = "keyboard",
                    ["layout-grid"] = "squareGrid2x2",
                    lock = "lock",
                    ["log-out"] = "rectanglePortraitAndArrowRight",
                    ["maximize-2"] = "arrowUpLeftAndArrowDownRight",
                    ["minimize-2"] = "arrowDownRightAndArrowUpLeft",
                    mic = "mic",
                    minus = "minus",
                    plus = "plus",
                    moon = "moon",
                    sun = "sunMax",
                    ["sun-dim"] = "sunMin",
                    ["sun-moon"] = "circleLefthalfStripedHorizontal",
                    ["mouse-pointer-click"] = "cursorarrowClick",
                    ["mouse-pointer"] = "cursorarrow",
                    palette = "paintpalette",
                    brush = "paintbrush",
                    ["panel-left"] = "sidebarLeft",
                    ["panel-left-open"] = "sidebarLeft",
                    play = "play",
                    plug = "powerplug",
                    radio = "dotRadiowavesLeftAndRight",
                    ["refresh-cw"] = "arrowClockwise",
                    ["rotate-cw"] = "arrowClockwise",
                    ["rotate-ccw"] = "arrowCounterclockwise",
                    undo = "arrowCounterclockwise",
                    ellipsis = "ellipsis",
                    ["scan-eye"] = "viewfinder",
                    search = "magnifyingglass",
                    settings = "gearshape",
                    shuffle = "shuffle",
                    ["sliders-horizontal"] = "sliderHorizontal3",
                    tag = "tag",
                    ["text-cursor-input"] = "characterCursorIbeam",
                    ["toggle-right"] = "switch2",
                    ["triangle-alert"] = "exclamationmarkTriangle",
                    trash = "trash",
                    ["trash-2"] = "trash",
                    type = "textformat",
                    x = "xmark",
                    zap = "bolt",
                    send = "paperplane",
                    lightbulb = "lightbulb",
                    rocket = "paperplane",
                    swords = "figureFencing",
                    sword = "figureFencing",
                    ["loader-circle"] = "arrowTriangle2Circlepath",
                    loader = "arrowTriangle2Circlepath",
                    inbox = "tray",
                    ["list-checks"] = "checklist",
                    link = "link",
                    folder = "folder",
                    pencil = "pencil",
                    star = "star",
                    shield = "shield",
                    flame = "flame",
                    globe = "globe",
                    user = "person",
                    users = "person2",
                    copy = "docOnDoc",
                    clipboard = "docOnClipboard",
                    calendar = "calendar",
                    clock = "clock",
                    map = "map",
                    ["map-pin"] = "mappin",
                    car = "car",
                    ["gamepad-2"] = "gamecontroller",
                    ["shopping-cart"] = "cart",
                    gift = "gift",
                    crown = "crown",
                    sparkles = "sparkles",
                    ["wand-sparkles"] = "wandAndStars",
                    wrench = "wrenchAdjustable",
                    hammer = "hammer",
                    skull = "exclamationmarkOctagon",
                    ghost = "eyeSlash",
                    cpu = "cpu",
                    server = "serverRack",
                    database = "cylinder",
                    terminal = "appleTerminal",
                    code = "chevronLeftForwardslashChevronRight",
                    bug = "ant",
                    image = "photo",
                    camera = "camera",
                    video = "video",
                    music = "musicNote",
                    pause = "pause",
                    square = "square",
                    filter = "line3HorizontalDecrease",
                    menu = "line3Horizontal",
                    ["ellipsis-vertical"] = "ellipsis",
                    ["arrow-left"] = "arrowLeft",
                    ["arrow-right"] = "arrowRight",
                    ["arrow-up"] = "arrowUp",
                    ["arrow-down"] = "arrowDown",
                    ["external-link"] = "arrowUpRightSquare",
                    ["log-in"] = "rectanglePortraitAndArrowForward",
                    power = "power",
                    wifi = "wifi",
                    battery = "battery100percent",
                    ["volume-2"] = "speakerWave2",
                    ["volume-x"] = "speakerSlash",
                    ["mic-off"] = "micSlash",
                    ["bell-off"] = "bellSlash",
                    ["lock-open"] = "lockOpen",
                    key = "key",
                    coins = "dollarsignCircle",
                    trophy = "trophy",
                    ["target-arrow"] = "scope",
                    move = "arrowUpAndDownAndArrowLeftAndRight",
                    grip = "line3Horizontal",
                    ["chart-bar"] = "chartBar",
                    ["bar-chart"] = "chartBar",
                    ["line-chart"] = "chartLineUptrendXyaxis",
                    ["pie-chart"] = "chartPie",
                }, { Lucide = nil, SF = nil }
            c.Set = "SF"
            c.SFUrl = [[https://gitlab.com/Andrxssy/library/-/raw/main/roblox/shadcn-sf.luau]]
            local function g(h)
                local i, j = pcall(function()
                    return loadstring(game:HttpGet(h))()
                end)
                if i and type(j) == "table" then
                    return j
                end
                return {}
            end
            function c.Load(h)
                if type(h) == "table" then
                    f.Lucide = h
                    return true
                end
                local i = g(h or c.Url)
                f.Lucide = i
                return next(i) ~= nil
            end
            local function h(i)
                local j = f[i]
                if not j then
                    if i == "SF" then
                        j = g(c.SFUrl)
                    else
                        j = g(c.Url)
                    end
                    f[i] = j
                end
                return j
            end
            local function i(j)
                local k, l = "", true
                for m in string.gmatch(j, "[^%.%-_%s]+") do
                    if l then
                        k = m
                        l = false
                    else
                        k ..= string.upper(string.sub(m, 1, 1)) .. string.sub(m, 2)
                    end
                end
                return k
            end
            local function j(k)
                local l = h("SF")
                local m = l[k] or l[i(k)]
                if m then
                    return m
                end
                local n = e[string.lower(k)]
                if n then
                    return l[n]
                end
                return nil
            end
            local function k(l, m)
                local n = string.gsub(m, "^ri%-", "")
                n = string.gsub(n, "%-line$", "")
                n = string.gsub(n, "%-fill$", "")
                local o = d[n]
                if not o then
                    local p = string.gsub(n, "%-%d+$", "")
                    o = d[p] or p
                end
                return l[o] or l[n]
            end
            local function l(m)
                local n, o = h("Lucide"), string.lower(m)
                local p = n[o]
                if not p then
                    p = k(n, o)
                end
                if p then
                    return "rbxassetid://" .. p
                end
                return nil
            end
            function c.Get(m)
                if m == nil then
                    return nil
                end
                if type(m) == "number" then
                    return "rbxassetid://" .. m
                end
                if type(m) ~= "string" or m == "" then
                    return nil
                end
                if string.find(m, "^%d+$") then
                    return "rbxassetid://" .. m
                end
                if string.find(m, "://", 1, true) then
                    return m
                end
                local n, o = string.match(m, "^(%a+):(.+)$")
                if n then
                    n = string.lower(n)
                    if n == "sf" then
                        return j(o)
                    elseif n == "lucide" then
                        return l(o)
                    end
                end
                if c.Set == "SF" then
                    return j(m) or l(m)
                end
                return l(m) or j(m)
            end
            function c.IsImage(m)
                if type(m) == "number" then
                    return true
                end
                if type(m) ~= "string" then
                    return false
                end
                return string.find(m, "^%d+$") ~= nil or string.find(m, "://", 1, true) ~= nil
            end
            function c.Reset()
                f.Lucide = nil
                f.SF = nil
                c.Set = "SF"
            end
            return c
        end
        function a.Icons()
            local c = a.cache.d
            if not c then
                c = { c = b() }
                a.cache.d = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f, g = game:GetService("Players"), game:GetService("TextService"), a.Theme(), a.Fonts(), {}
            g.Token = e.Token
            local h = nil
            function g.SelectionRing()
                if not h then
                    local i = Instance.new("Frame")
                    i.Name = "SelectionRing"
                    i.BackgroundTransparency = 1
                    i.Size = UDim2.new(1, 6, 1, 6)
                    i.Position = UDim2.fromOffset(-3, -3)
                    local j = Instance.new("UICorner")
                    j.CornerRadius = UDim.new(0, 8)
                    j.Parent = i
                    local k = Instance.new("UIStroke")
                    k.Thickness = 2
                    k.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    k.Parent = i
                    e.Bind(k, "Color", "Ring")
                    h = i
                end
                return h
            end
            function g.Create(i, j, k)
                local l = Instance.new(i)
                if l:IsA("GuiButton") then
                    (l).SelectionImageObject = g.SelectionRing()
                end
                if j then
                    for m, n in pairs(j) do
                        if m ~= "Parent" then
                            local o = e.TokenOf(n)
                            if o then
                                e.Bind(l, m, o)
                            else
                                (l)[m] = n
                            end
                        end
                    end
                end
                if k then
                    for m, n in ipairs(k) do
                        n.Parent = l
                    end
                end
                if j and j.Parent then
                    l.Parent = j.Parent
                end
                return l
            end
            local i = g.Create
            function g.Corner(j)
                return i("UICorner", { CornerRadius = UDim.new(0, j) })
            end
            function g.Stroke(j, k)
                return i("UIStroke", { Color = j, Thickness = k or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border })
            end
            function g.Padding(j, k, l, m)
                return i("UIPadding", {
                    PaddingTop = UDim.new(0, j),
                    PaddingRight = UDim.new(0, k or j),
                    PaddingBottom = UDim.new(0, l or j),
                    PaddingLeft = UDim.new(0, m or k or j),
                })
            end
            function g.List(j, k, l)
                return i("UIListLayout", {
                    Padding = UDim.new(0, j),
                    FillDirection = k or Enum.FillDirection.Vertical,
                    VerticalAlignment = Enum.VerticalAlignment.Top,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Wraps = l or false,
                })
            end
            function g.Text(j)
                local k = {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    FontFace = f.Regular,
                    TextSize = e.TextSize.Sm,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    RichText = true,
                    Size = UDim2.new(1, 0, 0, 0),
                    TextColor3 = e.Token.Foreground,
                }
                for l, m in pairs(j) do
                    k[l] = m
                end
                return i("TextLabel", k)
            end
            local j, k, l = {}, 0, 4000
            function g.TextWidth(m, n, o)
                local p = o.Family .. "|" .. o.Weight.Name .. "|" .. n .. "|" .. m
                local q = j[p]
                if q then
                    return q
                end
                local r, s = pcall(function()
                    local r = Instance.new("GetTextBoundsParams")
                    r.Text = m
                    r.Size = n
                    r.Font = o
                    r.Width = 10000
                    r.RichText = string.find(m, "<", 1, true) ~= nil
                    return d:GetTextBoundsAsync(r)
                end)
                if r then
                    q = s.X
                else
                    q = #m * n * 0.5
                end
                if k >= l then
                    table.clear(j)
                    k = 0
                end
                j[p] = q
                k += 1
                return q
            end
            local m = [[ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/]]
            function g.Base64Encode(n)
                local o = crypt and crypt.base64encode
                if o then
                    local p, q = pcall(o, n)
                    if p and type(q) == "string" then
                        return q
                    end
                end
                local p = string.gsub(n, ".", function(p)
                    local q, r = string.byte(p), ""
                    for s = 8, 1, -1 do
                        if q % 2 ^ s - q % 2 ^ (s - 1) > 0 then
                            r ..= "1"
                        else
                            r ..= "0"
                        end
                    end
                    return r
                end)
                local q = string.gsub(p .. "0000", "%d%d%d?%d?%d?%d?", function(q)
                    if #q < 6 then
                        return ""
                    end
                    local r = 0
                    for s = 1, 6 do
                        if string.sub(q, s, s) == "1" then
                            r += 2 ^ (6 - s)
                        end
                    end
                    return string.sub(m, r + 1, r + 1)
                end)
                return q .. ({ "", "==", "=" })[#n % 3 + 1]
            end
            function g.Base64Decode(n)
                local o = crypt and crypt.base64decode
                if o then
                    local p, q = pcall(o, n)
                    if p and type(q) == "string" then
                        return q
                    end
                end
                local p = string.gsub(n, "[^%w%+/=]", "")
                local q = string.gsub(p, ".", function(q)
                    if q == "=" then
                        return ""
                    end
                    local r, s = (string.find(m, q, 1, true) or 1) - 1, ""
                    for t = 6, 1, -1 do
                        if r % 2 ^ t - r % 2 ^ (t - 1) > 0 then
                            s ..= "1"
                        else
                            s ..= "0"
                        end
                    end
                    return s
                end)
                return (
                    string.gsub(q, "%d%d%d?%d?%d?%d?%d?%d?", function(r)
                        if #r ~= 8 then
                            return ""
                        end
                        local s = 0
                        for t = 1, 8 do
                            if string.sub(r, t, t) == "1" then
                                s += 2 ^ (8 - t)
                            end
                        end
                        return string.char(s)
                    end)
                )
            end
            function g.GuiParent()
                local n, o = pcall(function()
                    return gethui()
                end)
                if n and o then
                    return o
                end
                local p, q = pcall(function()
                    return game:GetService("CoreGui")
                end)
                if p and q then
                    return q
                end
                return c.LocalPlayer:WaitForChild("PlayerGui")
            end
            return g
        end
        function a.Creator()
            local c = a.cache.e
            if not c then
                c = { c = b() }
                a.cache.e = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e = game:GetService("HttpService"), 0.5, {}
            e.__index = e
            local function f(g)
                local h = typeof(g)
                if h == "Color3" then
                    return { __type = "Color3", value = g:ToHex() }
                elseif h == "EnumItem" then
                    return { __type = "EnumItem", enum = tostring(g.EnumType), value = g.Name }
                elseif h == "UDim2" then
                    return { __type = "UDim2", value = { g.X.Scale, g.X.Offset, g.Y.Scale, g.Y.Offset } }
                elseif h == "Vector2" then
                    return { __type = "Vector2", value = { g.X, g.Y } }
                elseif h == "table" then
                    local i = {}
                    for j, k in pairs(g) do
                        i[j] = f(k)
                    end
                    return i
                end
                return g
            end
            local function g(h)
                if type(h) ~= "table" then
                    return h
                end
                local i = h.__type
                if i == "Color3" then
                    return Color3.fromHex(h.value)
                elseif i == "EnumItem" then
                    local j, k = pcall(function()
                        return (Enum)[h.enum][h.value]
                    end)
                    return if j then k else nil
                elseif i == "UDim2" then
                    return UDim2.new(table.unpack(h.value))
                elseif i == "Vector2" then
                    return Vector2.new(table.unpack(h.value))
                end
                local j = {}
                for k, l in pairs(h) do
                    j[k] = g(l)
                end
                return j
            end
            local function h(i)
                return string.split(i, ".")
            end
            local function i()
                return writefile ~= nil and readfile ~= nil and isfile ~= nil and makefolder ~= nil and isfolder ~= nil
            end
            function e.new(j, k)
                local l = j or {}
                local m = setmetatable({
                    Folder = l.Folder or "shadcn",
                    File = l.File or "config",
                    AutoSave = l.AutoSave ~= false,
                    Data = {},
                    _pending = nil,
                }, e)
                k:Give(function()
                    if m._pending and coroutine.status(m._pending) ~= "dead" then
                        task.cancel(m._pending)
                    end
                    m._pending = nil
                end)
                m:Load()
                return m
            end
            function e:Path()
                return string.format("%s/%s.json", self.Folder, self.File)
            end
            function e:Load()
                if not i() then
                    return false
                end
                local j, k = pcall(function()
                    if not isfile(self:Path()) then
                        return nil
                    end
                    return c:JSONDecode(readfile(self:Path()))
                end)
                if j and type(k) == "table" then
                    self.Data = g(k)
                    return true
                end
                return false
            end
            function e:Save()
                if not i() then
                    return false
                end
                local j = pcall(function()
                    local j = ""
                    for k, l in ipairs(string.split(self.Folder, "/")) do
                        j = if j == "" then l else j .. "/" .. l
                        if not isfolder(j) then
                            makefolder(j)
                        end
                    end
                    writefile(self:Path(), c:JSONEncode(f(self.Data)))
                end)
                return j
            end
            function e:Get(j)
                local k = self.Data
                for l, m in ipairs(h(j)) do
                    if type(k) ~= "table" then
                        return nil
                    end
                    k = k[m]
                end
                return k
            end
            function e:Set(j, k)
                local l, m = h(j), self.Data
                for n = 1, #l - 1 do
                    local o = l[n]
                    if type(m[o]) ~= "table" then
                        m[o] = {}
                    end
                    m = m[o]
                end
                m[l[#l]] = k
                if self.AutoSave then
                    self:SaveSoon()
                end
            end
            e.Encode = f
            e.Decode = g
            function e:ProfileFolder()
                return self.Folder .. "/profiles"
            end
            function e.CleanName(j)
                local k = string.gsub(j, "[^%w%s%-_]", "")
                k = string.gsub(k, "^%s+", "")
                k = string.gsub(k, "%s+$", "")
                return string.sub(k, 1, 40)
            end
            local function j(k)
                local l = ""
                for m, n in ipairs(string.split(k, "/")) do
                    if l == "" then
                        l = n
                    else
                        l = l .. "/" .. n
                    end
                    if not isfolder(l) then
                        makefolder(l)
                    end
                end
            end
            function e:ListProfiles()
                local k = {}
                if not i() or listfiles == nil then
                    return k
                end
                pcall(function()
                    if not isfolder(self:ProfileFolder()) then
                        return
                    end
                    for l, m in ipairs(listfiles(self:ProfileFolder())) do
                        local n = string.match(m, "([^/\\]+)%.json$")
                        if n then
                            table.insert(k, n)
                        end
                    end
                end)
                table.sort(k, function(l, m)
                    return string.lower(l) < string.lower(m)
                end)
                return k
            end
            function e:SaveProfile(k)
                local l = e.CleanName(k)
                if l == "" or not i() then
                    return false
                end
                local m = os.time()
                local n, o = m, self:ReadProfile(l)
                if o and type(o.__meta) == "table" and type(o.__meta.Created) == "number" then
                    n = o.__meta.Created
                end
                local p = table.clone(self.Data)
                p.__meta = { Created = n, Updated = m }
                return (
                    pcall(function()
                        j(self:ProfileFolder())
                        writefile(self:ProfileFolder() .. "/" .. l .. ".json", c:JSONEncode(f(p)))
                    end)
                )
            end
            function e:ProfileDates(k)
                local l = self:ReadProfile(k)
                if l and type(l.__meta) == "table" then
                    return l.__meta.Created, l.__meta.Updated
                end
                return nil, nil
            end
            function e:ReadProfile(k)
                if not i() then
                    return nil
                end
                local l, m = pcall(function()
                    local l = self:ProfileFolder() .. "/" .. e.CleanName(k) .. ".json"
                    if not isfile(l) then
                        return nil
                    end
                    return c:JSONDecode(readfile(l))
                end)
                if l and type(m) == "table" then
                    return g(m)
                end
                return nil
            end
            function e:DeleteProfile(k)
                if not i() or delfile == nil then
                    return false
                end
                local l = pcall(function()
                    delfile(self:ProfileFolder() .. "/" .. e.CleanName(k) .. ".json")
                end)
                if l and self:GetAutoload() == e.CleanName(k) then
                    self:SetAutoload(nil)
                end
                return l
            end
            function e:GetAutoload()
                if not i() then
                    return nil
                end
                local k, l = pcall(function()
                    local k = self:ProfileFolder() .. "/autoload.txt"
                    if isfile(k) then
                        return readfile(k)
                    end
                    return nil
                end)
                if k and type(l) == "string" and l ~= "" then
                    return l
                end
                return nil
            end
            function e:SetAutoload(k)
                if not i() then
                    return
                end
                pcall(function()
                    j(self:ProfileFolder())
                    writefile(self:ProfileFolder() .. "/autoload.txt", k or "")
                end)
            end
            function e:SaveSoon()
                if self._pending and coroutine.status(self._pending) ~= "dead" then
                    task.cancel(self._pending)
                end
                self._pending = task.delay(d, function()
                    self._pending = nil
                    self:Save()
                end)
            end
            return e
        end
        function a.f()
            local c = a.cache.f
            if not c then
                c = { c = b() }
                a.cache.f = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c = nil
            local function d(e, ...)
                local f = c
                c = nil
                e(...)
                c = f
            end
            local function e(...)
                d(...)
                while true do
                    d(coroutine.yield())
                end
            end
            local f = {}
            f.__index = f
            function f.new(g, h)
                return setmetatable({ Connected = true, _signal = g, _handler = h, _next = nil }, f)
            end
            function f:Disconnect()
                if not self.Connected then
                    return
                end
                self.Connected = false
                local g = self._signal
                if g._head == self then
                    g._head = self._next
                else
                    local h = g._head
                    while h and h._next ~= self do
                        h = h._next
                    end
                    if h then
                        h._next = self._next
                    end
                end
            end
            local g = {}
            g.__index = g
            function g.new()
                return setmetatable({ _head = nil }, g)
            end
            function g:Connect(h)
                local i = f.new(self, h)
                i._next = self._head
                self._head = i
                return i
            end
            function g:Once(h)
                local i
                i = self:Connect(function(...)
                    i:Disconnect()
                    h(...)
                end)
                return i
            end
            function g:Fire(...)
                local h = self._head
                while h do
                    if h.Connected then
                        if not c then
                            c = coroutine.create(e)
                        end
                        task.spawn(c, h._handler, ...)
                    end
                    h = h._next
                end
            end
            function g:Wait()
                local h, i = coroutine.running(), nil
                i = self:Connect(function(...)
                    i:Disconnect()
                    task.spawn(h, ...)
                end)
                return coroutine.yield()
            end
            function g:DisconnectAll()
                local h = self._head
                while h do
                    h.Connected = false
                    h = h._next
                end
                self._head = nil
            end
            g.Destroy = g.DisconnectAll
            return g
        end
        function a.g()
            local c = a.cache.g
            if not c then
                c = { c = b() }
                a.cache.g = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f = a.Theme(), a.Fonts(), a.Icons(), a.Creator()
            local g, h, i, j, k, l =
                f.Create, c.Token, {
                    Default = { bg = "Primary", rest = 0, hover = 0.1, fg = "PrimaryForeground" },
                    Destructive = { bg = "Destructive", rest = 0, hover = 0.1, fg = "DestructiveForeground" },
                    Outline = { bg = "Background", rest = 0, hover = 0, hoverBg = "Accent", fg = "Foreground", border = true },
                    Secondary = { bg = "Secondary", rest = 0, hover = 0.2, fg = "SecondaryForeground" },
                    Ghost = { bg = "Accent", rest = 1, hover = 0, fg = "Foreground" },
                    Link = { bg = "Background", rest = 1, hover = 1, fg = "Primary", underline = true },
                }, { Default = { height = 36, padX = 16 }, Sm = { height = 32, padX = 12 }, Lg = { height = 40, padX = 24 }, Icon = {
                    height = 36,
                    padX = 0,
                } }, 0.5, {}
            l.Sizes = j
            function l.new(m, n)
                local o, p, q =
                    i[n.Variant or "Default"] or i.Default, j[n.Size or "Default"] or j.Default, n.Size == "Icon"
                local r, s, t, u, v =
                    n.Title or (if q then "" else "Button"),
                    e.Get(n.Icon),
                    e.Get("lock"),
                    c.TextSize.Sm,
                    n.Locked == true
                local function w(x)
                    local y = s ~= nil or (v and t ~= nil)
                    return f.TextWidth(x, u, d.Regular) + p.padX * 2 + (if y then 26 else 0)
                end
                local x, y =
                    g("TextButton", {
                        Name = "Button",
                        AutoButtonColor = false,
                        BorderSizePixel = 0,
                        Text = "",
                        BackgroundColor3 = h[o.bg],
                        BackgroundTransparency = o.rest,
                        Size = if n.FullWidth then UDim2.new(1, 0, 0, p.height) elseif q then UDim2.fromOffset(p.height, p.height) else UDim2.fromOffset(w(r), p.height),
                        LayoutOrder = n.LayoutOrder or 0,
                    }, { f.Corner(c.Radius.Md) }), if o.border then f.Stroke(h.Input) else nil
                if y then
                    y.Parent = x
                end
                local z = g("Frame", {
                    Name = "Content",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(0, p.height),
                    AutomaticSize = Enum.AutomaticSize.X,
                    ZIndex = 2,
                    Parent = x,
                }, {
                    g("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                local A, B, C, D, E, F, G, H, I, J =
                    if s
                        then g("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = s,
                            ImageColor3 = h[o.fg],
                            Size = UDim2.fromOffset(18, 18),
                            LayoutOrder = 1,
                            Parent = z,
                        })
                        else nil, if t
                        then g("ImageLabel", {
                            Name = "Lock",
                            BackgroundTransparency = 1,
                            Image = t,
                            ImageColor3 = h[o.fg],
                            Size = UDim2.fromOffset(18, 18),
                            LayoutOrder = 0,
                            Visible = false,
                            Parent = z,
                        })
                        else nil, f.Text({
                        Text = r,
                        TextColor3 = h[o.fg],
                        FontFace = d.Regular,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.fromOffset(0, p.height),
                        LayoutOrder = 2,
                        Visible = not (q and s ~= nil),
                        Parent = z,
                    }), g("UIScale", {
                        Parent = x,
                    }), g("Frame", {
                        Name = "Press",
                        BackgroundColor3 = h[o.fg],
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 1,
                        Parent = x,
                    }, { f.Corner(c.Radius.Md) }), TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), false, false
                local function K()
                    return if v then 1 - (1 - o.rest) * k else o.rest
                end
                local function L()
                    local M = J and not v
                    if o.hoverBg then
                        c.Rebind(x, "BackgroundColor3", if M then o.hoverBg else o.bg)
                    end
                    c.Tween(x, {
                        BackgroundTransparency = if M then o.hover else K(),
                    })
                    if o.underline then
                        C.Text = if M then "<u>" .. r .. "</u>" else r
                    end
                end
                local function M()
                    if v then
                        return
                    end
                    I = true
                    c.Tween(E, { BackgroundTransparency = 0.88 }, F)
                    c.Tween(D, { Scale = 0.98 }, F)
                end
                local function N()
                    if not I then
                        return
                    end
                    I = false
                    c.Tween(E, {
                        BackgroundTransparency = 1,
                    }, G)
                    c.Tween(D, { Scale = 1 }, H)
                end
                m:Connect(x.MouseEnter, function()
                    J = true
                    L()
                end)
                m:Connect(x.MouseLeave, function()
                    J = false
                    L()
                    N()
                end)
                m:Connect(x.MouseButton1Down, M)
                m:Connect(x.MouseButton1Up, N)
                if n.Callback then
                    m:Connect(x.MouseButton1Click, function()
                        if not v then
                            task.spawn(n.Callback)
                        end
                    end)
                end
                local O
                local function P()
                    local Q = if v then k else 0
                    c.Tween(C, {
                        TextTransparency = Q,
                    })
                    if A then
                        A.Visible = not (v and B ~= nil)
                        c.Tween(A, {
                            ImageTransparency = Q,
                        })
                    end
                    if B then
                        B.Visible = v
                        B.ImageTransparency = Q
                    end
                    if y then
                        c.Tween(y, { Transparency = Q })
                    end
                    x.AutoButtonColor = false
                    N()
                    L()
                    if not n.FullWidth and not q then
                        x.Size = UDim2.fromOffset(w(r), p.height)
                    end
                    O.Locked = v
                end
                O = {
                    Instance = x,
                    Locked = v,
                    SetTitle = function(Q)
                        r = Q
                        C.Text = Q
                        if not n.FullWidth and not q then
                            x.Size = UDim2.fromOffset(w(Q), p.height)
                        end
                    end,
                    SetLocked = function(Q)
                        v = Q == true
                        P()
                    end,
                }
                if v then
                    P()
                end
                return x, O
            end
            return l
        end
        function a.h()
            local c = a.cache.h
            if not c then
                c = { c = b() }
                a.cache.h = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f = a.Theme(), a.Fonts(), a.Icons(), a.Creator()
            local g, h = f.Create, {}
            h.Colors = {
                Blue = Color3.fromHex("0a84ff"),
                Purple = Color3.fromHex("bf5af2"),
                Orange = Color3.fromHex("ff9f0a"),
                Green = Color3.fromHex("30d158"),
                Pink = Color3.fromHex("ff375f"),
                Indigo = Color3.fromHex("5e5ce6"),
                Teal = Color3.fromHex("40c8e0"),
                Red = Color3.fromHex("ff453a"),
                Brown = Color3.fromHex("ac8e68"),
                Gray = Color3.fromHex("8e8e93"),
            }
            h.Cycle = { "Blue", "Purple", "Orange", "Green", "Pink", "Indigo", "Teal", "Red", "Brown", "Gray" }
            function h.Color(i, j)
                if typeof(i) == "Color3" then
                    return i
                end
                if type(i) == "string" and h.Colors[i] then
                    return h.Colors[i]
                end
                return h.Colors[h.Cycle[(j - 1) % #h.Cycle + 1]]
            end
            function h.new(i, j, k, l, m, n)
                local o = g("Frame", {
                    Name = "Tile",
                    BackgroundColor3 = l,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.fromOffset(m, m),
                    ZIndex = 5,
                    Parent = i,
                }, {
                    f.Corner(math.floor(m * 0.27 + 0.5)),
                    g(
                        "UIGradient",
                        { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.82, 0.82, 0.82)) }
                    ),
                })
                g("UIStroke", {
                    Color = l:Lerp(Color3.new(0, 0, 0), 0.25),
                    Thickness = 1,
                    Transparency = 0.5,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Parent = o,
                })
                local p, q, r = Color3.new(1, 1, 1), e.Get(j), nil
                if q then
                    r = g("ImageLabel", {
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Image = q,
                        ImageColor3 = p,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(n, n),
                        ZIndex = 6,
                        Parent = o,
                    })
                else
                    r = f.Text({
                        Name = "Icon",
                        Text = string.upper(string.sub(k, 1, 1)),
                        TextColor3 = p,
                        FontFace = d.Bold,
                        TextSize = math.floor(n * 0.7 + 0.5),
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 6,
                        Parent = o,
                    })
                end
                return o, r
            end
            return h
        end
        function a.i()
            local c = a.cache.i
            if not c then
                c = { c = b() }
                a.cache.i = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f, g = a.Theme(), a.Fonts(), a.Icons(), a.Creator(), a.i()
            local h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z =
                f.Create,
                c.Token,
                38,
                42,
                10,
                38,
                13,
                26,
                Color3.new(0, 0, 0),
                Color3.fromHex("f5f5f7"),
                Color3.fromHex("98989d"),
                Color3.fromHex("2c2c2e"),
                2.6,
                {
                    Success = { icon = "checkmarkCircle", color = Color3.fromHex("30d158") },
                    Info = { icon = "infoCircle", color = Color3.fromHex("0a84ff") },
                    Warning = { icon = "exclamationmarkTriangle", color = Color3.fromHex("ffd60a") },
                    Error = { icon = "xmarkCircle", color = Color3.fromHex("ff453a") },
                    Loading = { icon = "arrowTriangle2Circlepath", color = Color3.fromHex("98989d") },
                },
                TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {}
            z.__index = z
            function z.new(A, B, C)
                local D, E =
                    setmetatable(
                        { _shown = false, _hovered = false, _options = C, _generation = 0, _announcing = nil },
                        z
                    ),
                    h("TextButton", {
                        Name = "Island",
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = p,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0),
                        Position = UDim2.new(0.5, 0, 0, l),
                        Size = UDim2.fromOffset(m, j),
                        ClipsDescendants = true,
                        Visible = false,
                        ZIndex = 50,
                        Parent = B,
                    }, { f.Corner(c.Radius.Full) })
                h(
                    "UIStroke",
                    {
                        Color = Color3.new(1, 1, 1),
                        Thickness = 1,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Parent = E,
                    },
                    { h("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(0.75, 0.95) }) }
                )
                D._scale = h("UIScale", { Parent = E })
                D.Instance = E
                local F = h(
                    "Frame",
                    {
                        Name = "Content",
                        BackgroundTransparency = 1,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 51,
                        Parent = E,
                    },
                    {
                        h("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    }
                )
                D._padding = f.Padding(0, 14, 0, 6)
                D._padding.Parent = F
                local G = h("Frame", {
                    Name = "Logo",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(o, o),
                    LayoutOrder = 1,
                    ZIndex = 52,
                    Parent = F,
                })
                D._hasLogo = e.Get(C.Icon) ~= nil
                G.Visible = D._hasLogo
                if D._hasLogo and e.IsImage(C.Icon) then
                    h("ImageLabel", {
                        Name = "Picture",
                        BackgroundTransparency = 1,
                        Image = e.Get(C.Icon) or "",
                        ScaleType = Enum.ScaleType.Crop,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 52,
                        Parent = G,
                    }, { f.Corner(999) })
                elseif D._hasLogo then
                    local H = g.new(G, C.Icon, C.Title or "", c.Current.SidebarPrimary, o, 16)
                    H.ZIndex = 52
                    H:FindFirstChildOfClass("UICorner").CornerRadius = UDim.new(1, 0)
                    c.Bind(H, "BackgroundColor3", "SidebarPrimary")
                end
                D._kind = h("ImageLabel", {
                    Name = "Kind",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(o - 4, o - 4),
                    LayoutOrder = 1,
                    Visible = false,
                    ZIndex = 52,
                    Parent = F,
                })
                local H = C.Title or ""
                D._titleText = H
                D._title = f.Text({
                    Name = "Title",
                    Text = H,
                    TextColor3 = q,
                    FontFace = d.SemiBold,
                    TextSize = n,
                    TextTransparency = 1,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.fromOffset(0, j),
                    LayoutOrder = 2,
                    ZIndex = 52,
                    Parent = F,
                })
                local I = h("Frame", {
                    Name = "Hint",
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Size = UDim2.fromOffset(0, j),
                    LayoutOrder = 3,
                    ZIndex = 52,
                    Parent = F,
                }, {
                    h("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                D._hintOpen = f.Text({
                    Name = "Open",
                    Text = "Open",
                    TextColor3 = r,
                    TextSize = 12,
                    TextTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, j),
                    LayoutOrder = 1,
                    ZIndex = 52,
                    Parent = I,
                })
                D._keycap = f.Text({
                    Name = "Key",
                    Text = "",
                    TextColor3 = q,
                    FontFace = d.Medium,
                    TextSize = 11,
                    TextTransparency = 1,
                    BackgroundColor3 = s,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 20),
                    LayoutOrder = 2,
                    ZIndex = 52,
                    Parent = I,
                })
                h("UICorner", { CornerRadius = UDim.new(0, 5), Parent = D._keycap })
                f.Padding(0, 7, 0, 7).Parent = D._keycap
                local J = h("Frame", {
                    Name = "Dot",
                    BackgroundColor3 = i.SidebarPrimary,
                    BorderSizePixel = 0,
                    Size = UDim2.fromOffset(8, 8),
                    LayoutOrder = 4,
                    ZIndex = 52,
                    Parent = F,
                }, { f.Corner(4) })
                D._breath = A:Give(
                    game:GetService("TweenService"):Create(
                        J,
                        TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                        { BackgroundTransparency = 0.7 }
                    )
                )
                D._hint = I
                D._dot = J
                D._logo = G
                A:Connect(E.MouseEnter, function()
                    D._hovered = true
                    D:_fit()
                end)
                A:Connect(E.MouseLeave, function()
                    D._hovered = false
                    D:_fit()
                    c.Tween(D._scale, { Scale = 1 }, v)
                end)
                A:Connect(E.MouseButton1Down, function()
                    c.Tween(D._scale, { Scale = 0.94 }, y)
                end)
                A:Connect(E.MouseButton1Up, function()
                    c.Tween(D._scale, { Scale = 1 }, v)
                end)
                A:Connect(E.MouseButton1Click, function()
                    if D._shown then
                        C.Open()
                    end
                end)
                return D
            end
            function z:_fit()
                if not self._shown then
                    return
                end
                local A, B = self._titleText, self._announcing ~= nil
                if B then
                    A = self._announcing
                end
                local C, D, E = math.min(math.ceil(f.TextWidth(A, n, d.SemiBold)), 320), 0, j
                if self._hovered and not B then
                    local F = self._options.Hint()
                    self._keycap.Text = F
                    D = math.ceil(f.TextWidth("Open", 12, d.Regular)) + 6 + math.ceil(f.TextWidth(F, 11, d.Medium)) + 14
                    E = k
                end
                local F = 0
                if D > 0 then
                    F = 8
                end
                local G, H = 0, 14
                if self._logo.Visible or self._kind.Visible then
                    G = o + 8
                    H = 6
                end
                self._padding.PaddingLeft = UDim.new(0, H)
                local I = H + G + C + 8 + D + F + 8 + 14
                I = math.ceil(I / 2) * 2
                local J = 1
                if D > 0 then
                    J = 0
                end
                self._title.Text = A
                c.Tween(self.Instance, { Size = UDim2.fromOffset(I, E) }, v)
                c.Tween(self._title, { Size = UDim2.fromOffset(C, j) }, v)
                c.Tween(self._hint, { Size = UDim2.fromOffset(D, j) }, x)
                c.Tween(self._hintOpen, { TextTransparency = J }, x)
                c.Tween(self._keycap, {
                    TextTransparency = J,
                    BackgroundTransparency = J,
                }, x)
            end
            function z:Announce(A, B)
                if not self._shown or A == "" then
                    return
                end
                local C = u[B or ""]
                self._announcing = A
                self._generation += 1
                local D = self._generation
                self._kind.Visible = C ~= nil
                self._logo.Visible = C == nil and self._hasLogo
                if C then
                    self._kind.Image = e.Get(C.icon) or ""
                    self._kind.ImageColor3 = C.color
                end
                self._title.TextTransparency = 1
                self:_fit()
                c.Tween(self._title, { TextTransparency = 0 }, x)
                task.delay(t, function()
                    if self._generation ~= D or not self._shown then
                        return
                    end
                    self._announcing = nil
                    self._kind.Visible = false
                    self._logo.Visible = self._hasLogo
                    self._title.TextTransparency = 1
                    self:_fit()
                    c.Tween(self._title, { TextTransparency = 0 }, x)
                end)
            end
            function z:SetShown(A)
                if self._shown == A then
                    return
                end
                self._shown = A
                self._generation += 1
                self._announcing = nil
                self._kind.Visible = false
                self._logo.Visible = self._hasLogo
                local B, C = self._generation, self.Instance
                if A then
                    local D = C.Parent
                    C.Position = UDim2.new(0.5, -(D.AbsoluteSize.X % 2) / 2, 0, l)
                    self._hovered = false
                    self._scale.Scale = 1
                    C.Size = UDim2.fromOffset(m, j)
                    C.Visible = true
                    self._breath:Play()
                    self._title.TextTransparency = 1
                    self:_fit()
                    c.Tween(self._title, {
                        TextTransparency = 0,
                    }, TweenInfo.new(
                        0.3,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0.12
                    ))
                else
                    c.Tween(self._title, { TextTransparency = 1 }, w)
                    c.Tween(self._hintOpen, { TextTransparency = 1 }, w)
                    c.Tween(self._keycap, { TextTransparency = 1, BackgroundTransparency = 1 }, w)
                    c.Tween(C, { Size = UDim2.fromOffset(m, j) }, w)
                    task.delay(w.Time, function()
                        if self._generation == B then
                            C.Visible = false
                            self._breath:Pause()
                        end
                    end)
                end
            end
            return z
        end
        function a.j()
            local c = a.cache.j
            if not c then
                c = { c = b() }
                a.cache.j = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f, g, h =
                game:GetService("UserInputService"), a.Theme(), a.Fonts(), a.Icons(), a.Creator(), a.h()
            local i, j, k, l, m, n, o =
                g.Create,
                d.Token,
                384,
                16,
                TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {}
            function o.open(p, q)
                if p._dialog then
                    p._dialog.Close()
                end
                local r, s, t, u = p._maid:Sub(), p._holder, false, q.Buttons
                if not u then
                    local v = "Default"
                    if q.Destructive then
                        v = "Destructive"
                    end
                    u = {
                        { Title = q.CancelText or "Cancel", Variant = "Outline", Cancel = true },
                        { Title = q.ConfirmText or "Continue", Variant = v },
                    }
                end
                local v = r:Give(i("TextButton", {
                    Name = "Dialog",
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 40,
                    Parent = s,
                }, { g.Corner(d.Radius.Xl) }))
                local w, x =
                    i("Frame", {
                        Name = "Card",
                        BackgroundColor3 = j.Popover,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.new(1, -32, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ClipsDescendants = true,
                        ZIndex = 41,
                        Parent = v,
                    }, { g.Corner(d.Radius.Xl), g.List(0), i("UISizeConstraint", { MaxSize = Vector2.new(k, math.huge) }) }), g.Stroke(j.Foreground)
                x.Transparency = 0.9
                x.Parent = w
                local y, z, A =
                    i("UIScale", { Scale = 0.95, Parent = w }), i("Frame", {
                        Name = "Header",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 1,
                        ZIndex = 41,
                        Parent = w,
                    }, {
                        g.Padding(l, l, l, l),
                        i("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Top,
                            Padding = UDim.new(0, 14),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    }), f.Get(q.Icon)
                if A then
                    local B, C =
                        i("Frame", {
                            Name = "Media",
                            BackgroundColor3 = j.Muted,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(40, 40),
                            LayoutOrder = 1,
                            ZIndex = 41,
                            Parent = z,
                        }, { g.Corner(d.Radius.Md) }), j.Foreground
                    if q.Destructive then
                        C = j.Destructive
                    end
                    i("ImageLabel", {
                        BackgroundTransparency = 1,
                        Image = A,
                        ImageColor3 = C,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(24, 24),
                        ZIndex = 42,
                        Parent = B,
                    })
                end
                local B = i(
                    "Frame",
                    {
                        Name = "Text",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        ZIndex = 41,
                        Parent = z,
                    },
                    { g.List(6), i("UIFlexItem", {
                        FlexMode = Enum.UIFlexMode.Fill,
                    }) }
                )
                g.Text({
                    Name = "Title",
                    Text = q.Title or "Are you sure?",
                    FontFace = e.SemiBold,
                    TextSize = d.TextSize.Base,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 1,
                    ZIndex = 42,
                    Parent = B,
                })
                if q.Description then
                    g.Text({
                        Name = "Description",
                        Text = q.Description,
                        TextColor3 = j.MutedForeground,
                        TextWrapped = true,
                        LineHeight = 1.15,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        ZIndex = 42,
                        Parent = B,
                    })
                end
                local C = i("Frame", {
                    Name = "Footer",
                    BackgroundColor3 = j.Muted,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 41,
                    Parent = w,
                }, {
                    g.Padding(12, l, 12, l),
                    i("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                i("Frame", {
                    Name = "Border",
                    BackgroundColor3 = j.Foreground,
                    BackgroundTransparency = 0.9,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(-l, -12),
                    Size = UDim2.new(1, l * 2, 0, 1),
                    ZIndex = 42,
                    Parent = i("Folder", { Parent = C }),
                })
                local D, E = {}, 1
                for F, G in ipairs(u) do
                    if G.Cancel then
                        E = F
                    end
                end
                local function F(G)
                    if t then
                        return
                    end
                    t = true
                    if p._dialog == D then
                        p._dialog = nil
                    end
                    d.Tween(v, { BackgroundTransparency = 1 }, n)
                    d.Tween(y, { Scale = 0.95 }, n)
                    task.delay(n.Time, function()
                        r:Destroy()
                    end)
                    local H = u[G]
                    if H and H.Callback then
                        task.spawn(H.Callback)
                    end
                    if q.OnClose then
                        task.spawn(q.OnClose, G)
                    end
                end
                for G, H in ipairs(u) do
                    local I = h.new(r, {
                        Title = H.Title or "OK",
                        Variant = H.Variant or "Default",
                        Icon = H.Icon,
                        Size = "Sm",
                        LayoutOrder = G,
                        Callback = function()
                            F(G)
                        end,
                    })
                    I.ZIndex = 42
                    I.Parent = C
                end
                r:Connect(c.InputBegan, function(G)
                    if G.KeyCode == Enum.KeyCode.Escape or G.KeyCode == Enum.KeyCode.ButtonB then
                        F(E)
                    end
                end)
                function D.Close()
                    F(0)
                end
                r:Give(function()
                    if not t then
                        t = true
                        if q.OnClose then
                            task.spawn(q.OnClose, 0)
                        end
                    end
                end)
                p._dialog = D
                p:_closePopover()
                d.Tween(v, { BackgroundTransparency = 0.65 }, m)
                d.Tween(y, { Scale = 1 }, m)
                return D
            end
            return o
        end
        function a.k()
            local c = a.cache.k
            if not c then
                c = { c = b() }
                a.cache.k = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f, g =
                game:GetService("Workspace"),
                game:GetService("Lighting"),
                game:GetService("UserInputService"),
                {},
                0.001
            local function h(i, j)
                local k = (c.CurrentCamera):ViewportPointToRay(i.X, i.Y)
                return k.Origin + k.Direction * j
            end
            function f.Supported()
                return not (e.TouchEnabled and not e.MouseEnabled)
            end
            function f.new(i, j, k)
                if not f.Supported() or not c.CurrentCamera then
                    return nil
                end
                local l = i:Give(Instance.new("Folder"))
                l.Name = "shadcn-acrylic"
                local m = Instance.new("Part")
                m.Name = "Glass"
                m.Color = Color3.new(0, 0, 0)
                m.Material = Enum.Material.Glass
                m.Size = Vector3.new(1, 1, 0)
                m.Anchored = true
                m.CanTouch = false
                m.CanCollide = false
                m.CanQuery = false
                m.Locked = true
                m.CastShadow = false
                m.Transparency = 0.98
                local n = Instance.new("SpecialMesh")
                n.MeshType = Enum.MeshType.Brick
                n.Offset = Vector3.new(0, 0, -1E-6)
                n.Parent = m
                local o = i:Give(Instance.new("DepthOfFieldEffect"))
                o.Name = "shadcn-acrylic"
                o.FarIntensity = 0
                o.NearIntensity = 1
                o.InFocusRadius = 0.1
                o.Parent = d
                m.Parent = l
                l.Parent = c.CurrentCamera
                local p, q =
                    {
                        topLeft = Vector2.zero,
                        topRight = Vector2.zero,
                        bottomRight = Vector2.zero,
                    }, true
                local function r()
                    local s = c.CurrentCamera
                    if not s or not q then
                        return
                    end
                    local t, u, v = h(p.topLeft, g), h(p.topRight, g), h(p.bottomRight, g)
                    m.CFrame = CFrame.fromMatrix((t + v) / 2, s.CFrame.XVector, s.CFrame.YVector, s.CFrame.ZVector)
                    n.Scale = Vector3.new((u - t).Magnitude, (u - v).Magnitude, 0)
                end
                local function s()
                    local t = c.CurrentCamera
                    if not t then
                        return
                    end
                    local u, v = j:FindFirstChildOfClass("UICorner"), 0
                    if u then
                        v = u.CornerRadius.Offset * (j.AbsoluteSize.X / math.max(j.Size.X.Offset, 1))
                    end
                    local w = math.max(2, math.ceil(v * 0.3) + 1)
                    local x, y = w, w
                    if k and k.Right then
                        y = 0
                    end
                    local z, A = game:GetService("GuiService"):GetGuiInset(), j.AbsoluteSize - Vector2.new(x + y, w * 2)
                    local B = j.AbsolutePosition + z + Vector2.new(x, w)
                    p.topLeft = B
                    p.topRight = B + Vector2.new(A.X, 0)
                    p.bottomRight = B + A
                    r()
                end
                i:Connect(j:GetPropertyChangedSignal("AbsolutePosition"), s)
                i:Connect(j:GetPropertyChangedSignal("AbsoluteSize"), s)
                local t = c.CurrentCamera
                i:Connect(t:GetPropertyChangedSignal("CFrame"), r)
                i:Connect(t:GetPropertyChangedSignal("ViewportSize"), s)
                i:Connect(t:GetPropertyChangedSignal("FieldOfView"), r)
                s()
                local u = {}
                function u.SetVisible(v)
                    q = v
                    if v then
                        m.Transparency = 0.98
                        o.Enabled = true
                        s()
                    else
                        m.Transparency = 1
                        o.Enabled = false
                    end
                end
                function u.Destroy()
                    l:Destroy()
                    o:Destroy()
                end
                return u
            end
            return f
        end
        function a.l()
            local c = a.cache.l
            if not c then
                c = { c = b() }
                a.cache.l = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e = a.Theme(), a.Fonts(), a.Creator()
            local f, g, h, i, j, k =
                e.Create, c.Token, {
                    Default = { bg = "Primary", fg = "PrimaryForeground" },
                    Secondary = { bg = "Secondary", fg = "SecondaryForeground" },
                    Destructive = { bg = "Destructive", fg = "DestructiveForeground" },
                    Outline = { bg = "Background", fg = "Foreground", border = true, clear = true },
                }, 22, 8, {}
            function k.new(l)
                local m, n = h[l.Variant or "Default"] or h.Default, l.Text or "Badge"
                local function o(p)
                    return e.TextWidth(p, c.TextSize.Xs, d.Medium) + j * 2
                end
                local p = f("Frame", {
                    Name = "Badge",
                    BackgroundColor3 = g[m.bg],
                    BackgroundTransparency = if m.clear then 1 else 0,
                    BorderSizePixel = 0,
                    Size = UDim2.fromOffset(o(n), i),
                    LayoutOrder = l.LayoutOrder or 0,
                }, { e.Corner(c.Radius.Md), if m.border then e.Stroke(g.Border) else nil })
                local q = e.Text({
                    Text = n,
                    TextColor3 = g[m.fg],
                    FontFace = d.Medium,
                    TextSize = c.TextSize.Xs,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Size = UDim2.fromScale(1, 1),
                    Parent = p,
                })
                local function r(s)
                    q.Text = s
                    p.Size = UDim2.fromOffset(o(s), i)
                end
                local s = p:FindFirstChildOfClass("UIStroke") or e.Stroke(g.Border)
                s.Parent = p
                s.Enabled = m.border == true
                local function t(u)
                    local v = h[u] or h.Default
                    c.Rebind(p, "BackgroundColor3", v.bg)
                    c.Rebind(q, "TextColor3", v.fg)
                    if v.clear then
                        p.BackgroundTransparency = 1
                    else
                        p.BackgroundTransparency = 0
                    end
                    s.Enabled = v.border == true
                end
                return p, r, t
            end
            return k
        end
        function a.m()
            local c = a.cache.m
            if not c then
                c = { c = b() }
                a.cache.m = c
            end
            return c.c
        end
    end
    do
        local function b()
            local c, d, e, f, g = game:GetService("UserInputService"), a.Theme(), a.Fonts(), a.Icons(), a.Creator()
            local h, i, j, k, l, m, n, o, p =
                g.Create,
                d.Token,
                32,
                28,
                28,
                252,
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {},
                {}
            local function q(r)
                local s = p[r]
                if not s then
                    s = math.ceil(g.TextWidth(r, d.TextSize.Xs, e.Medium))
                    p[r] = s
                end
                return s
            end
            local function r(s)
                if type(s) == "table" then
                    return tostring(s.Text or s.Value or s.Title or ""), s.Icon
                end
                return tostring(s), nil
            end
            local function s(t)
                local u, v, w = {}, {}, {}
                local function x(y)
                    local z, A = r(y)
                    table.insert(u, z)
                    table.insert(v, {
                        choice = z,
                    })
                    if A then
                        w[z] = A
                    end
                end
                for y, z in ipairs(t) do
                    if type(z) == "table" and z.Options then
                        table.insert(v, { label = z.Title or "" })
                        for A, B in ipairs(z.Options) do
                            x(B)
                        end
                    else
                        x(z)
                    end
                end
                return u, v, w
            end
            local t = 20
            local function u(v, w, x)
                local y = h("ImageLabel", {
                    Name = "OptionIcon",
                    BackgroundTransparency = 1,
                    ScaleType = Enum.ScaleType.Fit,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.fromOffset(t, t),
                    ZIndex = x,
                    Parent = v,
                })
                local function z(A)
                    local B, C =
                        type(A) == "number" or (type(A) == "string" and string.find(A, "://", 1, true) ~= nil),
                        f.Get(A) or ""
                    y.Image = C
                    if B then
                        y.ImageColor3 = Color3.new(1, 1, 1)
                        if C ~= "" then
                            task.spawn(function()
                                for D = 1, 3 do
                                    task.wait(2)
                                    if y.Parent == nil or y.Image ~= C or y.IsLoaded then
                                        return
                                    end
                                    y.Image = ""
                                    task.wait()
                                    y.Image = C
                                end
                            end)
                        end
                    else
                        d.Bind(y, "ImageColor3", "Foreground")
                    end
                end
                if w ~= nil then
                    z(w)
                end
                return y, z
            end
            function o.new(v, w, x, y, z, A)
                local B, C = y.Multi == true, nil
                if B and type(y.Max) == "number" and y.Max > 0 then
                    C = math.floor(y.Max)
                end
                local D = nil
                if y.Smart == true then
                    D = "Smart"
                elseif type(y.Smart) == "string" and y.Smart ~= "" then
                    D = y.Smart
                end
                local function E(F)
                    if not D then
                        return F
                    end
                    local G = { { Text = D, Icon = "sparkles" } }
                    for H, I in ipairs(F) do
                        table.insert(G, I)
                    end
                    return G
                end
                local F, G, H = s(E(y.Options or {}))
                local I, J, K, L =
                    y.Placeholder or "Select", y.Search ~= false, h("TextButton", {
                        Name = "Trigger",
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = i.Input,
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, j),
                        ClipsDescendants = true,
                        Parent = x,
                    }, { g.Corner(d.Radius.Lg) }), g.Stroke(i.Input)
                L.Parent = K
                local M = h(
                    "Frame",
                    { Name = "Body", BackgroundTransparency = 1, Size = UDim2.new(1, -44, 1, 0), Parent = K },
                    { g.Padding(0, 0, 0, 10) }
                )
                local N, O, P =
                    g.Text({
                        Name = "Display",
                        Text = I,
                        TextColor3 = i.MutedForeground,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.fromScale(1, 1),
                        Parent = M,
                    }), u(M, nil, 2)
                O.Visible = false
                local Q = g.Text({
                    Name = "Count",
                    Text = "",
                    BackgroundColor3 = i.Muted,
                    BackgroundTransparency = 0,
                    FontFace = e.Medium,
                    TextSize = d.TextSize.Xs,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 20),
                    Visible = false,
                    ZIndex = 2,
                    Parent = M,
                })
                h("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Q })
                h("UISizeConstraint", { MinSize = Vector2.new(20, 20), Parent = Q })
                g.Padding(0, 7, 0, 7).Parent = Q
                local R, S =
                    h("ImageButton", {
                        Name = "Clear",
                        BackgroundTransparency = 1,
                        Image = f.Get("x") or "",
                        ImageColor3 = i.MutedForeground,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -28, 0.5, 0),
                        Size = UDim2.fromOffset(14, 14),
                        Visible = false,
                        ZIndex = 2,
                        Parent = K,
                    }), h("ImageLabel", {
                        Name = "Chevron",
                        BackgroundTransparency = 1,
                        Image = f.Get("chevron-down") or "",
                        ImageColor3 = i.MutedForeground,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -8, 0.5, 0),
                        Size = UDim2.fromOffset(18, 18),
                        Parent = K,
                    })
                local function T()
                    return v._popover ~= nil and v._popover.anchor == K
                end
                local function U(V)
                    if B then
                        return table.find(z.Value or {}, V) ~= nil
                    end
                    return z.Value == V
                end
                local V, W, X, Y, Z, _, aa, ab, ac, ad = nil, nil, nil, nil, nil, {}, {}, {}, 0, true
                local function ae()
                    for af, ag in ipairs(ab) do
                        local ah = 1
                        if af == ac then
                            ah = 0.9
                        end
                        d.Tween(ag.button, {
                            BackgroundTransparency = ah,
                        }, n)
                    end
                end
                local af, ag = nil, nil
                local function ah()
                    if B then
                        return #(z.Value or {})
                    end
                    return 0
                end
                local function ai()
                    return C ~= nil and ah() >= C
                end
                local function aj()
                    return B and D ~= nil and U(D)
                end
                local function ak()
                    local al = ai() or aj()
                    for am, an in ipairs(_) do
                        local ao, ap = U(an.choice), 0
                        if al and not ao then
                            ap = 0.5
                        end
                        an.check.Visible = ao
                        an.label.TextTransparency = ap
                    end
                    if ag then
                        local am = #ab > 0
                        for an, ao in ipairs(ab) do
                            if not U(ao.choice) then
                                am = false
                            end
                        end
                        if am or al then
                            ag.Text = "Clear selection"
                        else
                            ag.Text = "Select all"
                        end
                    end
                end
                local function al()
                    local am = ""
                    if W then
                        am = string.lower(W.Text)
                    end
                    table.clear(ab)
                    local an = 0
                    for ao, ap in ipairs(_) do
                        local aq = am == "" or string.find(string.lower(ap.choice), am, 1, true) ~= nil
                        ap.button.Visible = aq
                        if aq then
                            table.insert(ab, ap)
                            an += k
                        end
                    end
                    for ao, ap in ipairs(aa) do
                        local aq = false
                        for ar, as in ipairs(ap.members) do
                            for at, au in ipairs(ab) do
                                if au.choice == as then
                                    aq = true
                                end
                            end
                        end
                        ap.frame.Visible = aq
                        if aq then
                            an += l
                        end
                    end
                    if ac > #ab then
                        ac = #ab
                    end
                    if X then
                        X.Size = UDim2.new(1, 0, 0, math.min(an, m))
                        X.Visible = #ab > 0
                    end
                    if Y then
                        Y.Visible = #ab == 0
                    end
                    if af then
                        af.Visible = #ab > 0
                    end
                    ae()
                    ak()
                end
                local am
                local function an()
                    if V then
                        V:Destroy()
                    end
                    table.clear(_)
                    table.clear(aa)
                    V = w:Give(h("Frame", {
                        Name = "Combobox",
                        BackgroundColor3 = i.Popover,
                        BackgroundTransparency = 0.04,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(160, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 20,
                    }, { g.Corner(d.Radius.Lg), g.Padding(4), g.List(4) }))
                    local ao = g.Stroke(i.Foreground)
                    ao.Transparency = 0.9
                    ao.Parent = V
                    Z = h("UIScale", { Parent = V })
                    if J then
                        local ap, aq =
                            h("Frame", {
                                Name = "Search",
                                BackgroundColor3 = i.Input,
                                BackgroundTransparency = 0.7,
                                BorderSizePixel = 0,
                                Size = UDim2.new(1, 0, 0, j),
                                LayoutOrder = 1,
                                ZIndex = 21,
                                Parent = V,
                            }, { g.Corner(d.Radius.Md) }), g.Stroke(i.Input)
                        aq.Transparency = 0.7
                        aq.Parent = ap
                        h("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = f.Get("search") or "",
                            ImageColor3 = i.MutedForeground,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(0, 10, 0.5, 0),
                            Size = UDim2.fromOffset(16, 16),
                            ZIndex = 22,
                            Parent = ap,
                        })
                        local ar = h("TextBox", {
                            Name = "Input",
                            BackgroundTransparency = 1,
                            ClearTextOnFocus = false,
                            FontFace = e.Regular,
                            TextSize = d.TextSize.Sm,
                            TextColor3 = i.Foreground,
                            PlaceholderColor3 = i.MutedForeground,
                            PlaceholderText = "Search",
                            Text = "",
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            Position = UDim2.fromOffset(32, 0),
                            Size = UDim2.new(1, -40, 1, 0),
                            ZIndex = 22,
                            Parent = ap,
                        })
                        w:Connect(ar.Focused, function()
                            d.Rebind(aq, "Color", "Ring")
                            aq.Transparency = 0
                        end)
                        w:Connect(ar:GetPropertyChangedSignal("Text"), function()
                            ac = 1
                            al()
                        end)
                        w:Connect(ar.FocusLost, function(as)
                            d.Rebind(aq, "Color", "Input")
                            aq.Transparency = 0.7
                            if as and T() then
                                local at = ab[ac]
                                if at then
                                    am(at.choice)
                                end
                                if B and T() then
                                    ar:CaptureFocus()
                                end
                            end
                        end)
                        W = ar
                    else
                        W = nil
                    end
                    af = nil
                    ag = nil
                    if B then
                        local ap = h("TextButton", {
                            Name = "SelectAll",
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundColor3 = i.Foreground,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, k),
                            LayoutOrder = 2,
                            ZIndex = 22,
                            Parent = V,
                        }, { g.Corner(d.Radius.Md), g.Padding(0, 8, 0, 6) })
                        h("ImageLabel", {
                            BackgroundTransparency = 1,
                            Image = f.Get("sf:checklist") or f.Get("list-checks") or "",
                            ImageColor3 = i.MutedForeground,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.fromScale(0, 0.5),
                            Size = UDim2.fromOffset(16, 16),
                            ZIndex = 23,
                            Parent = ap,
                        })
                        ag = g.Text({
                            Text = "Select all",
                            FontFace = e.Medium,
                            Position = UDim2.fromOffset(24, 0),
                            Size = UDim2.new(1, -24, 1, 0),
                            ZIndex = 23,
                            Parent = ap,
                        })
                        if C then
                            g.Text({
                                Text = "max " .. C,
                                TextColor3 = i.MutedForeground,
                                TextSize = d.TextSize.Xs,
                                TextXAlignment = Enum.TextXAlignment.Right,
                                Size = UDim2.fromScale(1, 1),
                                ZIndex = 23,
                                Parent = ap,
                            })
                        end
                        ap.MouseEnter:Connect(function()
                            d.Tween(ap, { BackgroundTransparency = 0.9 }, n)
                        end)
                        ap.MouseLeave:Connect(function()
                            d.Tween(ap, { BackgroundTransparency = 1 }, n)
                        end)
                        ap.MouseButton1Click:Connect(function()
                            if z.Locked or aj() then
                                return
                            end
                            local aq = {}
                            for ar, as in ipairs(ab) do
                                if as.choice ~= D then
                                    aq[as.choice] = true
                                end
                            end
                            local ar, as = (ag).Text == "Clear selection", {}
                            for at, au in ipairs(F) do
                                local av = U(au)
                                if aq[au] then
                                    av = not ar
                                end
                                if av then
                                    table.insert(as, au)
                                end
                            end
                            if C and #as > C then
                                local at = {}
                                for au, av in ipairs(as) do
                                    if U(av) and #at < C then
                                        table.insert(at, av)
                                    end
                                end
                                for au, av in ipairs(as) do
                                    if not U(av) and #at < C then
                                        table.insert(at, av)
                                    end
                                end
                                local au = {}
                                for av, aw in ipairs(F) do
                                    if table.find(at, aw) then
                                        table.insert(au, aw)
                                    end
                                end
                                as = au
                            end
                            A(as)
                            ak()
                        end)
                        h("Frame", {
                            Name = "Separator",
                            BackgroundColor3 = i.Foreground,
                            BackgroundTransparency = 0.92,
                            BorderSizePixel = 0,
                            AnchorPoint = Vector2.new(0, 1),
                            Position = UDim2.new(0, -6, 1, 2),
                            Size = UDim2.new(1, 14, 0, 1),
                            ZIndex = 22,
                            Parent = ap,
                        })
                        af = ap
                    end
                    X = h("ScrollingFrame", {
                        Name = "List",
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, k),
                        CanvasSize = UDim2.new(),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 0,
                        ScrollingDirection = Enum.ScrollingDirection.Y,
                        LayoutOrder = 3,
                        ZIndex = 21,
                        Parent = V,
                    }, { g.List(0) })
                    Y = g.Text({
                        Name = "Empty",
                        Text = "No items found",
                        TextColor3 = i.MutedForeground,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Size = UDim2.new(1, 0, 0, 36),
                        LayoutOrder = 4,
                        Visible = false,
                        ZIndex = 21,
                        Parent = V,
                    })
                    local ap = nil
                    for aq, ar in ipairs(G) do
                        if ar.label then
                            local as = g.Text({
                                Name = "Label",
                                Text = ar.label,
                                TextColor3 = i.MutedForeground,
                                TextSize = d.TextSize.Xs,
                                Size = UDim2.new(1, 0, 0, l),
                                LayoutOrder = aq,
                                ZIndex = 22,
                                Parent = X,
                            })
                            g.Padding(0, 8, 0, 8).Parent = as
                            ap = { frame = as, members = {} }
                            table.insert(aa, ap)
                        else
                            local as = ar.choice
                            if ap then
                                table.insert(ap.members, as)
                            end
                            local at = h("TextButton", {
                                Name = as,
                                Text = "",
                                AutoButtonColor = false,
                                BackgroundColor3 = i.Foreground,
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Size = UDim2.new(1, 0, 0, k),
                                LayoutOrder = aq,
                                ZIndex = 22,
                                Parent = X,
                            }, { g.Corner(d.Radius.Md), g.Padding(0, 32, 0, 6) })
                            local au = g.Text({
                                Text = as,
                                TextTruncate = Enum.TextTruncate.AtEnd,
                                Size = UDim2.fromScale(1, 1),
                                ZIndex = 23,
                                Parent = at,
                            })
                            if H[as] then
                                u(at, H[as], 23)
                            end
                            if next(H) ~= nil then
                                au.Position = UDim2.fromOffset(t + 8, 0)
                                au.Size = UDim2.new(1, -(t + 8), 1, 0)
                            end
                            local av = h("ImageLabel", {
                                Name = "Check",
                                BackgroundTransparency = 1,
                                Image = f.Get("check") or "",
                                ImageColor3 = i.Foreground,
                                AnchorPoint = Vector2.new(0, 0.5),
                                Position = UDim2.new(1, 8, 0.5, 0),
                                Size = UDim2.fromOffset(18, 18),
                                Visible = false,
                                ZIndex = 23,
                                Parent = at,
                            })
                            local aw = { choice = as, button = at, check = av, label = au }
                            w:Connect(at.MouseEnter, function()
                                ac = table.find(ab, aw) or 0
                                ae()
                            end)
                            w:Connect(at.MouseButton1Click, function()
                                am(as)
                            end)
                            table.insert(_, aw)
                        end
                    end
                    ad = false
                    ak()
                end
                local function ao()
                    local ap = false
                    if B then
                        local aq = z.Value or {}
                        ap = #aq > 0
                        Q.Visible = ap
                        if ap then
                            local ar = tostring(#aq)
                            if C then
                                ar = #aq .. "/" .. C
                            end
                            Q.Text = ar
                            N.Text = table.concat(aq, ", ")
                            d.Rebind(N, "TextColor3", "Foreground")
                            N.Size = UDim2.new(1, -(math.max(q(ar) + 14, 20) + 6), 1, 0)
                        else
                            N.Text = I
                            N.Size = UDim2.fromScale(1, 1)
                            d.Rebind(N, "TextColor3", "MutedForeground")
                        end
                    else
                        ap = z.Value ~= nil
                        N.Visible = true
                        if ap then
                            N.Text = tostring(z.Value)
                            d.Rebind(N, "TextColor3", "Foreground")
                        else
                            N.Text = I
                            d.Rebind(N, "TextColor3", "MutedForeground")
                        end
                        local aq = nil
                        if ap then
                            aq = H[tostring(z.Value)]
                        end
                        O.Visible = aq ~= nil
                        if aq then
                            P(aq)
                            N.Position = UDim2.fromOffset(t + 8, 0)
                            N.Size = UDim2.new(1, -(t + 8), 1, 0)
                        else
                            N.Position = UDim2.fromOffset(0, 0)
                            N.Size = UDim2.fromScale(1, 1)
                        end
                    end
                    R.Visible = ap and y.Clearable ~= false
                    ak()
                end
                local function ap()
                    if T() then
                        v:_closePopover()
                    end
                end
                local function aq()
                    if z.Locked or T() then
                        return
                    end
                    if ad or not V then
                        an()
                    end
                    local ar = V
                    ar.Size = UDim2.fromOffset(math.max(K.AbsoluteSize.X + 28, 160), 0)
                    ac = 0
                    if W then
                        W.Text = ""
                    end
                    for as, at in ipairs(_) do
                        if U(at.choice) and ac == 0 then
                            ac = as
                        end
                    end
                    d.Rebind(L, "Color", "Ring")
                    d.Tween(S, { Rotation = 180 })
                    v:_openPopover(ar, K, function()
                        d.Rebind(L, "Color", "Input")
                        d.Tween(S, { Rotation = 0 })
                        if W then
                            W:ReleaseFocus()
                        end
                    end)
                    if Z then
                        Z.Scale = 0.95
                        d.Tween(Z, { Scale = 1 }, n)
                    end
                    al()
                end
                am = function(ar)
                    if B then
                        if D ~= nil and ar == D then
                            if U(ar) then
                                A({})
                            else
                                A({ ar })
                            end
                            return
                        end
                        if aj() then
                            return
                        end
                        if ai() and not U(ar) then
                            return
                        end
                        local as = {}
                        for at, au in ipairs(F) do
                            local av = U(au)
                            if au == ar then
                                av = not av
                            end
                            if av then
                                table.insert(as, au)
                            end
                        end
                        A(as)
                    else
                        A(ar)
                        ap()
                    end
                end
                w:Connect(K:GetPropertyChangedSignal("AbsoluteSize"), function()
                    if T() and V then
                        V.Size = UDim2.fromOffset(math.max(K.AbsoluteSize.X + 28, 160), 0)
                    end
                end)
                w:Connect(K.MouseButton1Click, function()
                    if T() then
                        ap()
                    else
                        aq()
                    end
                end)
                w:Connect(R.MouseButton1Click, function()
                    if z.Locked then
                        return
                    end
                    if B then
                        A({})
                    else
                        A(nil)
                    end
                end)
                w:Connect(c.InputBegan, function(ar)
                    if not T() or not (W and W:IsFocused()) then
                        return
                    end
                    local as = ar.KeyCode
                    if as == Enum.KeyCode.Down then
                        ac = math.min(ac + 1, #ab)
                        ae()
                    elseif as == Enum.KeyCode.Up then
                        ac = math.max(ac - 1, 1)
                        ae()
                    end
                    local at = ab[ac]
                    if at and X then
                        local au = at.button.AbsolutePosition.Y - X.AbsolutePosition.Y
                        local av = au + k
                        if au < 0 then
                            X.CanvasPosition -= Vector2.new(0, -au)
                        elseif av > X.AbsoluteSize.Y then
                            X.CanvasPosition += Vector2.new(0, av - X.AbsoluteSize.Y)
                        end
                    end
                end)
                return {
                    Instance = K,
                    Refresh = ao,
                    Close = ap,
                    SetOptions = function(ar)
                        F, G, H = s(E(ar))
                        ad = true
                        ap()
                    end,
                    Choices = function()
                        return F
                    end,
                    SetLocked = function(ar)
                        local as = 0
                        if ar then
                            as = 0.5
                        end
                        d.Tween(N, { TextTransparency = as })
                        d.Tween(S, { ImageTransparency = as })
                        if ar then
                            ap()
                        end
                    end,
                }
            end
            return o
        end
        function a.n()
            local aa = a.cache.n
            if not aa then
                aa = { c = b() }
                a.cache.n = aa
            end
            return aa.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae, af = a.Theme(), a.Fonts(), a.Icons(), a.Creator(), a.i()
            local ag, ah, ai, aj, ak, al, am, an, ao, ap =
                ae.Create,
                ab.Token,
                248,
                150,
                12,
                20,
                TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {},
                {},
                6
            local function aq(ar)
                for as, at in ipairs(ao) do
                    if at:ToHex() == ar:ToHex() then
                        table.remove(ao, as)
                        break
                    end
                end
                table.insert(ao, 1, ar)
                while #ao > ap do
                    table.remove(ao)
                end
            end
            function an.Hex(ar, as)
                local at = "#" .. string.upper(ar:ToHex())
                if as and as > 0 then
                    at ..= string.format("%02X", math.floor((1 - as) * 255 + 0.5))
                end
                return at
            end
            function an.Parse(ar)
                local as = string.gsub(string.gsub(ar, "%s", ""), "^#", "")
                if string.find(as, "[^%x]") then
                    return nil, nil
                end
                if #as == 3 then
                    as = string.gsub(as, "%x", "%0%0")
                end
                if #as == 6 then
                    return Color3.fromHex(as), nil
                end
                if #as == 8 then
                    local at = (tonumber(string.sub(as, 7, 8), 16))
                    return Color3.fromHex(string.sub(as, 1, 6)), 1 - at / 255
                end
                return nil, nil
            end
            local function ar(as, at, au, av, aw)
                return ag(
                    "CanvasGroup",
                    {
                        Name = at,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = av,
                        ZIndex = aw or 21,
                        Parent = as,
                    },
                    {
                        ag("UICorner", { CornerRadius = UDim.new(0, au) }),
                    }
                )
            end
            local function as(at, au, av, aw)
                local b = ag(
                    "Frame",
                    {
                        Name = "Checker",
                        BackgroundColor3 = ah.Muted,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        Parent = at,
                    }
                )
                for c = 0, av - 1 do
                    for d = 0, au - 1 do
                        if (c + d) % 2 == 0 then
                            ag("Frame", {
                                BackgroundColor3 = ah.Border,
                                BorderSizePixel = 0,
                                Position = UDim2.fromOffset(d * aw, c * aw),
                                Size = UDim2.fromOffset(aw, aw),
                                Parent = b,
                            })
                        end
                    end
                end
                return b
            end
            local function at(au)
                local av = ag("Frame", {
                    Name = "Thumb",
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.fromOffset(16, 16),
                    ZIndex = 4,
                    Parent = au,
                }, { ag("UICorner", { CornerRadius = UDim.new(1, 0) }) })
                ag("UIStroke", {
                    Color = Color3.new(0, 0, 0),
                    Transparency = 0.75,
                    Thickness = 1,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    Parent = av,
                })
                ag("Frame", {
                    Name = "Fill",
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(10, 10),
                    ZIndex = 5,
                    Parent = av,
                }, { ag("UICorner", { CornerRadius = UDim.new(1, 0) }) })
                return av
            end
            function an.new(au, av, aw, b, c, d, e)
                local f, g =
                    ag("TextButton", {
                        Name = "Trigger",
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = ah.Input,
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 32),
                        Parent = aw,
                    }, { ae.Corner(ab.Radius.Lg) }), ae.Stroke(ah.Input)
                g.Parent = f
                local h = ar(f, "Swatch", 5, UDim2.fromOffset(al, al), 2)
                h.AnchorPoint = Vector2.new(0, 0.5)
                h.Position = UDim2.new(0, 6, 0.5, 0)
                as(h, 4, 4, 5)
                local i, j =
                    ag(
                        "Frame",
                        { Name = "Color", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = h }
                    ),
                    ae.Stroke(ah.Foreground)
                j.Transparency = 0.85
                j.Parent = h
                local k, l, m, n, o =
                    ae.Text({
                        Name = "Hex",
                        Text = "",
                        FontFace = ac.Medium,
                        TextSize = ab.TextSize.Sub,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Position = UDim2.fromOffset(al + 14, 0),
                        Size = UDim2.new(1, -(al + 20), 1, 0),
                        Parent = f,
                    }), 0, 0, 1, 0
                local function p()
                    local q, r, s = (b.Value):ToHSV()
                    if r > 0 and s > 0 then
                        l = q
                    end
                    if s > 0 then
                        m = r
                    end
                    n = s
                    o = b.Transparency or 0
                end
                local function q()
                    return Color3.fromHSV(l, m, n)
                end
                local r, s = nil, {}
                local function t()
                    return au._popover ~= nil and au._popover.anchor == f
                end
                local function u()
                    if c then
                        return an.Hex(q(), o)
                    end
                    return an.Hex(q())
                end
                local function v()
                    local w = q()
                    i.BackgroundColor3 = w
                    i.BackgroundTransparency = o
                    k.Text = u()
                    if not r then
                        return
                    end
                    s.hueLayer.BackgroundColor3 = Color3.fromHSV(l, 1, 1)
                    s.cursor.Position = UDim2.fromScale(m, 1 - n)
                    s.cursor.BackgroundColor3 = w
                    s.hueThumb.Position = UDim2.fromScale(l, 0.5)
                    s.hueThumb.Fill.BackgroundColor3 = Color3.fromHSV(l, 1, 1)
                    s.preview.BackgroundColor3 = w
                    s.preview.BackgroundTransparency = o
                    if s.alphaBar then
                        s.alphaFill.BackgroundColor3 = w
                        s.alphaThumb.Position = UDim2.fromScale(1 - o, 0.5)
                        s.alphaThumb.Fill.BackgroundColor3 = w
                        s.alphaThumb.Fill.BackgroundTransparency = o
                    end
                    if not s.hex:IsFocused() then
                        s.hex.Text = u()
                    end
                end
                local function w(x)
                    v()
                    d(q(), o, x)
                    if x then
                        aq(q())
                    end
                end
                local function x(y, z)
                    av:Connect(y.InputBegan, function(A)
                        if b.Locked then
                            return
                        end
                        local B = A.UserInputType == Enum.UserInputType.MouseButton1
                            or A.UserInputType == Enum.UserInputType.Touch
                        if not B then
                            return
                        end
                        local function C(D)
                            local E, F = y.AbsolutePosition, y.AbsoluteSize
                            z(
                                math.clamp((D.X - E.X) / math.max(F.X, 1), 0, 1),
                                math.clamp((D.Y - E.Y) / math.max(F.Y, 1), 0, 1)
                            )
                            w(false)
                        end
                        au:_drag(A, C, function()
                            w(true)
                        end)
                        C(A.Position)
                    end)
                end
                local function y()
                    local z, A =
                        av:Give(ag("Frame", {
                            Name = "ColorPicker",
                            BackgroundColor3 = ah.Popover,
                            BackgroundTransparency = 0.04,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(ai, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            ZIndex = 20,
                        }, { ae.Corner(ab.Radius.Xl), ae.Padding(12), ae.List(12) })), ae.Stroke(ah.Foreground)
                    A.Transparency = 0.9
                    A.Parent = z
                    s.scale = ag("UIScale", { Parent = z })
                    local B = ag("TextButton", {
                        Name = "Square",
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, aj),
                        LayoutOrder = 1,
                        ZIndex = 21,
                        Parent = z,
                    })
                    local C = ar(B, "Surface", ab.Radius.Lg, UDim2.fromScale(1, 1), 21)
                    local D = ag(
                        "Frame",
                        { Name = "Hue", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 21, Parent = C }
                    )
                    ag("Frame", {
                        Name = "White",
                        BackgroundColor3 = Color3.new(1, 1, 1),
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 22,
                        Parent = C,
                    }, { ag("UIGradient", { Transparency = NumberSequence.new(0, 1) }) })
                    ag("Frame", {
                        Name = "Black",
                        BackgroundColor3 = Color3.new(0, 0, 0),
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 23,
                        Parent = C,
                    }, {
                        ag("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }),
                    })
                    local E = ae.Stroke(ah.Foreground)
                    E.Transparency = 0.9
                    E.Parent = C
                    local F = ag("Frame", {
                        Name = "Cursor",
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.fromOffset(16, 16),
                        ZIndex = 25,
                        Parent = B,
                    }, {
                        ag("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        ag("UIStroke", { Color = Color3.new(1, 1, 1), Thickness = 2.5 }),
                    })
                    ag("Frame", {
                        Name = "Shade",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.new(1, 7, 1, 7),
                        ZIndex = 24,
                        Parent = F,
                    }, {
                        ag("UICorner", { CornerRadius = UDim.new(1, 0) }),
                        ag("UIStroke", { Color = Color3.new(0, 0, 0), Thickness = 1, Transparency = 0.7 }),
                    })
                    x(B, function(G, H)
                        m = G
                        n = 1 - H
                    end)
                    local G = ag("Frame", {
                        Name = "HueTrack",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, ak),
                        LayoutOrder = 2,
                        ZIndex = 21,
                        Parent = z,
                    })
                    local H, I =
                        ag("TextButton", {
                            Name = "Hue",
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundColor3 = Color3.new(1, 1, 1),
                            BorderSizePixel = 0,
                            Size = UDim2.fromScale(1, 1),
                            ZIndex = 21,
                            Parent = G,
                        }, {
                            ae.Corner(ak / 2),
                            ag("UIGradient", {
                                Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)),
                                    ColorSequenceKeypoint.new(0.16666666666666666, Color3.fromHSV(0.16666666666666666, 1, 1)),
                                    ColorSequenceKeypoint.new(0.3333333333333333, Color3.fromHSV(0.3333333333333333, 1, 1)),
                                    ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
                                    ColorSequenceKeypoint.new(0.6666666666666666, Color3.fromHSV(0.6666666666666666, 1, 1)),
                                    ColorSequenceKeypoint.new(0.8333333333333334, Color3.fromHSV(0.8333333333333334, 1, 1)),
                                    ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1)),
                                }),
                            }),
                        }), at(G)
                    x(H, function(J)
                        l = math.min(J, 0.9999)
                    end)
                    if c then
                        local J = ag("Frame", {
                            Name = "Alpha",
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, ak),
                            LayoutOrder = 3,
                            ZIndex = 21,
                            Parent = z,
                        })
                        local K = ag("TextButton", {
                            Name = "Bar",
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundTransparency = 1,
                            Size = UDim2.fromScale(1, 1),
                            ZIndex = 21,
                            Parent = J,
                        })
                        local L = ar(K, "Surface", ak / 2, UDim2.fromScale(1, 1), 21)
                        as(L, 42, 2, ak / 2)
                        s.alphaFill = ag(
                            "Frame",
                            {
                                Name = "Fill",
                                BorderSizePixel = 0,
                                Size = UDim2.fromScale(1, 1),
                                ZIndex = 22,
                                Parent = L,
                            },
                            { ag("UIGradient", { Transparency = NumberSequence.new(1, 0) }) }
                        )
                        s.alphaBar = K
                        s.alphaThumb = at(J)
                        x(K, function(M)
                            o = 1 - M
                        end)
                    end
                    local J = ag("Frame", {
                        Name = "Footer",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 32),
                        LayoutOrder = 4,
                        ZIndex = 21,
                        Parent = z,
                    }, {
                        ag("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    })
                    local K = ar(J, "Preview", ab.Radius.Md, UDim2.fromOffset(32, 32), 21)
                    K.LayoutOrder = 1
                    as(K, 4, 4, 8)
                    s.preview = ag(
                        "Frame",
                        { Name = "Color", BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), ZIndex = 22, Parent = K }
                    )
                    local L = ae.Stroke(ah.Foreground)
                    L.Transparency = 0.85
                    L.Parent = K
                    local M, N =
                        ag("Frame", {
                            Name = "Field",
                            BackgroundColor3 = ah.Input,
                            BackgroundTransparency = 0.7,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, -80, 1, 0),
                            LayoutOrder = 2,
                            ZIndex = 21,
                            Parent = J,
                        }, {
                            ae.Corner(ab.Radius.Lg),
                        }), ag("TextButton", { Name = "Reset", Text = "", AutoButtonColor = false, BackgroundColor3 = ah.Accent, BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromOffset(32, 32), LayoutOrder = 3, ZIndex = 21, Parent = J }, { ae.Corner(ab.Radius.Lg) })
                    ag("ImageLabel", {
                        BackgroundTransparency = 1,
                        Image = ad.Get("rotate-ccw") or "",
                        ImageColor3 = ah.MutedForeground,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(18, 18),
                        ZIndex = 22,
                        Parent = N,
                    })
                    N.MouseEnter:Connect(function()
                        ab.Tween(N, { BackgroundTransparency = 0 }, am)
                    end)
                    N.MouseLeave:Connect(function()
                        ab.Tween(N, { BackgroundTransparency = 1 }, am)
                    end)
                    N.MouseButton1Click:Connect(function()
                        if b.Locked then
                            return
                        end
                        l, m, n = e.color:ToHSV()
                        o = e.transparency
                        w(true)
                    end)
                    local O = ae.Stroke(ah.Input)
                    O.Parent = M
                    local P = ag("TextBox", {
                        Name = "Hex",
                        BackgroundTransparency = 1,
                        ClearTextOnFocus = false,
                        FontFace = ac.Medium,
                        TextSize = ab.TextSize.Sm,
                        TextColor3 = ah.Foreground,
                        PlaceholderColor3 = ah.MutedForeground,
                        PlaceholderText = "#RRGGBB",
                        Text = "",
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 22,
                        Parent = M,
                    }, { ae.Padding(0, 10, 0, 10) })
                    av:Connect(P.Focused, function()
                        ab.Rebind(O, "Color", "Ring")
                    end)
                    av:Connect(P.FocusLost, function()
                        ab.Rebind(O, "Color", "Input")
                        local Q, R = an.Parse(P.Text)
                        if Q and not b.Locked then
                            l, m, n = Q:ToHSV()
                            if R and c then
                                o = R
                            end
                            w(true)
                        else
                            v()
                        end
                    end)
                    s.hex = P
                    local Q = ag("Frame", {
                        Name = "Swatches",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 5,
                        ZIndex = 21,
                        Parent = z,
                    }, {
                        ag("UIGridLayout", {
                            CellSize = UDim2.fromOffset(al, al),
                            CellPadding = UDim2.fromOffset(4, 4),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    })
                    s.swatches = Q
                    s.square = B
                    s.hueLayer = D
                    s.cursor = F
                    s.hueThumb = I
                    r = z
                end
                local function z()
                    local A = s.swatches
                    for B, C in ipairs(A:GetChildren()) do
                        if C:IsA("GuiButton") then
                            C:Destroy()
                        end
                    end
                    local B = {}
                    for C, D in ipairs(af.Cycle) do
                        table.insert(B, af.Colors[D])
                    end
                    table.insert(B, Color3.new(1, 1, 1))
                    table.insert(B, Color3.new(0, 0, 0))
                    for C, D in ipairs(ao) do
                        table.insert(B, D)
                    end
                    for C, D in ipairs(B) do
                        local E, F =
                            ag("TextButton", {
                                Name = "Swatch",
                                Text = "",
                                AutoButtonColor = false,
                                BackgroundColor3 = D,
                                BorderSizePixel = 0,
                                LayoutOrder = C,
                                ZIndex = 22,
                                Parent = A,
                            }, { ae.Corner(5) }), ae.Stroke(ah.Foreground)
                        F.Transparency = 0.85
                        F.Parent = E
                        E.MouseEnter:Connect(function()
                            ab.Tween(F, { Transparency = 0.3 }, am)
                        end)
                        E.MouseLeave:Connect(function()
                            ab.Tween(F, { Transparency = 0.85 }, am)
                        end)
                        E.MouseButton1Click:Connect(function()
                            if b.Locked then
                                return
                            end
                            l, m, n = D:ToHSV()
                            w(true)
                        end)
                    end
                end
                local function A()
                    if b.Locked or t() then
                        return
                    end
                    if not r then
                        y()
                    end
                    p()
                    z()
                    v()
                    ab.Rebind(g, "Color", "Ring")
                    au:_openPopover(r, f, function()
                        ab.Rebind(g, "Color", "Input")
                        if s.hex then
                            s.hex:ReleaseFocus()
                        end
                    end)
                    s.scale.Scale = 0.95
                    ab.Tween(s.scale, { Scale = 1 }, am)
                end
                av:Connect(f.MouseButton1Click, function()
                    if t() then
                        au:_closePopover()
                    else
                        A()
                    end
                end)
                return {
                    Instance = f,
                    Refresh = function()
                        p()
                        v()
                    end,
                    Close = function()
                        if t() then
                            au:_closePopover()
                        end
                    end,
                    SetLocked = function(B)
                        local C = 0
                        if B then
                            C = 0.5
                        end
                        ab.Tween(k, { TextTransparency = C })
                        if B and t() then
                            au:_closePopover()
                        end
                    end,
                }
            end
            return an
        end
        function a.o()
            local ab = a.cache.o
            if not ab then
                ab = { c = aa() }
                a.cache.o = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae, af = a.Theme(), a.Fonts(), a.Icons(), a.Creator(), a.g()
            local ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av =
                ae.Create, ab.Token, 38, 40, 32, 12, 0.92, 12, 16, 26, 20, 20, 8, 96, {
                    Default = { bg = "Primary", fg = "PrimaryForeground" },
                    Secondary = { bg = "Secondary", fg = "SecondaryForeground" },
                    Destructive = { bg = "Destructive", fg = "DestructiveForeground" },
                    Outline = { bg = "Background", fg = "Foreground", border = true },
                }, {}
            local function aw(b, c, d)
                return math.ceil(ae.TextWidth(b, d or ab.TextSize.Sm, c))
            end
            local function b(c)
                if type(c) == "table" then
                    return tostring(c.Text or ""), c
                end
                if c == nil then
                    return "", {}
                end
                return tostring(c), {}
            end
            local c, d =
                {
                    Left = Enum.TextXAlignment.Left,
                    Center = Enum.TextXAlignment.Center,
                    Right = Enum.TextXAlignment.Right,
                },
                {
                    Left = Enum.HorizontalAlignment.Left,
                    Center = Enum.HorizontalAlignment.Center,
                    Right = Enum.HorizontalAlignment.Right,
                }
            function av.new(e, f, g)
                local h = {}
                for i, j in ipairs(g.Columns or {}) do
                    if type(j) == "string" then
                        j = { Title = j }
                    end
                    local k = j.Align or "Left"
                    table.insert(h, {
                        key = j.Key or j.Title or i,
                        title = j.Title or tostring(j.Key or i),
                        width = j.Width,
                        grow = j.Grow or 1,
                        align = c[k] or Enum.TextXAlignment.Left,
                        hAlign = d[k] or Enum.HorizontalAlignment.Left,
                        sortable = j.Sortable ~= false and g.Sortable ~= false,
                        index = i,
                    })
                end
                local i, j = g.RowHeight or aj, at
                if g.Compact then
                    i = g.RowHeight or ak
                    j = i
                end
                local k, l, m, n, o, p, q =
                    {},
                    g.Footer,
                    nil,
                    false,
                    g.Selectable == true,
                    { RowClicked = e:Give(af.new()), SelectionChanged = e:Give(af.new()), Selected = nil },
                    ag("Frame", {
                        Name = "Table",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ClipsDescendants = true,
                        Parent = f,
                    }, { ae.List(0), ae.Corner(ab.Radius.Lg) })
                p.Instance = q
                local r = ag("Frame", {
                    Name = "Header",
                    BackgroundColor3 = ah.Muted,
                    BackgroundTransparency = 0.5,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Size = UDim2.new(1, 0, 0, ai),
                    LayoutOrder = 1,
                    Visible = g.Header ~= false,
                    Parent = q,
                }, { ae.Corner(ab.Radius.Md) })
                local s = ag(
                    "Frame",
                    { Name = "Strip", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = r }
                )
                ag("Frame", {
                    Name = "Hairline",
                    BackgroundColor3 = ah.Foreground,
                    BackgroundTransparency = am,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.fromScale(0, 1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    Parent = r,
                })
                local t = ag("ScrollingFrame", {
                    Name = "Body",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    CanvasSize = UDim2.new(),
                    ScrollBarThickness = 4,
                    ScrollBarImageColor3 = ah.Border,
                    ScrollingDirection = Enum.ScrollingDirection.XY,
                    VerticalScrollBarInset = Enum.ScrollBarInset.None,
                    HorizontalScrollBarInset = Enum.ScrollBarInset.None,
                    ElasticBehavior = Enum.ElasticBehavior.Never,
                    LayoutOrder = 2,
                    Parent = q,
                })
                local u, v =
                    ag(
                        "Frame",
                        { Name = "Rows", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), Parent = t },
                        { ae.List(0) }
                    ),
                    ag("Frame", {
                        Name = "Footer",
                        BackgroundColor3 = ah.Muted,
                        BackgroundTransparency = 0.5,
                        BorderSizePixel = 0,
                        ClipsDescendants = true,
                        Size = UDim2.new(1, 0, 0, i),
                        LayoutOrder = 3,
                        Visible = false,
                        Parent = q,
                    })
                local w = ag(
                    "Frame",
                    { Name = "Strip", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = v }
                )
                ag("Frame", {
                    Name = "Hairline",
                    BackgroundColor3 = ah.Foreground,
                    BackgroundTransparency = am,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 2,
                    Parent = v,
                })
                local x = ae.Text({
                    Name = "Caption",
                    Text = g.Caption or "",
                    TextColor3 = ah.MutedForeground,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0),
                    LayoutOrder = 4,
                    Visible = (g.Caption or "") ~= "",
                    Parent = q,
                })
                ae.Padding(12, 12, 12, 12).Parent = x
                local y = ag(
                    "Frame",
                    {
                        Name = "Empty",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, j),
                        Visible = false,
                        Parent = t,
                    },
                    {
                        ag("UIListLayout", {
                            HorizontalAlignment = Enum.HorizontalAlignment.Center,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    }
                )
                ag("ImageLabel", {
                    Name = "Icon",
                    BackgroundTransparency = 1,
                    Image = ad.Get(g.EmptyIcon or "tray") or ad.Get("inbox") or "",
                    ImageColor3 = ah.MutedForeground,
                    ImageTransparency = 0.3,
                    Size = UDim2.fromOffset(28, 28),
                    LayoutOrder = 1,
                    Visible = j >= at,
                    Parent = y,
                })
                ae.Text({
                    Name = "Note",
                    Text = g.Empty or "No results",
                    TextColor3 = ah.MutedForeground,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 18),
                    LayoutOrder = 2,
                    Parent = y,
                })
                local z, A, B = {}, {}, {}
                local function C(D, E)
                    if type(D) ~= "table" then
                        return nil
                    end
                    local F = D[E.key]
                    if F ~= nil then
                        return F
                    end
                    return D[E.index]
                end
                local function D(E, F)
                    local G, H = b(E)
                    if H.Badge then
                        return aw(G, ac.Medium, ab.TextSize.Xs) + as * 2
                    end
                    local I = aw(G, F)
                    if H.Icon and ad.IsImage(H.Icon) then
                        I += ap + 6
                    elseif H.Icon then
                        I += ao + 6
                    end
                    return I
                end
                local function E()
                    local F = {}
                    for G, H in ipairs(h) do
                        if H.width then
                            F[G] = H.width
                        else
                            local I = aw(H.title, ac.Medium, ab.TextSize.Xs)
                            if H.sortable then
                                I += an + 4
                            end
                            for J, K in ipairs(k) do
                                local L = ac.Regular
                                if G == 1 then
                                    L = ac.Medium
                                end
                                I = math.max(I, D(C(K, H), L))
                            end
                            if l then
                                I = math.max(I, D(C(l, H), ac.Medium))
                            end
                            F[G] = I + al * 2
                        end
                    end
                    return F
                end
                local function F(G, H, I, J, K)
                    local L, M = b(H)
                    local N = ag(
                        "Frame",
                        { Name = I.title, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), Parent = G },
                        {
                            ae.Padding(0, al, 0, al),
                            ag("UIListLayout", {
                                FillDirection = Enum.FillDirection.Horizontal,
                                HorizontalAlignment = I.hAlign,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                Padding = UDim.new(0, 6),
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            }),
                        }
                    )
                    if M.Badge and typeof(M.Tint) == "Color3" then
                        local O = M.Tint
                        local P = ag("Frame", {
                            Name = "Badge",
                            BackgroundColor3 = O,
                            BackgroundTransparency = 0.84,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(aw(L, ac.Medium, ab.TextSize.Xs) + as * 2, ar),
                            Parent = N,
                        }, { ae.Corner(ar) })
                        ag("UIStroke", {
                            Color = O,
                            Transparency = 0.6,
                            Thickness = 1,
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            Parent = P,
                        })
                        ae.Text({
                            Name = "Text",
                            Text = L,
                            TextColor3 = O:Lerp(Color3.new(1, 1, 1), 0.2),
                            FontFace = ac.Medium,
                            TextSize = ab.TextSize.Xs,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            Size = UDim2.fromScale(1, 1),
                            Parent = P,
                        })
                        return N
                    end
                    if M.Badge then
                        local O = au[M.Badge] or au.Default
                        local P = ag("Frame", {
                            Name = "Badge",
                            BackgroundColor3 = ah[O.bg],
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(aw(L, ac.Medium, ab.TextSize.Xs) + as * 2, ar),
                            Parent = N,
                        }, { ae.Corner(ab.Radius.Md) })
                        if O.border then
                            P.BackgroundTransparency = 1
                            ae.Stroke(ah.Border).Parent = P
                        end
                        ae.Text({
                            Name = "Text",
                            Text = L,
                            TextColor3 = ah[O.fg],
                            FontFace = ac.Medium,
                            TextSize = ab.TextSize.Xs,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            Size = UDim2.fromScale(1, 1),
                            Parent = P,
                        })
                        return N
                    end
                    if M.Icon and ad.IsImage(M.Icon) then
                        local O = ag("Frame", {
                            Name = "Tile",
                            BackgroundColor3 = ah.Muted,
                            BackgroundTransparency = 0.4,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(ap, ap),
                            LayoutOrder = 1,
                            Parent = N,
                        }, { ae.Corner(ab.Radius.Md) })
                        if typeof(M.Tint) == "Color3" then
                            O.BackgroundColor3 = M.Tint
                            O.BackgroundTransparency = 0.84
                            ag("UIStroke", {
                                Color = M.Tint,
                                Transparency = 0.6,
                                Thickness = 1,
                                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                                Parent = O,
                            })
                        end
                        ag("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = ad.Get(M.Icon) or "",
                            ScaleType = Enum.ScaleType.Fit,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(aq, aq),
                            Parent = O,
                        })
                    elseif M.Icon then
                        ag("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = ad.Get(M.Icon) or "",
                            ImageColor3 = ah.MutedForeground,
                            Size = UDim2.fromOffset(ao, ao),
                            LayoutOrder = 1,
                            Parent = N,
                        })
                    end
                    local O, P = ab.TextSize.Sm, "Foreground"
                    if K then
                        O = ab.TextSize.Xs
                        P = "MutedForeground"
                    end
                    local Q = ae.Text({
                        Name = "Text",
                        Text = L,
                        FontFace = J,
                        TextSize = O,
                        TextXAlignment = I.align,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(1, 0, 1, 0),
                        LayoutOrder = 2,
                        Parent = N,
                    })
                    ab.Bind(Q, "TextColor3", P)
                    ag("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = Q })
                    if M.Muted then
                        ab.Bind(Q, "TextColor3", "MutedForeground")
                    elseif typeof(M.Color) == "Color3" then
                        Q.TextColor3 = M.Color
                    elseif type(M.Color) == "string" and ab.Themes.Dark[M.Color] then
                        ab.Bind(Q, "TextColor3", M.Color)
                    end
                    if M.Bold then
                        Q.FontFace = ac.SemiBold
                    end
                    return N
                end
                local function G(H)
                    local I = 0
                    for J, K in ipairs(h) do
                        local L = (H:FindFirstChild(K.title))
                        if L then
                            L.Position = UDim2.fromOffset(I, 0)
                            L.Size = UDim2.new(0, z[J] or 0, 1, 0)
                        end
                        I += z[J] or 0
                    end
                end
                local function H()
                    local I, J, K, L = E(), q.AbsoluteSize.X, 0, 0
                    for M, N in ipairs(I) do
                        K += N
                        L += h[M].grow
                    end
                    local M = math.max(J - K, 0)
                    for N, O in ipairs(I) do
                        local P = 0
                        if L > 0 then
                            P = M * h[N].grow / L
                        end
                        z[N] = math.floor(O + P)
                    end
                    local N = math.max(K, J)
                    s.Size = UDim2.new(0, N, 1, 0)
                    w.Size = UDim2.new(0, N, 1, 0)
                    u.Size = UDim2.new(0, N, 0, #A * i)
                    y.Size = UDim2.new(0, J, 0, j)
                    G(s)
                    G(w)
                    for O, P in ipairs(A) do
                        G(P.strip)
                    end
                    local O = #A * i
                    if #A == 0 then
                        O = j
                    end
                    local P = 0
                    if K > J + 0.5 then
                        P = t.ScrollBarThickness + 2
                    end
                    local Q = O + P
                    if g.MaxHeight then
                        Q = math.min(Q, g.MaxHeight)
                    end
                    t.Size = UDim2.new(1, 0, 0, Q)
                    t.CanvasSize = UDim2.fromOffset(N, O)
                end
                local function I()
                    for J, K in pairs(B) do
                        local L = K.sort
                        if L then
                            if m == J then
                                L.Image = ad.Get("chevron-up") or ""
                                L.ImageTransparency = 0
                                ab.Bind(L, "ImageColor3", "Foreground")
                                if n then
                                    L.Image = ad.Get("chevron-down") or ""
                                end
                            else
                                L.Image = ad.Get("chevrons-up-down") or ""
                                L.ImageTransparency = 0.55
                                ab.Bind(L, "ImageColor3", "MutedForeground")
                            end
                        end
                    end
                end
                local function J(K, L)
                    local M, N = p.Selected == K.index, 1
                    if M then
                        ab.Rebind(K.frame, "BackgroundColor3", "Primary")
                        N = 0.88
                    else
                        ab.Rebind(K.frame, "BackgroundColor3", "Muted")
                        if L then
                            N = 0.6
                        end
                    end
                    ab.Tween(K.frame, { BackgroundTransparency = N })
                    K.bar.Visible = M
                end
                local K
                local function L()
                    for M, N in ipairs(s:GetChildren()) do
                        N:Destroy()
                    end
                    table.clear(B)
                    for M, N in ipairs(h) do
                        local O, P = F(s, N.title, N, ac.Medium, true), {}
                        if N.sortable then
                            P.sort = ag("ImageLabel", {
                                Name = "Mark",
                                BackgroundTransparency = 1,
                                Image = ad.Get("chevrons-up-down") or "",
                                ImageColor3 = ah.MutedForeground,
                                ImageTransparency = 0.55,
                                Size = UDim2.fromOffset(an, an),
                                LayoutOrder = 3,
                                Parent = O,
                            })
                            local Q = (O:FindFirstChild("Text"))
                            Q.Size = UDim2.new(0, aw(N.title, ac.Medium, ab.TextSize.Xs), 1, 0)
                            Q:FindFirstChildOfClass("UIFlexItem"):Destroy()
                            local R = ag("TextButton", {
                                Name = "Sort",
                                Text = "",
                                AutoButtonColor = false,
                                BackgroundTransparency = 1,
                                Position = UDim2.fromOffset(-al, 0),
                                Size = UDim2.new(1, al * 2, 1, 0),
                                ZIndex = 2,
                                Parent = ag("Folder", { Parent = O }),
                            })
                            R.MouseEnter:Connect(function()
                                if m ~= M and P.sort then
                                    P.sort.ImageTransparency = 0.2
                                end
                            end)
                            R.MouseLeave:Connect(function()
                                if m ~= M and P.sort then
                                    P.sort.ImageTransparency = 0.55
                                end
                            end)
                            R.MouseButton1Click:Connect(function()
                                if m ~= M then
                                    p:Sort(M, false)
                                elseif not n then
                                    p:Sort(M, true)
                                else
                                    p:Sort(nil)
                                end
                            end)
                        end
                        B[M] = P
                    end
                    I()
                end
                local function M()
                    local N = {}
                    for O, P in ipairs(k) do
                        table.insert(N, { row = P, index = O })
                    end
                    if m then
                        local O = h[m]
                        local function P(Q)
                            if type(Q) == "table" then
                                if Q.Sort ~= nil then
                                    return Q.Sort
                                end
                                return Q.Text
                            end
                            return Q
                        end
                        table.sort(N, function(Q, R)
                            local S, T = P(C(Q.row, O)), P(C(R.row, O))
                            local U, V, W, X = tonumber(S), tonumber(T), nil, nil
                            if U and V then
                                W, X = U < V, V < U
                            else
                                local Y, Z = string.lower(tostring(S or "")), string.lower(tostring(T or ""))
                                W, X = Y < Z, Z < Y
                            end
                            if n then
                                return X
                            end
                            return W
                        end)
                    end
                    return N
                end
                K = function()
                    for N, O in ipairs(A) do
                        O.frame:Destroy()
                    end
                    table.clear(A)
                    local N = M()
                    for O, P in ipairs(N) do
                        local Q = ag("TextButton", {
                            Name = "Row" .. O,
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundColor3 = ah.Muted,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, i),
                            LayoutOrder = O,
                            Parent = u,
                        })
                        local R = ag(
                            "Frame",
                            { Name = "Strip", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = Q }
                        )
                        for S, T in ipairs(h) do
                            local U = ac.Regular
                            if S == 1 then
                                U = ac.Medium
                            end
                            F(R, C(P.row, T), T, U)
                        end
                        local S = ag("Frame", {
                            Name = "Bar",
                            BackgroundColor3 = ah.Primary,
                            BorderSizePixel = 0,
                            Size = UDim2.new(0, 3, 1, 0),
                            Visible = false,
                            ZIndex = 2,
                            Parent = Q,
                        })
                        if O < #N then
                            ag("Frame", {
                                Name = "Hairline",
                                BackgroundColor3 = ah.Foreground,
                                BackgroundTransparency = am,
                                BorderSizePixel = 0,
                                AnchorPoint = Vector2.new(0, 1),
                                Position = UDim2.fromScale(0, 1),
                                Size = UDim2.new(1, 0, 0, 1),
                                Parent = Q,
                            })
                        end
                        local T = { frame = Q, strip = R, bar = S, index = P.index }
                        Q.MouseEnter:Connect(function()
                            J(T, true)
                        end)
                        Q.MouseLeave:Connect(function()
                            J(T, false)
                        end)
                        Q.MouseButton1Click:Connect(function()
                            p.RowClicked:Fire(T.index, k[T.index])
                            if o then
                                if p.Selected == T.index then
                                    p:Select(nil)
                                else
                                    p:Select(T.index)
                                end
                            end
                        end)
                        table.insert(A, T)
                        J(T, false)
                    end
                    y.Visible = #k == 0
                    for O, P in ipairs(w:GetChildren()) do
                        P:Destroy()
                    end
                    v.Visible = l ~= nil
                    if l then
                        for O, P in ipairs(h) do
                            F(w, C(l, P), P, ac.Medium)
                        end
                    end
                    H()
                end
                local N, O, P, Q, R =
                    game:GetService("UserInputService"),
                    64,
                    TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    nil,
                    {}
                local function S(T, U)
                    R[T] = U
                    ab.Tween(T, {
                        CanvasPosition = U,
                    }, P)
                end
                local function T(U)
                    return R[U] or U.CanvasPosition
                end
                local function U()
                    if Q then
                        Q.ScrollingEnabled = true
                        Q = nil
                    end
                    t.ScrollingEnabled = true
                    table.clear(R)
                end
                local function V()
                    return t.AbsoluteCanvasSize.Y > t.AbsoluteWindowSize.Y + i / 2
                end
                local function W()
                    local X, Y = N:GetMouseLocation(), t:FindFirstAncestorWhichIsA("ScreenGui")
                    if not (Y and Y.IgnoreGuiInset) then
                        X -= game:GetService("GuiService"):GetGuiInset()
                    end
                    local Z, _ = t.AbsolutePosition, t.AbsoluteSize
                    return X.X >= Z.X and X.X <= Z.X + _.X and X.Y >= Z.Y and X.Y <= Z.Y + _.Y
                end
                e:Connect(t.MouseEnter, function()
                    if N.TouchEnabled and not N.MouseEnabled then
                        return
                    end
                    if not V() then
                        return
                    end
                    Q = q:FindFirstAncestorWhichIsA("ScrollingFrame")
                    if Q then
                        Q.ScrollingEnabled = false
                    end
                    t.ScrollingEnabled = false
                    table.clear(R)
                end)
                e:Connect(t.MouseLeave, U)
                e:Connect(q.AncestryChanged, U)
                e:Give(U)
                e:Connect(N.InputChanged, function(X)
                    if X.UserInputType ~= Enum.UserInputType.MouseWheel or t.ScrollingEnabled then
                        return
                    end
                    if not W() or not V() then
                        U()
                        return
                    end
                    local Y = -X.Position.Z * O
                    if N:IsKeyDown(Enum.KeyCode.LeftShift) or N:IsKeyDown(Enum.KeyCode.RightShift) then
                        local Z, _ = T(t), math.max(t.AbsoluteCanvasSize.X - t.AbsoluteWindowSize.X, 0)
                        S(t, Vector2.new(math.clamp(Z.X + Y, 0, _), Z.Y))
                        return
                    end
                    local Z, _ = T(t), math.max(t.AbsoluteCanvasSize.Y - t.AbsoluteWindowSize.Y, 0)
                    local ax = math.clamp(Z.Y + Y, 0, _)
                    if math.abs(ax - Z.Y) > 0.5 then
                        S(t, Vector2.new(Z.X, ax))
                        return
                    end
                    local ay = Q
                    if ay then
                        local az, aA = T(ay), math.max(ay.AbsoluteCanvasSize.Y - ay.AbsoluteWindowSize.Y, 0)
                        S(ay, Vector2.new(az.X, math.clamp(az.Y + Y, 0, aA)))
                    end
                end)
                e:Connect(t:GetPropertyChangedSignal("CanvasPosition"), function()
                    s.Position = UDim2.fromOffset(-t.CanvasPosition.X, 0)
                    w.Position = UDim2.fromOffset(-t.CanvasPosition.X, 0)
                end)
                local ax = false
                e:Connect(q:GetPropertyChangedSignal("AbsoluteSize"), function()
                    if ax then
                        return
                    end
                    ax = true
                    task.defer(function()
                        ax = false
                        if q.Parent then
                            H()
                        end
                    end)
                end)
                function p:SetRows(ay)
                    k = table.clone(ay or {})
                    p.Selected = nil
                    K()
                end
                function p:AddRow(ay)
                    table.insert(k, ay)
                    K()
                end
                function p:RemoveRow(ay)
                    if k[ay] == nil then
                        return
                    end
                    table.remove(k, ay)
                    if p.Selected == ay then
                        p.Selected = nil
                    elseif p.Selected and p.Selected > ay then
                        p.Selected -= 1
                    end
                    K()
                end
                function p:Clear()
                    p:SetRows({})
                end
                function p:GetRows()
                    return table.clone(k)
                end
                function p:SetFooter(ay)
                    l = ay
                    K()
                end
                function p:SetCaption(ay)
                    x.Text = ay or ""
                    x.Visible = (ay or "") ~= ""
                end
                function p:Sort(ay, az)
                    m = ay
                    n = az == true
                    I()
                    K()
                end
                function p:Select(ay)
                    if p.Selected == ay then
                        return
                    end
                    p.Selected = ay
                    for az, aA in ipairs(A) do
                        J(aA, false)
                    end
                    local az = nil
                    if ay then
                        az = k[ay]
                    end
                    p.SelectionChanged:Fire(ay, az)
                end
                L()
                p:SetRows(g.Rows or {})
                return p
            end
            return av
        end
        function a.p()
            local ab = a.cache.p
            if not ab then
                ab = { c = aa() }
                a.cache.p = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae, af, ag, ah, ai, aj, ak, al, am, an, ao, ap =
                game:GetService("UserInputService"),
                a.Theme(),
                a.Fonts(),
                a.Icons(),
                a.Creator(),
                a.g(),
                a.h(),
                a.m(),
                a.n(),
                a.i(),
                a.o(),
                a.p(),
                28,
                20,
                0.92
            local function aq()
                local ar = af.Stroke(ac.Token.Foreground)
                ar.Transparency = ap
                return ar
            end
            local ar, as, at, au, av, aw, ax, ay = af.Create, ac.Token, 10, 12, 0.5, 32, 16, 100
            local function az(aA)
                if not aA or aA == "" then
                    return 0
                end
                return math.ceil(af.TextWidth(aA, ac.TextSize.Title, ad.Regular)) + 2
            end
            local aA = {}
            aA.__index = aA
            function aA.new(b, c, d)
                local e, f =
                    ar("Frame", {
                        Name = "Section",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = d,
                        Parent = b._page,
                    }, { af.List(12) }), nil
                if c.Title or c.Description or c.Icon then
                    local g = ar("Frame", {
                        Name = "Header",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 0,
                        Parent = e,
                    }, {
                        af.Padding(0, 8, 0, 8),
                        ar("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 10),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    })
                    if c.Icon then
                        local h = ar("Frame", {
                            Name = "Leading",
                            BackgroundTransparency = 1,
                            Size = UDim2.fromOffset(an, an),
                            LayoutOrder = 1,
                            Parent = g,
                        })
                        ak.new(h, c.Icon, c.Title or "", ak.Color(c.Color, d), an, ao)
                    end
                    local h = ar("Frame", {
                        Name = "Text",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        Parent = g,
                    }, { af.List(2), ar("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) })
                    if c.Title then
                        af.Text({
                            Text = c.Title,
                            FontFace = ad.SemiBold,
                            TextSize = ac.TextSize.Title,
                            TextWrapped = true,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            LayoutOrder = 1,
                            Parent = h,
                        })
                    end
                    f = af.Text({
                        Name = "Description",
                        Text = c.Description or "",
                        Visible = (c.Description or "") ~= "",
                        RichText = true,
                        TextColor3 = as.MutedForeground,
                        TextSize = ac.TextSize.Sub,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        Parent = h,
                    })
                end
                local g = ar("Frame", {
                    Name = "Group",
                    BackgroundColor3 = as.Card,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 1,
                    Parent = e,
                }, { af.Corner(ac.Radius.Xl), aq() })
                local h = ar("Frame", {
                    Name = "Rows",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = g,
                }, { af.List(0) })
                return setmetatable(
                    {
                        Instance = e,
                        _window = b._window,
                        _maid = b._window._maid,
                        _group = h,
                        _order = 0,
                        _description = f,
                    },
                    aA
                )
            end
            function aA:SetDescription(b)
                local c = self._description
                if c then
                    c.Text = b or ""
                    c.Visible = c.Text ~= ""
                end
            end
            function aA:_row(b, c, d)
                self._order += 1
                local e = ar(if d then "TextButton" else "Frame", {
                    Name = b,
                    BackgroundColor3 = as.Accent,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = self._order,
                    Parent = self._group,
                }, {
                    ar("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 12),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                    af.Padding(at, au, at, au),
                })
                local f = ar("Folder", { Name = "Decor", Parent = e })
                if d then
                    e.Text = ""
                    e.AutoButtonColor = false
                    ar("Frame", {
                        Name = "Highlight",
                        BackgroundColor3 = as.Accent,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Position = UDim2.fromOffset(-au + 4, -at + 4),
                        Size = UDim2.new(1, au * 2 - 8, 1, at * 2 - 8),
                        ZIndex = 0,
                        Parent = f,
                    }, { af.Corner(ac.Radius.Lg) })
                end
                if self._order > 1 then
                    ar("Frame", {
                        Name = "Divider",
                        BackgroundColor3 = as.Foreground,
                        BackgroundTransparency = ap,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -at),
                        Size = UDim2.new(1, 0, 0, 1),
                        ZIndex = 2,
                        Parent = f,
                    })
                end
                local g = ar(
                    "Frame",
                    {
                        Name = "Left",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, az(c.Title), 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 1,
                        Parent = e,
                    },
                    {
                        af.List(2),
                        ar("UIFlexItem", { FlexMode = Enum.UIFlexMode.Custom, GrowRatio = 1, ShrinkRatio = 0.01 }),
                    }
                )
                local h, i, j =
                    af.Text({
                        Name = "Title",
                        Text = c.Title or "",
                        TextColor3 = if c.Muted then as.MutedForeground else as.Foreground,
                        TextSize = if c.Muted then ac.TextSize.Sub else ac.TextSize.Title,
                        TextWrapped = true,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 1,
                        Visible = (c.Title or "") ~= "",
                        Parent = g,
                    }), af.Text({
                        Name = "Description",
                        Text = c.Description or "",
                        TextColor3 = as.MutedForeground,
                        TextSize = ac.TextSize.Sub,
                        TextWrapped = true,
                        LineHeight = 1.1,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = 2,
                        Visible = (c.Description or "") ~= "",
                        Parent = g,
                    }), ar("Frame", {
                        Name = "Right",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(0, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.XY,
                        LayoutOrder = 2,
                        Parent = e,
                    }, {
                        ar("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    })
                return e, j, h, i
            end
            local b, c = 180, 12
            function aA:_fitRight(d, e, f, g, h)
                local i, j, k =
                    (d:FindFirstChildOfClass("UIListLayout")),
                    (e:FindFirstChildOfClass("UIListLayout")),
                    (d:FindFirstChild("Left"))
                local l, m = (k:FindFirstChildOfClass("UIFlexItem")), h == nil
                e.AutomaticSize = Enum.AutomaticSize.Y
                local function n()
                    local o, p = 0, 0
                    for q, r in ipairs(e:GetChildren()) do
                        if r:IsA("GuiObject") and r.Visible then
                            local s = r:GetAttribute("FitWidth")
                            if type(s) ~= "number" then
                                s = math.max(r.Size.X.Offset, r.AbsoluteSize.X)
                            end
                            o += s
                            p += 1
                        end
                    end
                    return o + math.max(p - 1, 0) * j.Padding.Offset
                end
                local function o()
                    local p, q, r = (d:FindFirstChildOfClass("UIPadding")), 1, d.Parent
                    while r do
                        local s = r:FindFirstChildOfClass("UIScale")
                        if s and s.Scale > 0 then
                            q *= s.Scale
                        end
                        r = r.Parent
                    end
                    local s = d.AbsoluteSize.X / q - p.PaddingLeft.Offset - p.PaddingRight.Offset
                    if s <= 0 then
                        return
                    end
                    local t = az(f.Text)
                    if g.Visible then
                        t = math.max(t, math.min(af.TextWidth(g.Text, ac.TextSize.Sub, ad.Regular), b))
                    end
                    local u, v = s - c - t, if m then n() else h
                    local w = if m then u < v else u < ay
                    i.FillDirection = if w then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal
                    i.Padding = UDim.new(0, if w then 8 else c)
                    l.Parent = if w then nil else k
                    k.Size = if w then UDim2.fromScale(1, 0) else UDim2.fromOffset(az(f.Text), 0)
                    if m then
                        j.Wraps = w
                        j.HorizontalAlignment = if w
                            then Enum.HorizontalAlignment.Left
                            else Enum.HorizontalAlignment.Right
                        e.Size = if w then UDim2.fromOffset(s, 0) else UDim2.fromOffset(v, 0)
                        for x, y in ipairs(e:GetChildren()) do
                            local z = y:GetAttribute("FitWidth")
                            if type(z) == "number" and y:IsA("GuiObject") then
                                local A = math.max(math.min(z, s), ay)
                                if y.Size.X.Offset ~= A then
                                    y.Size = UDim2.new(0, A, y.Size.Y.Scale, y.Size.Y.Offset)
                                end
                            end
                        end
                    else
                        e.Size = UDim2.fromOffset(if w then math.min(v, s) else math.min(v, u), 0)
                    end
                end
                local p, q, r = self._maid, false, 0.1
                local function s()
                    if q then
                        return
                    end
                    q = true
                    task.defer(function()
                        q = false
                        if d.Parent then
                            o()
                        end
                    end)
                    task.delay(r, function()
                        if d.Parent then
                            o()
                        end
                    end)
                end
                p:Connect(d:GetPropertyChangedSignal("AbsoluteSize"), s)
                p:Connect(f:GetPropertyChangedSignal("Text"), s)
                p:Connect(g:GetPropertyChangedSignal("Text"), s)
                if m then
                    local function t(u)
                        if u:IsA("GuiObject") then
                            p:Connect(u:GetPropertyChangedSignal("AbsoluteSize"), s)
                            p:Connect(u:GetPropertyChangedSignal("Visible"), s)
                        end
                    end
                    p:Connect(e.ChildAdded, function(u)
                        t(u)
                        s()
                    end)
                    for u, v in ipairs(e:GetChildren()) do
                        t(v)
                    end
                end
                s()
            end
            local function d(e, f)
                local g = (f:FindFirstChildOfClass("UIListLayout"))
                g.HorizontalAlignment = Enum.HorizontalAlignment.Left
                g.Wraps = true
                ((e:FindFirstChild("Left"))):Destroy()
                f.AutomaticSize = Enum.AutomaticSize.Y
                f.Size = UDim2.fromScale(1, 0)
            end
            function aA:_confirmed(e, f, g)
                if not e then
                    return g
                end
                return function()
                    local h = {}
                    if type(e) == "table" then
                        h = table.clone(e)
                    end
                    h.Title = h.Title or ((f or "Continue") .. "?")
                    if self._window:Confirm(h) then
                        g()
                    end
                end
            end
            function aA:_pressable(e, f, g)
                local h, i = self._maid, (((e:FindFirstChild("Decor"))):FindFirstChild("Highlight"))
                local function j(k, l)
                    ac.Tween(i, { BackgroundTransparency = k }, l)
                end
                h:Connect(e.MouseEnter, function()
                    if not g() then
                        j(0.5)
                    end
                end)
                h:Connect(e.MouseLeave, function()
                    j(1)
                end)
                h:Connect(e.MouseButton1Down, function()
                    if not g() then
                        j(0.2, TweenInfo.new(0.06))
                    end
                end)
                h:Connect(e.MouseButton1Up, function()
                    j(if g() then 1 else 0.5)
                end)
                h:Connect(e.MouseButton1Click, function()
                    if not g() then
                        f()
                    end
                end)
            end
            local function e(f, g, h, i, j)
                f.Instance = g
                f.Locked = false
                function f:SetVisible(k)
                    g.Visible = k
                end
                function f:Destroy()
                    if f.Changed then
                        f.Changed:Destroy()
                    end
                    g:Destroy()
                end
                if h then
                    function f:SetTitle(k)
                        h.Text = k
                        h.Visible = k ~= ""
                        local l = h.Parent
                        if l and l:IsA("GuiObject") then
                            l.Size = UDim2.new(0, az(k), 0, 0)
                        end
                    end
                end
                if i then
                    function f:SetDescription(k)
                        i.Text = k
                        i.Visible = k ~= ""
                    end
                end
                function f:SetLocked(k)
                    f.Locked = k == true
                    local l = if f.Locked then av else 0
                    for m, n in ipairs({ h, i }) do
                        if n then
                            ac.Tween(n, { TextTransparency = l })
                        end
                    end
                    local m = g:FindFirstChild("Decor") and g.Decor:FindFirstChild("Highlight")
                    if m and f.Locked then
                        ac.Tween(m, { BackgroundTransparency = 1 })
                    end
                    if j then
                        j(f.Locked)
                    end
                end
                return f
            end
            function aA:_value(f, g, h, i)
                local j, k = self._window, g.Flag
                f.Changed = self._maid:Give(ag.new())
                f.Value = h
                if k then
                    f.Value = j:GetFlag(k, h)
                    j.Controls[k] = f
                end
                i(f.Value, true)
                return function(l, m)
                    f.Value = l
                    i(l, false)
                    if k then
                        j:_saveFlag(k, l)
                    end
                    if not m then
                        if g.Callback then
                            task.spawn(g.Callback, l)
                        end
                        f.Changed:Fire(l)
                    end
                end
            end
            function aA:AddLabel(f)
                local g = if type(f) == "string" then { Text = f } else f
                local h, i, j = self:_row("Label", { Title = g.Text or "Label", Muted = g.Muted })
                local k = e({}, h, j)
                k.SetText = k.SetTitle
                return k
            end
            function aA:AddParagraph(f, g)
                local h = if type(f) == "string" then { Title = f, Content = g } else f
                local i, j, k, l = self:_row("Paragraph", { Title = h.Title, Description = h.Content })
                local m = e({}, i, k, l)
                m.SetContent = m.SetDescription
                return m
            end
            function aA:AddBadge(f, g, h)
                local i = if type(f) == "string" then { Title = f, Text = g, Variant = h } else f
                local j, k, l, m = self:_row("Badges", i)
                local n = i.Badges or { { Text = i.Text or i.Title, Variant = i.Variant } }
                if not i.Title then
                    d(j, k)
                end
                local o, p = {}, {}
                for q, r in ipairs(n) do
                    local s = table.clone(r)
                    s.LayoutOrder = q
                    local t, u, v = ai.new(s)
                    t.Parent = k
                    o[q] = u
                    p[q] = v
                end
                if i.Title then
                    self:_fitRight(j, k, l, m)
                end
                local q = e({}, j, l, m)
                function q:SetText(r, s)
                    o[s or 1](r)
                end
                function q:SetVariant(r, s)
                    p[s or 1](r)
                end
                return q
            end
            function aA:AddButton(f, g)
                local h, i = if type(f) == "string" then { Title = f, Callback = g } else f, self._maid
                if not h.Buttons and not (h.ButtonText or h.Variant or h.Icon or h.Size) then
                    local j, k, l, m = self:_row("Button", h, true)
                    local n, o =
                        ar("ImageLabel", {
                            Name = "Chevron",
                            BackgroundTransparency = 1,
                            Image = ae.Get("chevron-right") or "",
                            ImageColor3 = as.MutedForeground,
                            Size = UDim2.fromOffset(18, 18),
                            Parent = k,
                        }), nil
                    o = e({}, j, l, m, function(p)
                        n.Image = ae.Get(if p then "lock" else "chevron-right") or ""
                    end)
                    self:_pressable(j, function()
                        if h.Callback then
                            task.spawn(self:_confirmed(h.Confirm, h.Title, h.Callback))
                        end
                    end, function()
                        return o.Locked
                    end)
                    if h.Locked then
                        o:SetLocked(true)
                    end
                    return o
                end
                local j = h.Buttons == nil or h.Title ~= nil
                local k, l, m, n = self:_row("Buttons", if j then h else {})
                local o, p = h.Buttons or { h }, {}
                if not j then
                    d(k, l)
                end
                for q, r in ipairs(o) do
                    local s = table.clone(r)
                    s.LayoutOrder = q
                    s.Size = s.Size or "Sm"
                    if not h.Buttons then
                        s.Title = h.ButtonText or h.Title
                    end
                    local t = r.Confirm
                    if t == nil and not h.Buttons then
                        t = h.Confirm
                    end
                    if t and s.Callback then
                        s.Callback = self:_confirmed(t, s.Title or h.Title, s.Callback)
                    end
                    local u, v = ah.new(i, s)
                    u.Parent = l
                    p[q] = v
                end
                if j then
                    self:_fitRight(k, l, m, n)
                end
                local q = e({}, k, m, n)
                local r = q.SetLocked
                function q:SetButtonText(s, t)
                    p[t or 1].SetTitle(s)
                end
                function q:SetLocked(s, t)
                    if t then
                        p[t].SetLocked(s)
                        return
                    end
                    r(q, s)
                    for u, v in ipairs(p) do
                        v.SetLocked(s)
                    end
                end
                if h.Locked then
                    q:SetLocked(true)
                end
                return q
            end
            function aA:AddToggle(f, g, h)
                local i = if type(f) == "string" then { Title = f, Default = g, Callback = h } else f
                local j, k, l, m = self:_row("Toggle", i, true)
                local n = ar(
                    "Frame",
                    {
                        Name = "Switch",
                        BackgroundColor3 = as.Input,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(32, 18),
                        Parent = k,
                    },
                    { af.Corner(9) }
                )
                local o, p =
                    ar("Frame", {
                        Name = "Thumb",
                        BackgroundColor3 = as.SwitchThumb,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 2, 0.5, 0),
                        Size = UDim2.fromOffset(14, 14),
                        Parent = n,
                    }, { af.Corner(7) }), nil
                p = e({}, j, l, m, function(q)
                    local r = if q then av else 0
                    ac.Tween(n, { BackgroundTransparency = r })
                    ac.Tween(o, { BackgroundTransparency = r })
                end)
                local q, r =
                    self:_value(p, i, i.Default == true, function(q, r)
                        local s = if r then TweenInfo.new(0) else nil
                        ac.Rebind(n, "BackgroundColor3", if q then "Primary" else "Input")
                        ac.Rebind(o, "BackgroundColor3", if q then "PrimaryForeground" else "SwitchThumb")
                        ac.Tween(o, { Position = UDim2.new(0, if q then 16 else 2, 0.5, 0) }, s)
                    end), false
                local function s(t)
                    local u = i.Confirm
                    if not u then
                        return false
                    end
                    local v = "On"
                    if type(u) == "table" and u.When then
                        v = u.When
                    end
                    return v == "Both" or (v == "On" and t) or (v == "Off" and not t)
                end
                self:_pressable(j, function()
                    local t = not p.Value
                    if not s(t) then
                        q(t)
                        return
                    end
                    if r then
                        return
                    end
                    r = true
                    task.spawn(function()
                        local u = {}
                        if type(i.Confirm) == "table" then
                            u = table.clone(i.Confirm)
                        end
                        local v = "off"
                        if t then
                            v = "on"
                        end
                        u.Title = u.Title or ("Turn " .. (i.Title or "this") .. " " .. v .. "?")
                        u.ConfirmText = u.ConfirmText or ("Turn " .. v)
                        local w = self._window:Confirm(u)
                        r = false
                        if w and not p.Locked then
                            q(t)
                        end
                    end)
                end, function()
                    return p.Locked
                end)
                function p:Set(t, u)
                    q(t == true, u)
                end
                function p:Get()
                    return p.Value
                end
                if i.Locked then
                    p:SetLocked(true)
                end
                return p
            end
            function aA:AddSlider(f)
                local g = f
                local h, i, j, k = g.Min or 0, g.Max or 100, g.Step or 1, g.Suffix or ""
                local l, m, n, o, p = math.max(0, #(tostring(j):match("%.(%d+)$") or "")), self:_row("Slider", g);
                ((m:FindFirstChildOfClass("UIListLayout"))).Wraps = true
                local q, r =
                    ar("Frame", {
                        Name = "ValueField",
                        BackgroundColor3 = as.Input,
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.fromOffset(0, 28),
                        Parent = n,
                    }, {
                        af.Corner(ac.Radius.Lg),
                        af.Padding(0, 2, 0, 2),
                        ar("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 0),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    }), af.Stroke(as.Input)
                r.Parent = q
                local function s(t, u, v)
                    local w = ar("TextButton", {
                        Name = t,
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = as.Accent,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(24, 24),
                        LayoutOrder = v,
                        Parent = q,
                    }, { af.Corner(ac.Radius.Md) })
                    ar("ImageLabel", {
                        BackgroundTransparency = 1,
                        Image = ae.Get(u) or "",
                        ImageColor3 = as.MutedForeground,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(14, 14),
                        Parent = w,
                    })
                    self._maid:Connect(w.MouseEnter, function()
                        ac.Tween(w, { BackgroundTransparency = 0 })
                    end)
                    self._maid:Connect(w.MouseLeave, function()
                        ac.Tween(w, { BackgroundTransparency = 1 })
                    end)
                    return w
                end
                local function t(u)
                    ar("Frame", {
                        Name = "Hairline",
                        BackgroundColor3 = as.Foreground,
                        BackgroundTransparency = 0.88,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(1, 16),
                        LayoutOrder = u,
                        Parent = q,
                    })
                end
                local u = s("Decrease", "minus", 1)
                t(2)
                local v = ar("TextBox", {
                    Name = "Value",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ClearTextOnFocus = false,
                    FontFace = ad.Medium,
                    TextSize = ac.TextSize.Sub,
                    TextColor3 = as.Foreground,
                    RichText = true,
                    Text = "",
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(40, 24),
                    LayoutOrder = 3,
                    Parent = q,
                }, { af.Padding(0, 8, 0, 8), ar("UISizeConstraint", { MinSize = Vector2.new(40, 24) }) })
                t(4)
                local w, x =
                    s("Increase", "plus", 5), ar("Frame", {
                        Name = "Halo",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, -5, 0, -3),
                        Size = UDim2.new(1, 10, 1, 6),
                        ZIndex = 0,
                        Parent = ar("Folder", { Name = "Decor", Parent = q }),
                    }, { af.Corner(ac.Radius.Lg + 3) })
                local y = ar(
                    "UIStroke",
                    {
                        Color = as.Ring,
                        Thickness = 3,
                        Transparency = 1,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Parent = x,
                    }
                )
                local function z(A)
                    local B = string.format("%." .. l .. "f", A)
                    if k == "" then
                        return B
                    end
                    local C = ac.Color("MutedForeground"):ToHex()
                    return B .. '<font color="#' .. C .. '">' .. k .. "</font>"
                end
                local A, B = g.Bar ~= false, g.Steppers ~= false
                if not B then
                    for C, D in ipairs(q:GetChildren()) do
                        if D.Name == "Hairline" or D == u or D == w then
                            (D).Visible = false
                        end
                    end
                    v.Size = UDim2.fromOffset(56, 24)
                end
                local C = ar("TextButton", {
                    Name = "Track",
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 18),
                    LayoutOrder = 3,
                    Visible = A,
                    Parent = m,
                })
                local D = ar("Frame", {
                    Name = "Bar",
                    BackgroundColor3 = as.Muted,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.new(1, 0, 0, 6),
                    Parent = C,
                }, { af.Corner(3) })
                local E, F =
                    ar("Frame", {
                        Name = "Range",
                        BackgroundColor3 = as.Primary,
                        BorderSizePixel = 0,
                        Size = UDim2.fromScale(0, 1),
                        Parent = D,
                    }, { af.Corner(3) }), ar("Frame", {
                        Name = "Thumb",
                        BackgroundColor3 = as.SwitchThumb,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0, 0.5),
                        Size = UDim2.fromOffset(ax, ax),
                        ZIndex = 2,
                        Parent = D,
                    }, { af.Corner(ax), af.Stroke(as.Primary, 2) })
                local G = ar("Frame", {
                    Name = "Bubble",
                    BackgroundColor3 = as.Primary,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 0, -8),
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 22),
                    ZIndex = 5,
                    Parent = F,
                }, { af.Corner(ac.Radius.Md), af.Padding(0, 8, 0, 8) })
                local H, I =
                    af.Text({
                        Name = "Text",
                        Text = "",
                        TextColor3 = as.PrimaryForeground,
                        FontFace = ad.Medium,
                        TextSize = ac.TextSize.Xs,
                        TextTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.fromOffset(0, 22),
                        ZIndex = 6,
                        Parent = G,
                    }), ar("Frame", {
                        Name = "Pointer",
                        BackgroundColor3 = as.Primary,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 1, 0),
                        Rotation = 45,
                        Size = UDim2.fromOffset(7, 7),
                        ZIndex = 5,
                        Parent = G,
                    })
                local function J(K)
                    local L = 1
                    if K then
                        L = 0
                    end
                    ac.Tween(G, { BackgroundTransparency = L })
                    ac.Tween(I, {
                        BackgroundTransparency = L,
                    })
                    ac.Tween(H, { TextTransparency = L })
                end
                local function K(L)
                    return UDim2.new(L, (0.5 - L) * ax, 0.5, 0)
                end
                local function L(M)
                    local N = h + math.floor((M - h) / j + 0.5) * j
                    return math.clamp((tonumber(string.format("%." .. l .. "f", N))), h, i)
                end
                local M, N = nil, false
                M = e({}, m, o, p, function(O)
                    local P = if O then av else 0
                    for Q, R in ipairs({ D, E, F }) do
                        ac.Tween(R, { BackgroundTransparency = P })
                    end
                    ac.Tween(v, { TextTransparency = P })
                    ac.Tween(q, { BackgroundTransparency = 0.7 + 0.3 * P })
                    u.Visible = B and not O
                    w.Visible = B and not O
                    v.TextEditable = not O
                    if O then
                        v:ReleaseFocus()
                    end
                end)
                M.Released = self._maid:Give(ag.new())
                local O = self:_value(M, g, L(g.Default or h), function(O)
                    local P = if i > h then (O - h) / (i - h) else 0
                    local Q = K(P)
                    E.Size = UDim2.new(Q.X.Scale, Q.X.Offset, 1, 0)
                    F.Position = Q
                    if not v:IsFocused() then
                        v.Text = z(O)
                    end
                    H.Text = string.format("%." .. l .. "f", O) .. k
                end)
                self._maid:Connect(v.Focused, function()
                    ac.Rebind(r, "Color", "Ring")
                    ac.Tween(y, { Transparency = 0.5 })
                    v.RichText = false
                    v.Text = string.format("%." .. l .. "f", M.Value)
                    v.CursorPosition = #v.Text + 1
                end)
                self._maid:Connect(v.FocusLost, function()
                    ac.Rebind(r, "Color", "Input")
                    ac.Tween(y, { Transparency = 1 })
                    local P, Q = tonumber((v.Text:gsub("[^%d%.%-]", ""))), M.Value
                    if P then
                        Q = math.clamp((tonumber(string.format("%." .. l .. "f", P))), h, i)
                    end
                    v.RichText = true
                    v.Text = z(Q)
                    if Q ~= M.Value then
                        O(Q)
                        M.Released:Fire(Q)
                    end
                end)
                C.NextSelectionLeft = C
                C.NextSelectionRight = C
                self._maid:Connect(ab.InputBegan, function(P)
                    if M.Locked or game:GetService("GuiService").SelectedObject ~= C then
                        return
                    end
                    local Q = 0
                    if P.KeyCode == Enum.KeyCode.DPadLeft then
                        Q = -1
                    elseif P.KeyCode == Enum.KeyCode.DPadRight then
                        Q = 1
                    end
                    if Q ~= 0 then
                        local R = L(M.Value + j * Q)
                        if R ~= M.Value then
                            O(R)
                            M.Released:Fire(R)
                        end
                    end
                end)
                for P, Q in ipairs({ { u, -1 }, {
                    w,
                    1,
                } }) do
                    self._maid:Connect(Q[1].MouseButton1Click, function()
                        if M.Locked then
                            return
                        end
                        local R = L(M.Value + j * Q[2])
                        if R ~= M.Value then
                            O(R)
                            M.Released:Fire(R)
                        end
                    end)
                end
                local function P(Q)
                    local R, S = D.AbsolutePosition.X + ax / 2, math.max(D.AbsoluteSize.X - ax, 1)
                    local T = math.clamp((Q.X - R) / S, 0, 1)
                    local U = L(h + T * (i - h))
                    if U ~= M.Value then
                        O(U)
                    end
                end
                self._maid:Connect(C.InputBegan, function(Q)
                    if M.Locked then
                        return
                    end
                    local R = Q.UserInputType == Enum.UserInputType.MouseButton1
                        or Q.UserInputType == Enum.UserInputType.Touch
                    if not R then
                        return
                    end
                    self._window:_drag(Q, P, function()
                        M.Released:Fire(M.Value)
                    end)
                    N = true
                    J(true)
                    ac.Tween(F, { Size = UDim2.fromOffset(ax + 2, ax + 2) })
                end)
                self._maid:Connect(ab.InputEnded, function(Q)
                    if
                        N
                        and (
                            Q.UserInputType == Enum.UserInputType.MouseButton1
                            or Q.UserInputType == Enum.UserInputType.Touch
                        )
                    then
                        N = false
                        J(false)
                        ac.Tween(F, { Size = UDim2.fromOffset(ax, ax) })
                    end
                end)
                function M:Set(Q, R)
                    O(L(Q), R)
                end
                function M:Get()
                    return M.Value
                end
                if g.Locked then
                    M:SetLocked(true)
                end
                return M
            end
            function aA:AddInput(f)
                local g, h = f, self._maid
                local i, j, k, l = self:_row("Input", g)
                local m, n, o = nil, 0, nil
                if g.Button then
                    local p = g.Button
                    o = ah.new(h, {
                        Title = p.Title or "OK",
                        Icon = p.Icon,
                        Variant = p.Variant or "Default",
                        Size = "Sm",
                        LayoutOrder = 2,
                        Callback = function()
                            if p.Callback then
                                p.Callback(m.Text)
                            end
                        end,
                    })
                    o.Parent = j
                    n = o.Size.X.Offset + 8
                end
                self:_fitRight(i, j, k, l, (g.Width or 180) + n)
                local p, q =
                    ar("Frame", {
                        Name = "Field",
                        BackgroundColor3 = as.Input,
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0,
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 0, aw),
                        Parent = j,
                    }, { af.Corner(ac.Radius.Lg) }), af.Stroke(as.Input)
                q.Parent = p
                if o then
                    ar("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = p })
                end
                local r = ar("Frame", {
                    Name = "Halo",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(-3, -3),
                    Size = UDim2.new(1, 6, 1, 6),
                    ZIndex = 0,
                    Parent = p,
                }, { af.Corner(ac.Radius.Lg + 3) })
                local s, t, u, v =
                    ar("UIStroke", {
                        Color = as.Ring,
                        Thickness = 3,
                        Transparency = 1,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Parent = r,
                    }), 10, 10, ae.Get(g.Icon)
                if v and not g.Numeric then
                    ar("ImageLabel", {
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Image = v,
                        ImageColor3 = as.MutedForeground,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 9, 0.5, 0),
                        Size = UDim2.fromOffset(16, 16),
                        Parent = p,
                    })
                    t = 32
                end
                local w = ar("Frame", {
                    Name = "Controls",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -4, 0.5, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 24),
                    ZIndex = 2,
                    Parent = p,
                }, {
                    ar("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 2),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                local function x(y, z, A)
                    local B = ar("TextButton", {
                        Name = y,
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = as.Accent,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(24, 24),
                        LayoutOrder = A,
                        ZIndex = 2,
                        Parent = w,
                    }, { af.Corner(ac.Radius.Md) })
                    ar("ImageLabel", {
                        BackgroundTransparency = 1,
                        Image = ae.Get(z) or "",
                        ImageColor3 = as.MutedForeground,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(14, 14),
                        ZIndex = 3,
                        Parent = B,
                    })
                    h:Connect(B.MouseEnter, function()
                        ac.Tween(B, { BackgroundTransparency = 0 })
                    end)
                    h:Connect(B.MouseLeave, function()
                        ac.Tween(B, { BackgroundTransparency = 1 })
                    end)
                    return B
                end
                local y, z, A
                if g.Numeric then
                    y = x("Decrease", "minus", 1)
                    z = x("Increase", "plus", 2)
                    y.Parent = p
                    y.AnchorPoint = Vector2.new(0, 0.5)
                    y.Position = UDim2.new(0, 4, 0.5, 0)
                    for B, C in ipairs({
                        { 0, 32 },
                        { 1, -33 },
                    }) do
                        ar("Frame", {
                            Name = "Hairline",
                            BackgroundColor3 = as.Foreground,
                            BackgroundTransparency = 0.88,
                            BorderSizePixel = 0,
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(C[1], C[2], 0.5, 0),
                            Size = UDim2.new(0, 1, 1, -12),
                            Parent = p,
                        })
                    end
                    t = 34
                    u = 34
                elseif g.Clearable ~= false then
                    A = x("Clear", "x", 1)
                    A.Visible = false
                    u = 34
                end
                m = ar("TextBox", {
                    Name = "Box",
                    BackgroundTransparency = 1,
                    ClearTextOnFocus = false,
                    FontFace = ad.Regular,
                    TextSize = ac.TextSize.Sm,
                    TextColor3 = as.Foreground,
                    PlaceholderColor3 = as.MutedForeground,
                    PlaceholderText = g.Placeholder or "",
                    Text = "",
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Position = UDim2.fromOffset(t, 0),
                    Size = UDim2.new(1, -(t + u), 1, 0),
                    Parent = p,
                })
                if g.Numeric then
                    m.TextXAlignment = Enum.TextXAlignment.Center
                    m.FontFace = ad.Medium
                end
                local B
                B = e({}, i, k, l, function(C)
                    m.TextEditable = not C
                    local D = 0
                    if C then
                        D = av
                    end
                    ac.Tween(m, { TextTransparency = D })
                    ac.Tween(p, { BackgroundTransparency = 0.7 + 0.3 * D })
                    w.Visible = not C
                    if y then
                        y.Visible = not C
                    end
                    if C then
                        m:ReleaseFocus()
                    end
                end)
                local function C(D)
                    if g.Numeric then
                        return tonumber(D)
                    end
                    return D
                end
                local D = self:_value(B, g, g.Default or (if g.Numeric then nil else ""), function(D)
                    m.Text = if D == nil then "" else tostring(D)
                end)
                self._maid:Connect(m:GetPropertyChangedSignal("Text"), function()
                    if g.Numeric then
                        local E = m.Text:gsub("[^%d%.%-]", ""):gsub("(.)%-", "%1")
                        local F = E:find(".", 1, true)
                        if F then
                            E = E:sub(1, F) .. E:sub(F + 1):gsub("%.", "")
                        end
                        if E ~= m.Text then
                            m.Text = E
                            return
                        end
                    end
                    if g.Live and m:IsFocused() then
                        D(C(m.Text))
                    end
                end)
                self._maid:Connect(m.Focused, function()
                    ac.Rebind(q, "Color", "Ring")
                    ac.Tween(s, { Transparency = 0.5 })
                end)
                self._maid:Connect(m.FocusLost, function(E)
                    ac.Rebind(q, "Color", "Input")
                    ac.Tween(s, {
                        Transparency = 1,
                    })
                    local F = C(m.Text)
                    if F ~= B.Value then
                        D(F)
                    end
                    if E and g.Button and g.Button.Callback and not B.Locked then
                        task.spawn(g.Button.Callback, m.Text)
                    end
                end)
                if A then
                    local function E()
                        A.Visible = m.Text ~= "" and not B.Locked
                    end
                    h:Connect(m:GetPropertyChangedSignal("Text"), E)
                    E()
                    h:Connect(A.MouseButton1Click, function()
                        if B.Locked then
                            return
                        end
                        m.Text = ""
                        D(C(""))
                    end)
                end
                if y and z then
                    local E = g.Step or 1
                    local function F(G)
                        if B.Locked then
                            return
                        end
                        local H = (tonumber(m.Text) or 0) + E * G
                        if g.Min then
                            H = math.max(H, g.Min)
                        end
                        if g.Max then
                            H = math.min(H, g.Max)
                        end
                        local I = #(string.match(tostring(E), "%.(%d+)$") or "")
                        H = (tonumber(string.format("%." .. I .. "f", H)))
                        m.Text = tostring(H)
                        D(H)
                    end
                    h:Connect(y.MouseButton1Click, function()
                        F(-1)
                    end)
                    h:Connect(z.MouseButton1Click, function()
                        F(1)
                    end)
                end
                function B:Set(E, F)
                    D(E, F)
                end
                function B:Get()
                    return B.Value
                end
                if g.Locked then
                    B:SetLocked(true)
                end
                return B
            end
            function aA:AddColorPicker(f)
                local g, h = f, self._window
                local i, j, k, l = self:_row("ColorPicker", g)
                self:_fitRight(i, j, k, l, g.Width or 112)
                local m, n = type(g.Transparency) == "number", nil
                if g.Flag then
                    n = g.Flag .. "Transparency"
                end
                local o = g.Default
                if type(o) == "string" then
                    o = al.Parse(o)
                end
                if typeof(o) ~= "Color3" then
                    o = Color3.fromHex("0a84ff")
                end
                local p, q = nil, nil
                q = e({}, i, k, l, function(r)
                    if p then
                        p.SetLocked(r)
                    end
                end)
                q.Transparency = g.Transparency or 0
                if n then
                    q.Transparency = h:GetFlag(n, q.Transparency)
                end
                local r = self:_value(
                    q,
                    {
                        Flag = g.Flag,
                        Callback = function(r)
                            if g.Callback then
                                g.Callback(r, q.Transparency)
                            end
                        end,
                    },
                    o,
                    function()
                        if p then
                            p.Refresh()
                        end
                    end
                )
                local function s(t, u, v)
                    q.Transparency = u
                    if n then
                        h:_saveFlag(n, u)
                    end
                    r(t, v)
                end
                p = al.new(h, self._maid, j, q, m, function(t, u, v)
                    if g.Live == false and not v then
                        q.Value = t
                        q.Transparency = u
                        return
                    end
                    s(t, u)
                end, { color = o, transparency = g.Transparency or 0 })
                p.Refresh()
                function q:Reset()
                    s(o, g.Transparency or 0)
                end
                function q:Set(t, u, v)
                    local w, x = t, nil
                    if type(t) == "string" then
                        w, x = al.Parse(t)
                    end
                    if typeof(w) ~= "Color3" then
                        return
                    end
                    s(w, u or x or q.Transparency, v)
                end
                function q:Get()
                    return q.Value, q.Transparency
                end
                if g.Locked then
                    q:SetLocked(true)
                end
                return q
            end
            function aA:AddTable(f)
                self._order += 1
                local g = ar("Frame", {
                    Name = "Table",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = self._order,
                    Parent = self._group,
                }, { af.Padding(4, 4, 4, 4) })
                if self._order > 1 then
                    ar("Frame", {
                        Name = "Divider",
                        BackgroundColor3 = as.Foreground,
                        BackgroundTransparency = ap,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 1),
                        Position = UDim2.fromOffset(0, -4),
                        Parent = ar("Folder", { Parent = g }),
                    })
                end
                local h = am.new(self._maid, g, f)
                function h:SetVisible(i)
                    g.Visible = i
                end
                function h:Destroy()
                    g:Destroy()
                end
                return h
            end
            function aA:AddDropdown(f)
                local g = f
                local h, i, j, k, l = g.Multi == true, self:_row("Dropdown", g)
                self:_fitRight(i, j, k, l, g.Width or 200)
                local m, n = nil, nil
                n = e({}, i, k, l, function(o)
                    if m then
                        m.SetLocked(o)
                    end
                end)
                local o = g.Default
                if h and o == nil then
                    o = {}
                end
                local p = self:_value(n, g, o, function()
                    if m then
                        m.Refresh()
                    end
                end)
                m = aj.new(self._window, self._maid, j, g, n, function(q)
                    p(q)
                end)
                m.Refresh()
                function n:Set(q, r)
                    p(q, r)
                end
                function n:Get()
                    return n.Value
                end
                function n:SetOptions(q)
                    m.SetOptions(q)
                    local r = m.Choices()
                    if h then
                        local s = {}
                        for t, u in ipairs(n.Value or {}) do
                            if table.find(r, u) then
                                table.insert(s, u)
                            end
                        end
                        p(s, true)
                    elseif n.Value ~= nil and not table.find(r, n.Value) then
                        p(nil, true)
                    end
                end
                if g.Locked then
                    n:SetLocked(true)
                end
                return n
            end
            local f = {
                MouseButton1 = "Mouse 1",
                MouseButton2 = "Mouse 2",
                MouseButton3 = "Mouse 3",
                LeftShift = "L Shift",
                RightShift = "R Shift",
                LeftControl = "L Ctrl",
                RightControl = "R Ctrl",
                LeftAlt = "L Alt",
                RightAlt = "R Alt",
                Return = "Enter",
                Backspace = "Backspace",
                Backquote = "`",
                Space = "Space",
                CapsLock = "Caps",
                PageUp = "Pg Up",
                PageDown = "Pg Down",
                One = "1",
                Two = "2",
                Three = "3",
                Four = "4",
                Five = "5",
                Six = "6",
                Seven = "7",
                Eight = "8",
                Nine = "9",
                Zero = "0",
                Minus = "-",
                Equals = "=",
                LeftBracket = "[",
                RightBracket = "]",
                Semicolon = ";",
                Quote = "'",
                Comma = ",",
                Period = ".",
                Slash = "/",
                BackSlash = "\\",
            }
            local function g(h)
                if not h then
                    return "None"
                end
                return f[h] or h
            end
            local h = { MouseButton2 = true, MouseButton3 = true }
            local function i(j)
                if j.UserInputType == Enum.UserInputType.Keyboard and j.KeyCode ~= Enum.KeyCode.Unknown then
                    return j.KeyCode.Name
                end
                local k = j.UserInputType.Name
                return if h[k] or k == "MouseButton1" then k else nil
            end
            function aA:AddKeybind(j, k, l)
                local m = if type(j) == "string" then { Title = j, Default = k, Callback = l } else j
                local n, o, p, q, r, s, t = m.Mode or "Press", self._window, self._maid, self:_row("Keybind", m)
                local u, v = 28, 2
                if n ~= "Press" then
                    local w = af.Text({
                        Name = "Mode",
                        Text = n,
                        TextColor3 = as.MutedForeground,
                        FontFace = ad.Medium,
                        TextSize = ac.TextSize.Xs,
                        BackgroundColor3 = as.Muted,
                        BackgroundTransparency = 0,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.fromOffset(0, 20),
                        LayoutOrder = 1,
                        Parent = r,
                    })
                    ar("UICorner", { CornerRadius = UDim.new(1, 0), Parent = w })
                    af.Padding(0, 8, 0, 8).Parent = w
                end
                local w = ar("TextButton", {
                    Name = "Key",
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(64, u + v),
                    LayoutOrder = 2,
                    Parent = r,
                })
                local x, y, z =
                    ar("Frame", {
                        Name = "Base",
                        BackgroundColor3 = as.Border,
                        BorderSizePixel = 0,
                        Position = UDim2.fromOffset(0, v),
                        Size = UDim2.new(1, 0, 0, u),
                        Parent = w,
                    }, { af.Corner(ac.Radius.Md) }), ar("TextLabel", {
                        Name = "Cap",
                        BackgroundColor3 = as.Card,
                        BorderSizePixel = 0,
                        FontFace = ad.Medium,
                        TextSize = ac.TextSize.Sub,
                        TextColor3 = as.Foreground,
                        Text = "",
                        Size = UDim2.new(1, 0, 0, u),
                        ZIndex = 2,
                        Parent = w,
                    }, { af.Corner(ac.Radius.Md) }), af.Stroke(as.Input)
                z.Parent = y
                local A, B, C, D = nil, false, nil, nil
                A = e({ Active = false }, q, s, t, function(E)
                    local F = 0
                    if E then
                        F = av
                    end
                    ac.Tween(y, { TextTransparency = F, BackgroundTransparency = F })
                    ac.Tween(x, {
                        BackgroundTransparency = F,
                    })
                    if E and A.Active then
                        A.Active = false
                        D(false)
                    end
                end)
                A.Pressed = p:Give(ag.new())
                A.Released = p:Give(ag.new())
                local function E(F)
                    y.Text = F
                    w.Size = UDim2.fromOffset(math.max(44, af.TextWidth(F, ac.TextSize.Sub, ad.Medium) + 24), u + v)
                end
                D = function(F)
                    if F then
                        ac.Rebind(y, "BackgroundColor3", "Primary")
                        ac.Rebind(y, "TextColor3", "PrimaryForeground")
                        ac.Rebind(z, "Color", "Primary")
                        ac.Tween(y, { Position = UDim2.fromOffset(0, v) })
                    else
                        ac.Rebind(y, "BackgroundColor3", "Card")
                        ac.Rebind(y, "TextColor3", "Foreground")
                        ac.Rebind(z, "Color", "Input")
                        ac.Tween(y, { Position = UDim2.fromOffset(0, 0) })
                    end
                end
                local function normalizeKey(value)
                    if typeof(value) == "EnumItem" then
                        return value.Name
                    end
                    return value
                end
                local setValue = self:_value(A, { Flag = m.Flag }, normalizeKey(m.Default), function(value)
                    A.Value = normalizeKey(value)
                    E(g(A.Value))
                end)
                local function F(value, silent)
                    setValue(normalizeKey(value), silent)
                end
                local function G(H, I)
                    B = false
                    if C then
                        C:Cancel()
                        C = nil
                    end
                    y.TextTransparency = 0
                    ac.Rebind(y, "TextColor3", "Foreground")
                    ac.Rebind(z, "Color", "Input")
                    if H or I then
                        F(H)
                    else
                        E(g(A.Value))
                    end
                end
                local function H()
                    if A.Locked or B then
                        return
                    end
                    task.defer(function()
                        B = true
                        D(false)
                        E("Press a key")
                        ac.Rebind(y, "TextColor3", "MutedForeground")
                        ac.Rebind(z, "Color", "Ring")
                        C = ac.Tween(
                            y,
                            { TextTransparency = 0.6 },
                            TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
                        )
                    end)
                end
                p:Connect(w.MouseButton1Click, H)
                local I = ar("TextButton", {
                    Name = "Options",
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundColor3 = as.Accent,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.fromOffset(26, 26),
                    LayoutOrder = 3,
                    Parent = r,
                }, { af.Corner(ac.Radius.Md) })
                ar("ImageLabel", {
                    BackgroundTransparency = 1,
                    Image = ae.Get("ellipsis") or "",
                    ImageColor3 = as.MutedForeground,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(18, 18),
                    Parent = I,
                })
                p:Connect(I.MouseEnter, function()
                    ac.Tween(I, { BackgroundTransparency = 0 })
                end)
                p:Connect(I.MouseLeave, function()
                    ac.Tween(I, { BackgroundTransparency = 1 })
                end)
                local function J(K)
                    if A.Locked then
                        return
                    end
                    if B then
                        G()
                    end
                    local L, M = m.Default, "Reset to default"
                    if L then
                        M = "Reset to " .. g(L)
                    end
                    local N = o:_menu({
                        {
                            Title = "Change key",
                            Icon = "keyboard",
                            Callback = H,
                        },
                        {
                            Title = M,
                            Icon = "rotate-ccw",
                            Disabled = A.Value == L,
                            Callback = function()
                                A:Reset()
                            end,
                        },
                        false,
                        {
                            Title = "Clear",
                            Icon = "trash-2",
                            Destructive = true,
                            Disabled = A.Value == nil,
                            Callback = function()
                                A:Clear()
                            end,
                        },
                    })
                    N.Size = UDim2.fromOffset(200, 0)
                    o:_openPopover(N, K, function()
                        N:Destroy()
                    end)
                end
                p:Connect(I.MouseButton1Click, function()
                    J(I)
                end)
                p:Connect(w.MouseButton2Click, function()
                    J(w)
                end)
                local function K(...)
                    if m.Callback then
                        task.spawn(m.Callback, ...)
                    end
                end
                local L = {
                    began = function(L, M)
                        local N = i(L)
                        if not N then
                            return
                        end
                        if B then
                            if L.KeyCode == Enum.KeyCode.Escape or N == "MouseButton1" then
                                G()
                            elseif L.KeyCode == Enum.KeyCode.Backspace then
                                G(nil, true)
                            else
                                G(N)
                            end
                            return
                        end
                        if A.Locked or N ~= A.Value or (M and not h[N]) then
                            return
                        end
                        if n == "Toggle" then
                            A.Active = not A.Active
                            D(A.Active)
                            K(A.Active)
                        elseif n == "Hold" then
                            A.Active = true
                            D(true)
                            K(true)
                        else
                            D(true)
                            task.delay(0.15, function()
                                if not B then
                                    D(false)
                                end
                            end)
                            K()
                        end
                        A.Pressed:Fire()
                    end,
                    ended = function(L)
                        if B or i(L) ~= A.Value or A.Value == nil then
                            return
                        end
                        if n == "Hold" and A.Active then
                            A.Active = false
                            D(false)
                            K(false)
                        end
                        A.Released:Fire()
                    end,
                }
                table.insert(o._keybinds, L)
                local M = A.Destroy
                function A:Destroy()
                    local N = table.find(o._keybinds, L)
                    if N then
                        table.remove(o._keybinds, N)
                    end
                    M(A)
                end
                function A:Set(N, O)
                    F(N, O)
                end
                function A:Reset()
                    F(m.Default)
                end
                function A:Clear()
                    if A.Active then
                        A.Active = false
                        D(false)
                        K(false)
                    end
                    F(nil)
                end
                function A:Get()
                    return A.Value
                end
                self:_fitRight(q, r, s, t)
                if m.Locked then
                    A:SetLocked(true)
                end
                return A
            end
            function aA:AddRow(j)
                local k, l, m = j or {}, self._window, self._maid
                local n, o, p, q = self:_row("Row", { Title = k.Title or "", Description = k.Description })
                local r, s = {}, 0
                local t = e({}, n, p, q, function(t)
                    for u, v in ipairs(r) do
                        if v.SetLocked then
                            v:SetLocked(t)
                        end
                    end
                end)
                self:_fitRight(n, o, p, q)
                local function u()
                    s += 1
                    return s
                end
                local function v(w)
                    table.insert(r, w)
                    if t.Locked and w.SetLocked then
                        w:SetLocked(true)
                    end
                    return w
                end
                local function w(x, ...)
                    if x then
                        task.spawn(x, ...)
                    end
                end
                function t:Toggle(x)
                    local y, z, A =
                        x.Value == true, { Locked = false }, ar("TextButton", {
                            Name = "Switch",
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundColor3 = as.Input,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(32, 18),
                            LayoutOrder = u(),
                            Parent = o,
                        }, { af.Corner(9) })
                    local B = ar("Frame", {
                        Name = "Thumb",
                        BackgroundColor3 = as.SwitchThumb,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 2, 0.5, 0),
                        Size = UDim2.fromOffset(14, 14),
                        Parent = A,
                    }, { af.Corner(7) })
                    local function C(D)
                        local E = nil
                        if D then
                            E = TweenInfo.new(0)
                        end
                        local F = 2
                        if y then
                            F = 16
                            ac.Rebind(A, "BackgroundColor3", "Primary")
                            ac.Rebind(B, "BackgroundColor3", "PrimaryForeground")
                        else
                            ac.Rebind(A, "BackgroundColor3", "Input")
                            ac.Rebind(B, "BackgroundColor3", "SwitchThumb")
                        end
                        ac.Tween(B, { Position = UDim2.new(0, F, 0.5, 0) }, E)
                    end
                    function z:Set(D, E)
                        y = D == true
                        z.Value = y
                        C()
                        if not E then
                            w(x.Callback, y)
                        end
                    end
                    function z:Get()
                        return y
                    end
                    function z:SetLocked(D)
                        z.Locked = D
                        local E = 0
                        if D then
                            E = av
                        end
                        ac.Tween(A, { BackgroundTransparency = E })
                        ac.Tween(B, { BackgroundTransparency = E })
                    end
                    m:Connect(A.MouseButton1Click, function()
                        if not z.Locked and not t.Locked then
                            z:Set(not y)
                        end
                    end)
                    m:Connect(n.InputBegan, function(D)
                        if
                            D.UserInputType ~= Enum.UserInputType.MouseButton1
                            and D.UserInputType ~= Enum.UserInputType.Touch
                        then
                            return
                        end
                        if #r ~= 1 or r[1] ~= z or z.Locked or t.Locked then
                            return
                        end
                        local E, F, G = Vector2.new(D.Position.X, D.Position.Y), A.AbsolutePosition, A.AbsoluteSize
                        if E.X >= F.X and E.X <= F.X + G.X and E.Y >= F.Y and E.Y <= F.Y + G.Y then
                            return
                        end
                        z:Set(not y)
                    end)
                    z.Value = y
                    z.Instance = A
                    C(true)
                    return v(z)
                end
                function t:Button(x)
                    local y, z = ah.new(m, {
                        Title = x.Title,
                        Icon = x.Icon,
                        Variant = x.Variant or "Default",
                        Size = x.Size or "Sm",
                        LayoutOrder = u(),
                        Callback = x.Callback,
                    })
                    y.Parent = o
                    local A = {
                        Instance = y,
                        SetTitle = function(A, B)
                            z.SetTitle(B)
                        end,
                        SetLocked = function(A, B)
                            z.SetLocked(B)
                        end,
                    }
                    return v(A)
                end
                function t:Label(x)
                    local y = x
                    if type(x) == "table" then
                        y = x.Text or ""
                    end
                    local z = af.Text({
                        Name = "Value",
                        Text = tostring(y),
                        TextColor3 = as.MutedForeground,
                        TextXAlignment = Enum.TextXAlignment.Right,
                        Size = UDim2.fromOffset(0, 20),
                        LayoutOrder = u(),
                        Parent = o,
                    })
                    local A = { Instance = z }
                    function A:SetText(B)
                        z.Text = tostring(B)
                        z.Size = UDim2.fromOffset(math.ceil(af.TextWidth(z.Text, ac.TextSize.Sm, ad.Regular)) + 2, 20)
                    end
                    function A:Get()
                        return z.Text
                    end
                    A:SetText(tostring(y))
                    return v(A)
                end
                function t:Dropdown(x)
                    local y = ar("Frame", {
                        Name = "Dropdown",
                        BackgroundTransparency = 1,
                        Size = UDim2.fromOffset(x.Width or 200, aw),
                        LayoutOrder = u(),
                        Parent = o,
                    })
                    y:SetAttribute("FitWidth", x.Width or 200)
                    local z = { Locked = false, Value = x.Value }
                    if x.Multi and type(z.Value) ~= "table" then
                        z.Value = {}
                    end
                    local A = nil
                    local function B(C, D)
                        z.Value = C
                        if A then
                            A.Refresh()
                        end
                        if not D then
                            w(x.Callback, C)
                        end
                    end
                    A = aj.new(l, m, y, x, z, B)
                    A.Refresh()
                    function z:Set(C, D)
                        B(C, D)
                    end
                    function z:Get()
                        return z.Value
                    end
                    function z:SetOptions(C)
                        A.SetOptions(C)
                        A.Refresh()
                    end
                    function z:SetLocked(C)
                        z.Locked = C
                        A.SetLocked(C)
                    end
                    z.Instance = y
                    return v(z)
                end
                function t:Input(x)
                    local y = ar("Frame", {
                        Name = "Field",
                        BackgroundColor3 = as.Input,
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(x.Width or 160, aw),
                        LayoutOrder = u(),
                        Parent = o,
                    }, { af.Corner(ac.Radius.Lg) })
                    y:SetAttribute("FitWidth", x.Width or 160)
                    local z = af.Stroke(as.Input)
                    z.Parent = y
                    local A = ar("TextBox", {
                        Name = "Box",
                        BackgroundTransparency = 1,
                        ClearTextOnFocus = false,
                        FontFace = ad.Regular,
                        TextSize = ac.TextSize.Sm,
                        TextColor3 = as.Foreground,
                        PlaceholderColor3 = as.MutedForeground,
                        PlaceholderText = x.Placeholder or "",
                        Text = tostring(x.Value or ""),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.fromScale(1, 1),
                        Parent = y,
                    }, { af.Padding(0, 10, 0, 10) })
                    local B = { Locked = false, Value = A.Text, Instance = y }
                    local function C()
                        if x.Numeric then
                            return tonumber(A.Text)
                        end
                        return A.Text
                    end
                    m:Connect(A.Focused, function()
                        ac.Rebind(z, "Color", "Ring")
                    end)
                    m:Connect(A.FocusLost, function()
                        ac.Rebind(z, "Color", "Input")
                        B.Value = C()
                        if not x.Live then
                            w(x.Callback, B.Value)
                        end
                    end)
                    m:Connect(A:GetPropertyChangedSignal("Text"), function()
                        if x.Numeric then
                            local D = string.gsub(A.Text, "[^%d%.%-]", "")
                            if D ~= A.Text then
                                A.Text = D
                                return
                            end
                        end
                        B.Value = C()
                        if x.Live and A:IsFocused() then
                            w(x.Callback, B.Value)
                        end
                    end)
                    function B:Set(D, E)
                        A.Text = tostring(D or "")
                        B.Value = C()
                        if not E then
                            w(x.Callback, B.Value)
                        end
                    end
                    function B:Get()
                        return C()
                    end
                    function B:Focus()
                        A:CaptureFocus()
                    end
                    function B:SetLocked(D)
                        B.Locked = D
                        A.TextEditable = not D
                        local E = 0
                        if D then
                            E = av
                            A:ReleaseFocus()
                        end
                        ac.Tween(A, { TextTransparency = E })
                    end
                    return v(B)
                end
                function t:Stepper(x)
                    local y, z, A, B = x.Min or 0, x.Max or 100, x.Step or 1, x.Suffix or ""
                    local C, D, E =
                        #(string.match(tostring(A), "%.(%d+)$") or ""), x.Value or y, ar("Frame", {
                            Name = "Stepper",
                            BackgroundColor3 = as.Input,
                            BackgroundTransparency = 0.7,
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            Size = UDim2.fromOffset(0, 28),
                            LayoutOrder = u(),
                            Parent = o,
                        }, {
                            af.Corner(ac.Radius.Lg),
                            af.Padding(0, 2, 0, 2),
                            ar("UIListLayout", {
                                FillDirection = Enum.FillDirection.Horizontal,
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                SortOrder = Enum.SortOrder.LayoutOrder,
                            }),
                        })
                    af.Stroke(as.Input).Parent = E
                    local function F(G, H)
                        local I = ar("TextButton", {
                            Name = G,
                            Text = "",
                            AutoButtonColor = false,
                            BackgroundColor3 = as.Accent,
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.fromOffset(24, 24),
                            LayoutOrder = H,
                            Parent = E,
                        }, { af.Corner(ac.Radius.Md) })
                        ar("ImageLabel", {
                            BackgroundTransparency = 1,
                            Image = ae.Get(G) or "",
                            ImageColor3 = as.MutedForeground,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(14, 14),
                            Parent = I,
                        })
                        m:Connect(I.MouseEnter, function()
                            ac.Tween(I, { BackgroundTransparency = 0 })
                        end)
                        m:Connect(I.MouseLeave, function()
                            ac.Tween(I, { BackgroundTransparency = 1 })
                        end)
                        return I
                    end
                    local G, H, I, J =
                        F("minus", 1), ar("TextBox", {
                            Name = "Value",
                            BackgroundTransparency = 1,
                            ClearTextOnFocus = false,
                            TextEditable = x.Field ~= false,
                            FontFace = ad.Medium,
                            TextSize = ac.TextSize.Sub,
                            TextColor3 = as.Foreground,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            AutomaticSize = Enum.AutomaticSize.X,
                            Size = UDim2.fromOffset(40, 24),
                            LayoutOrder = 2,
                            Parent = E,
                        }, { af.Padding(0, 8, 0, 8), ar("UISizeConstraint", { MinSize = Vector2.new(40, 24) }) }), F("plus", 3), { Locked = false, Instance = E }
                    local function K(L)
                        local M = y + math.floor((L - y) / A + 0.5) * A
                        return math.clamp((tonumber(string.format("%." .. C .. "f", M))), y, z)
                    end
                    local function L(M)
                        return math.clamp((tonumber(string.format("%." .. C .. "f", M))), y, z)
                    end
                    local function M()
                        H.Text = string.format("%." .. C .. "f", D) .. B
                    end
                    function J:Set(N, O)
                        D = L(tonumber(N) or D)
                        J.Value = D
                        M()
                        if not O then
                            w(x.Callback, D)
                        end
                    end
                    function J:Get()
                        return D
                    end
                    function J:SetLocked(N)
                        J.Locked = N
                        G.Visible = not N
                        I.Visible = not N
                        H.TextEditable = x.Field ~= false and not N
                    end
                    m:Connect(G.MouseButton1Click, function()
                        if not J.Locked then
                            J:Set(K(D - A))
                        end
                    end)
                    m:Connect(I.MouseButton1Click, function()
                        if not J.Locked then
                            J:Set(K(D + A))
                        end
                    end)
                    m:Connect(H.Focused, function()
                        H.Text = string.format("%." .. C .. "f", D)
                    end)
                    m:Connect(H.FocusLost, function()
                        local N = tonumber((string.gsub(H.Text, "[^%d%.%-]", "")))
                        if N then
                            J:Set(N)
                        else
                            M()
                        end
                    end)
                    D = L(D)
                    J.Value = D
                    M()
                    return v(J)
                end
                function t:Keybind(x)
                    local y, z, A, B =
                        x.Value, false, ar("TextButton", {
                            Name = "Key",
                            AutoButtonColor = false,
                            BackgroundColor3 = as.Card,
                            BorderSizePixel = 0,
                            FontFace = ad.Medium,
                            TextSize = ac.TextSize.Sub,
                            TextColor3 = as.Foreground,
                            Text = "",
                            Size = UDim2.fromOffset(64, 28),
                            LayoutOrder = u(),
                            Parent = o,
                        }, { af.Corner(ac.Radius.Md) }), af.Stroke(as.Input)
                    B.Parent = A
                    local C = { Locked = false, Value = y, Instance = A }
                    local function D(E)
                        A.Text = E
                        A.Size = UDim2.fromOffset(math.max(44, af.TextWidth(E, ac.TextSize.Sub, ad.Medium) + 24), 28)
                    end
                    function C:Set(E, F)
                        y = E
                        C.Value = E
                        D(g(E))
                        if not F then
                            w(x.Callback, E)
                        end
                    end
                    function C:Get()
                        return y
                    end
                    function C:SetLocked(E)
                        C.Locked = E
                    end
                    m:Connect(A.MouseButton1Click, function()
                        if C.Locked or z then
                            return
                        end
                        task.defer(function()
                            z = true
                            D("Press a key")
                            ac.Rebind(B, "Color", "Ring")
                        end)
                    end)
                    m:Connect(ab.InputBegan, function(E)
                        if not z then
                            return
                        end
                        local F = i(E)
                        if not F then
                            return
                        end
                        z = false
                        ac.Rebind(B, "Color", "Input")
                        if E.KeyCode == Enum.KeyCode.Escape or F == "MouseButton1" then
                            D(g(y))
                        elseif E.KeyCode == Enum.KeyCode.Backspace then
                            C:Set(nil)
                        else
                            C:Set(F)
                        end
                    end)
                    D(g(y))
                    return v(C)
                end
                return t
            end
            return aA
        end
        function a.q()
            local ab = a.cache.q
            if not ab then
                ab = { c = aa() }
                a.cache.q = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae = a.Theme(), a.f(), a.Creator(), {}
            local function af(ag)
                local ah = string.gsub(ag, "(%l)(%u)", "%1 %2")
                return string.sub(ah, 1, 1) .. string.lower(string.sub(ah, 2))
            end
            local ag = { "Default", "Zinc", "Blue", "Green", "Orange", "Rose", "Violet", "Yellow" }
            function ae.Theme(ah)
                local ai = ah._window
                local aj, ak, al =
                    ai.Library, ah:AddSection({
                        Title = "Appearance",
                        Description = "The mode and the accent; saved with your settings",
                        Icon = "paintbrush",
                        Color = "Purple",
                    }), false
                local am, an =
                    ak:AddDropdown({
                        Title = "Mode",
                        Description = "Dark, a soft Light, or shadcn's pure White",
                        Options = { "Dark", "Light", "White" },
                        Default = ab.Mode,
                        Search = false,
                        Clearable = false,
                        Callback = function(am)
                            if am and not al then
                                aj:SetTheme(am)
                            end
                        end,
                    }), table.clone(ag)
                table.insert(an, "Custom")
                local function ao()
                    if typeof(ab.Accent) == "Color3" then
                        return "Custom"
                    end
                    return tostring(ab.Accent)
                end
                local ap, aq =
                    ak:AddDropdown({
                        Title = "Accent",
                        Description = [[shadcn's colour themes for buttons, switches and the sidebar]],
                        Options = an,
                        Default = ao(),
                        Search = false,
                        Clearable = false,
                        Callback = function(ap)
                            if not ap or al then
                                return
                            end
                            if ap == "Custom" then
                                aj:SetAccent(ab.Current.Primary)
                            else
                                aj:SetAccent(ap)
                            end
                        end,
                    }), ak:AddColorPicker({
                        Title = "Custom accent",
                        Description = [[Any colour; the text on it turns black or white to stay readable]],
                        Default = ab.Current.Primary,
                        Callback = function(ap)
                            if not al then
                                aj:SetAccent(ap, true)
                            end
                        end,
                    })
                ak:AddButton({
                    Title = "Random theme",
                    Description = [[One random hue, worked into every colour so they still belong together]],
                    Buttons = {
                        {
                            Title = "Shuffle",
                            Icon = "shuffle",
                            Callback = function()
                                aj:RandomTheme()
                            end,
                        },
                        {
                            Title = "Dark",
                            Variant = "Outline",
                            Callback = function()
                                aj:RandomTheme("Dark")
                            end,
                        },
                        {
                            Title = "Light",
                            Variant = "Outline",
                            Callback = function()
                                aj:RandomTheme("Light")
                            end,
                        },
                    },
                })
                local ar = {}
                for as, at in ipairs(aj.ThemeTokens) do
                    local au = ah:AddSection({
                        Title = "Colours: " .. at.Title,
                        Description = [[Each colour of the theme, live; its reset puts back what the mode and accent give]],
                        Icon = "paintpalette",
                        Color = ({ "Blue", "Green", "Orange", "Indigo" })[as] or "Gray",
                    })
                    for av, aw in ipairs(at.Tokens) do
                        ar[aw] = au:AddColorPicker({
                            Title = af(aw),
                            Default = aj:DefaultColor(aw) or ab.Current[aw],
                            Callback = function(ax)
                                if not al then
                                    aj:SetColor(aw, ax, true)
                                end
                            end,
                        })
                        ar[aw]:Set(ab.Current[aw], nil, true)
                    end
                end
                local as = ah:AddSection({
                    Title = "Reset and share",
                    Description = "Start over, or pass a theme around as a line of text",
                    Icon = "squareAndArrowUp",
                    Color = "Teal",
                })
                as:AddButton({
                    Title = "Reset theme",
                    Description = "Mode, accent and every colour back to the defaults",
                    ButtonText = "Reset",
                    Icon = "rotate-ccw",
                    Variant = "Outline",
                    Confirm = {
                        Title = "Reset the theme?",
                        Description = "Your mode, accent and colour changes are dropped",
                        ConfirmText = "Reset",
                        Destructive = true,
                    },
                    Callback = function()
                        aj:ResetTheme()
                        aj:Toast({ Title = "Theme reset", Type = "Success", Duration = 2 })
                    end,
                })
                as:AddButton({
                    Title = "Export",
                    Description = "Copies the theme to the clipboard",
                    ButtonText = "Copy",
                    Icon = "doc-on-doc",
                    Variant = "Outline",
                    Callback = function()
                        local at = aj:ExportTheme()
                        local au = pcall(function()
                            setclipboard(at)
                        end)
                        if au then
                            aj:Toast({
                                Title = "Theme copied",
                                Description = "Paste it into Import to use it elsewhere",
                                Type = "Success",
                            })
                        else
                            aj:Toast({ Title = "No clipboard here", Description = at, Type = "Warning", Duration = 10 })
                        end
                    end,
                })
                as:AddInput({
                    Title = "Import",
                    Description = "Paste a copied theme and press Enter",
                    Placeholder = '{"Mode":"Dark",...}',
                    Icon = "squareAndArrowDown",
                    Width = 200,
                    Callback = function(at)
                        if at == "" then
                            return
                        end
                        if aj:ImportTheme(at) then
                            aj:Toast({ Title = "Theme imported", Type = "Success", Duration = 2 })
                        else
                            aj:Toast({
                                Title = "That is not a theme",
                                Description = "Copy one with Export first",
                                Type = "Error",
                            })
                        end
                    end,
                })
                local at = aj.ThemeChanged:Connect(function(at)
                    al = true
                    am:Set(ab.Mode, true)
                    ap:Set(ao(), true)
                    if typeof(ab.Accent) == "Color3" and aq.Value ~= ab.Accent then
                        aq:Set(ab.Accent, nil, true)
                    end
                    for au, av in pairs(ar) do
                        if av.Value ~= at[au] then
                            av:Set(at[au], nil, true)
                        end
                    end
                    al = false
                end)
                ai:Track(at)
            end
            local function ah(ai, aj)
                local ak = typeof(ai)
                if ak == "string" then
                    return string.format("%q", ai)
                elseif ak == "number" or ak == "boolean" or ak == "nil" then
                    return tostring(ai)
                elseif ak == "Color3" then
                    return string.format('Color3.fromHex("%s")', ai:ToHex())
                elseif ak == "EnumItem" then
                    return tostring(ai)
                elseif ak == "UDim2" then
                    return string.format("UDim2.new(%s, %s, %s, %s)", ai.X.Scale, ai.X.Offset, ai.Y.Scale, ai.Y.Offset)
                elseif ak == "Vector2" then
                    return string.format("Vector2.new(%s, %s)", ai.X, ai.Y)
                elseif ak ~= "table" then
                    return "nil"
                end
                local al, am = aj .. "\t", {}
                if #ai > 0 then
                    for an, ao in ipairs(ai) do
                        table.insert(am, al .. ah(ao, al) .. ",")
                    end
                else
                    local an = {}
                    for ao in pairs(ai) do
                        table.insert(an, ao)
                    end
                    table.sort(an, function(ao, ap)
                        return tostring(ao) < tostring(ap)
                    end)
                    for ao, ap in ipairs(an) do
                        local aq = tostring(ap)
                        if type(ap) ~= "string" or not string.match(aq, "^[%a_][%w_]*$") then
                            aq = "[" .. ah(ap, al) .. "]"
                        end
                        table.insert(am, al .. aq .. " = " .. ah(ai[ap], al) .. ",")
                    end
                end
                if #am == 0 then
                    return "{}"
                end
                return "{\n" .. table.concat(am, "\n") .. "\n" .. aj .. "}"
            end
            local function ai(aj, ak)
                local al = game:GetService("HttpService")
                local function am(an, ao)
                    return ad.Base64Encode(al:JSONEncode({ Name = an, Data = ac.Encode(ao) }))
                end
                return {
                    LoadOnStart = true,
                    List = function()
                        return ak:ListProfiles()
                    end,
                    Read = function(an)
                        return ak:ReadProfile(an)
                    end,
                    Dates = function(an)
                        local ao = ak:ReadProfile(an)
                        if ao and type(ao.__meta) == "table" then
                            return ao.__meta.Created, ao.__meta.Updated
                        end
                        return nil, nil
                    end,
                    Load = function(an)
                        return aj:LoadProfile(an)
                    end,
                    Save = function(an)
                        return aj:SaveProfile(an)
                    end,
                    Delete = function(an)
                        ak:DeleteProfile(an)
                    end,
                    Code = function(an)
                        local ao = ak:ReadProfile(an)
                        return ao and am(an, ao)
                    end,
                    Import = function(an)
                        local ao = ad.Base64Decode(an or "")
                        local ap, aq = pcall(function()
                            return al:JSONDecode(ao or "")
                        end)
                        if not ap or type(aq) ~= "table" or type(aq.Data) ~= "table" then
                            return false, nil
                        end
                        local ar = ac.CleanName(tostring(aq.Name or "Imported"))
                        if ar == "" then
                            ar = "Imported"
                        end
                        local as, at, au = ar, ak:ListProfiles(), 2
                        while table.find(at, as) do
                            as = ar .. " " .. au
                            au += 1
                        end
                        local av = ak.Data
                        ak.Data = ac.Decode(aq.Data)
                        local aw = ak:SaveProfile(as)
                        ak.Data = av
                        return aw, as
                    end,
                    Current = function()
                        return am("Shared", ak.Data)
                    end,
                    Loader = function()
                        return "getgenv().Configs = " .. ah(ak.Data, "")
                    end,
                    GetAutoload = function()
                        return ak:GetAutoload()
                    end,
                    SetAutoload = function(an)
                        ak:SetAutoload(an)
                    end,
                }
            end
            function ae.Configs(aj, ak)
                local al = aj._window
                local am, an = al.Library, al.Config
                if not an and not ak then
                    aj:AddSection({ Title = "Configs", Icon = "folder", Color = "Blue" }):AddParagraph(
                        "No saving",
                        [[This window was opened with Config = false, so there is nothing to keep]]
                    )
                    return
                end
                local ao = ak or ai(al, an)
                local function ap(aq, ar, as)
                    am:Toast({ Title = aq, Type = ar, Description = as, Duration = 2.5 })
                end
                local function aq(ar, as)
                    local at = pcall(function()
                        setclipboard(ar)
                    end)
                    if at then
                        ap(as .. " copied", "Success")
                    else
                        ap("No clipboard in this executor", "Warning")
                    end
                end
                local ar, as, at, au, av =
                    aj:AddSection({
                        Title = "Saved configs",
                        Description = [[Select one, then load, overwrite, export, auto-load or delete it]],
                        Icon = "folder",
                        Color = "Blue",
                    }), nil, nil, nil, nil
                local function aw(ax)
                    if type(ax) ~= "table" then
                        return 1
                    end
                    if #ax > 0 then
                        return 1
                    end
                    local ay = 0
                    for az, aA in pairs(ax) do
                        if az ~= "__shadcn" and az ~= "__meta" then
                            ay += aw(aA)
                        end
                    end
                    return ay
                end
                local function ax(ay)
                    if type(ay) ~= "number" then
                        return { Text = "-", Muted = true, Sort = 0 }
                    end
                    local az, aA = os.time() - ay, nil
                    if az < 60 then
                        aA = "just now"
                    elseif az < 3600 then
                        aA = math.floor(az / 60) .. "m ago"
                    elseif az < 86400 then
                        aA = math.floor(az / 3600) .. "h ago"
                    elseif az < 172800 then
                        aA = "Yesterday"
                    elseif os.date("%Y", ay) == os.date("%Y") then
                        aA = os.date("%b %d", ay)
                    else
                        aA = os.date("%b %d %Y", ay)
                    end
                    return {
                        Text = aA,
                        Muted = true,
                        Sort = ay,
                    }
                end
                local ay = ar:AddTable({
                    Columns = {
                        { Key = "Name", Title = "Config", Grow = 3 },
                        { Key = "Settings", Title = "Settings", Align = "Right" },
                        { Key = "Created", Title = "Created" },
                        { Key = "Updated", Title = "Updated" },
                        { Key = "Start", Title = "On start", Grow = 1 },
                    },
                    Selectable = true,
                    Empty = "No configs yet, create one below",
                    MaxHeight = 260,
                })
                local function az()
                    if av then
                        av:SetLocked(au == nil)
                    end
                end
                ay.SelectionChanged:Connect(function(aA, b)
                    if b then
                        au = b.Name.Text
                    else
                        au = nil
                    end
                    az()
                end)
                local function aA()
                    if not au then
                        ap("Select a config first", "Warning")
                    end
                    return au
                end
                av = ar:AddButton({
                    Title = "Selected config",
                    Buttons = {
                        {
                            Title = "Load",
                            Icon = "squareAndArrowUp",
                            Callback = function()
                                local b = aA()
                                if not b then
                                    return
                                end
                                if ao.Load(b) then
                                    ap("Loaded " .. b, "Success")
                                else
                                    ap("Could not load " .. b, "Error")
                                end
                            end,
                        },
                        {
                            Title = "Save",
                            Variant = "Secondary",
                            Confirm = {
                                Title = "Overwrite the selected config?",
                                Description = "It is replaced with your settings as they are now",
                                ConfirmText = "Overwrite",
                            },
                            Callback = function()
                                local b = aA()
                                if b and ao.Save(b) then
                                    at()
                                    ap("Saved " .. b, "Success")
                                end
                            end,
                        },
                        {
                            Title = "Export",
                            Variant = "Secondary",
                            Callback = function()
                                local b = aA()
                                local c = b and ao.Code(b)
                                if b and c then
                                    aq(c, b .. "'s code")
                                end
                            end,
                        },
                        {
                            Title = "Auto",
                            Icon = "bolt",
                            Variant = "Ghost",
                            Callback = function()
                                local b = aA()
                                if b then
                                    ao.SetAutoload(b)
                                    at()
                                    ap(b .. " loads on start", "Success")
                                end
                            end,
                        },
                        {
                            Title = "Delete",
                            Variant = "Destructive",
                            Confirm = {
                                Title = "Delete the selected config?",
                                Description = "The saved config is removed for good",
                                ConfirmText = "Delete",
                                Destructive = true,
                                Icon = "trash-2",
                            },
                            Callback = function()
                                local b = aA()
                                if b then
                                    ao.Delete(b)
                                    au = nil
                                    at()
                                    ap("Deleted " .. b)
                                end
                            end,
                        },
                    },
                })
                at = function()
                    local b, c, d, e = ao.List(), ao.GetAutoload(), {}, nil
                    for f, g in ipairs(b) do
                        local h = ""
                        if g == c then
                            h = { Text = "Loads on start", Badge = "Default", Sort = 1 }
                        end
                        local i, j, k = ao.Read(g), ao.Dates(g)
                        table.insert(d, {
                            Name = { Text = g, Icon = "doc" },
                            Settings = aw(i),
                            Created = ax(j),
                            Updated = ax(k),
                            Start = h,
                        })
                        if g == au then
                            e = f
                        end
                    end
                    ay:SetRows(d)
                    if e then
                        ay:Select(e)
                    else
                        au = nil
                    end
                    az()
                    if as then
                        if c then
                            as:SetText(c)
                            as:SetVariant("Default")
                        else
                            as:SetText("None")
                            as:SetVariant("Outline")
                        end
                    end
                end
                local b, c, d =
                    aj:AddSection({
                        Title = "Manage",
                        Description = [[Create a config, bring one in from a code, or share your settings]],
                        Icon = "gearshape",
                        Color = "Gray",
                    }), nil, nil
                c = b:AddInput({
                    Title = "New config",
                    Description = "Saves the settings as they are now under a name",
                    Placeholder = "Config name",
                    Icon = "pencil",
                    Width = 170,
                    Button = {
                        Title = "Create",
                        Icon = "plus",
                        Callback = function(e)
                            local f = ac.CleanName(e)
                            if f == "" then
                                ap("Name it first", "Warning")
                                return
                            end
                            if
                                table.find(ao.List(), f)
                                and not al:Confirm({
                                    Title = f .. " exists",
                                    Description = "Overwrite it with your settings as they are now?",
                                    ConfirmText = "Overwrite",
                                })
                            then
                                return
                            end
                            if ao.Save(f) then
                                c:Set("", true)
                                at()
                                ap("Created " .. f, "Success")
                            else
                                ap("Could not save", "Error", "This executor cannot write files")
                            end
                        end,
                    },
                })
                d = b:AddInput({
                    Title = "Import",
                    Description = "Paste a config code to add it as a config",
                    Placeholder = "Paste a code",
                    Icon = "squareAndArrowDown",
                    Width = 170,
                    Button = {
                        Title = "Import",
                        Variant = "Secondary",
                        Callback = function(e)
                            local f, g = ao.Import(e or "")
                            if f and g then
                                d:Set("", true)
                                at()
                                ap("Imported " .. g, "Success", "Load it from Saved configs")
                            else
                                ap("That is not a config code", "Error", "Copy one with Export first")
                            end
                        end,
                    },
                })
                b:AddButton({
                    Title = "Export current",
                    Description = "Your settings now, as a code to share or keep",
                    ButtonText = "Copy code",
                    Icon = "docOnDoc",
                    Variant = "Outline",
                    Callback = function()
                        aq(ao.Current(), "Code")
                    end,
                })
                b:AddButton({
                    Title = "Copy loader",
                    Description = [[Your settings as getgenv().Configs = { ... }, for a loader script]],
                    ButtonText = "Copy loader",
                    Icon = "chevronLeftForwardslashChevronRight",
                    Variant = "Outline",
                    Callback = function()
                        aq(ao.Loader(), "Loader")
                    end,
                })
                as = b:AddBadge({
                    Title = "Loads on start",
                    Description = "Set it with Auto under the table",
                    Badges = { { Text = "None", Variant = "Outline" } },
                })
                b:AddButton({
                    Title = "Stop loading on start",
                    ButtonText = "Clear",
                    Variant = "Ghost",
                    Callback = function()
                        ao.SetAutoload(nil)
                        at()
                        ap("Nothing loads on start")
                    end,
                })
                at()
                local e = ao.LoadOnStart ~= false and ao.GetAutoload()
                if e and not al._autoloaded then
                    al._autoloaded = true
                    task.defer(function()
                        if ao.Load(e) then
                            am:Toast({ Title = "Loaded " .. e, Description = "Your config for start", Duration = 3 })
                        end
                    end)
                end
            end
            return ae
        end
        function a.r()
            local ab = a.cache.r
            if not ab then
                ab = { c = aa() }
                a.cache.r = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad = a.q(), a.r(), {}
            ad.__index = ad
            function ad.new(ae, af, ag, ah, ai)
                return setmetatable({ Title = ai, _window = ae, _page = af, _item = ag, _label = ah, _order = 0 }, ad)
            end
            function ad:AddSection(ae, af)
                local ag = {}
                if type(ae) == "string" then
                    ag = { Title = ae, Description = af }
                elseif type(ae) == "table" then
                    ag = ae
                end
                self._order += 1
                return ab.new(self, ag, self._order)
            end
            function ad:Select()
                self._window:SelectTab(self)
            end
            function ad:AddThemeSettings()
                ac.Theme(self)
            end
            function ad:AddConfigSettings(ae)
                ac.Configs(self, ae)
            end
            function ad:SetBadge(ae)
                local af, ag = self._badge, ""
                if ae ~= nil then
                    ag = tostring(ae)
                end
                af.Text = ag
                af.Visible = ag ~= "" and not self._window._collapsed
            end
            return ad
        end
        function a.s()
            local ab = a.cache.s
            if not ab then
                ab = { c = aa() }
                a.cache.s = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae, af, ag, ah, ai, aj, ak, al, am, an, ao, ap, aq =
                game:GetService("Players"),
                game:GetService("UserInputService"),
                game:GetService("RunService"),
                a.Theme(),
                a.Fonts(),
                a.Creator(),
                a.Icons(),
                a.f(),
                a.g(),
                a.h(),
                a.j(),
                a.i(),
                a.k(),
                a.l(),
                a.s(),
                game:GetService("TweenService")
            local ar, as, at, au, av, aw, ax, ay, az, aA, b, c, d =
                ag.Create,
                ae.Token,
                232,
                52,
                56,
                32,
                38,
                48,
                Vector2.new(520, 360),
                640,
                24,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {}
            d.__index = d
            local e, f = 20, 16
            local function g(h, i, j, k, l)
                local m = h:Icon(j)
                if m then
                    return ar("ImageLabel", {
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Image = m,
                        ImageColor3 = l,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.fromScale(0, 0.5),
                        Size = UDim2.fromOffset(e, e),
                        ZIndex = 5,
                        Parent = i,
                    })
                end
                return ag.Text({
                    Name = "Icon",
                    Text = string.upper(string.sub(k, 1, 1)),
                    TextColor3 = l,
                    FontFace = af.Medium,
                    TextSize = ae.TextSize.Sm,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.fromScale(0, 0.5),
                    Size = UDim2.fromOffset(e, e),
                    ZIndex = 5,
                    Parent = i,
                })
            end
            local function h(i)
                local j = utf8.len(i) or #i
                if j <= 2 then
                    return string.rep("\u{2022}", j)
                end
                local k = 2
                if j <= 5 then
                    k = 1
                end
                local l, m = string.sub(i, 1, utf8.offset(i, k + 1) - 1), string.sub(i, utf8.offset(i, j - k + 1))
                return l .. string.rep("\u{2022}", j - k * 2) .. m
            end
            local i, j = 30, 22
            local function k(l)
                if l:IsA("ImageLabel") then
                    return "ImageColor3"
                end
                return "TextColor3"
            end
            function d.new(l, m, n)
                local o = setmetatable({
                    Library = l,
                    Flags = {},
                    Title = n.Title or "Window",
                    _maid = m,
                    _tabs = {},
                    _groups = {},
                    _selected = nil,
                    _visible = true,
                    _destroyed = false,
                    Controls = {},
                    Closing = aj.new(),
                    VisibilityChanged = aj.new(),
                }, d)
                if n.Config ~= false then
                    o.Config = ai.new(n.Config, m)
                    o.Flags = o.Config.Data
                end
                if n.BeforeBuild then
                    n.BeforeBuild(o)
                end
                local p = m:Give(ar("ScreenGui", {
                    Name = "shadcn",
                    ResetOnSpawn = false,
                    IgnoreGuiInset = true,
                    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                    DisplayOrder = 100,
                }))
                o.Instance = p
                local q = ar("Frame", {
                    Name = "Holder",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = n.Size or UDim2.fromOffset(760, 500),
                    Parent = p,
                })
                o._holder = q
                local r = ar("Frame", {
                    Name = "Window",
                    BackgroundColor3 = as.Background,
                    Size = UDim2.fromScale(1, 1),
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    ZIndex = 2,
                    Parent = q,
                }, { ag.Corner(ae.Radius.Xl), ag.Stroke(as.Border) })
                o._root = r
                o._overlay = ar("Frame", {
                    Name = "Popovers",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 20,
                    Parent = p,
                })
                o._popover = nil
                o._tooltip = ag.Text({
                    Name = "Tooltip",
                    Text = "",
                    BackgroundColor3 = as.Foreground,
                    BackgroundTransparency = 0,
                    TextColor3 = as.Background,
                    TextSize = ae.TextSize.Xs,
                    FontFace = af.Medium,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 26),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Visible = false,
                    ZIndex = 30,
                    Parent = o._overlay,
                })
                ar("UICorner", { CornerRadius = UDim.new(0, ae.Radius.Md), Parent = o._tooltip })
                ag.Padding(0, 12, 0, 12).Parent = o._tooltip
                local s = ar("Frame", {
                    Name = "Sidebar",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, at, 1, 0),
                    ZIndex = 3,
                    Parent = r,
                }, {
                    ar("Frame", {
                        Name = "Backdrop",
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ClipsDescendants = true,
                        Size = UDim2.fromScale(1, 1),
                        ZIndex = 2,
                    }, {
                        ar("Frame", {
                            Name = "Body",
                            BackgroundColor3 = as.Sidebar,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, ae.Radius.Xl, 1, 0),
                            ZIndex = 2,
                        }, { ag.Corner(ae.Radius.Xl) }),
                    }),
                })
                o._sidebarBody = s.Backdrop.Body
                o._sidebar = s
                ar("Frame", {
                    Name = "Edge",
                    BackgroundColor3 = as.Foreground,
                    BackgroundTransparency = 0.92,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.fromScale(1, 0),
                    Size = UDim2.new(0, 1, 1, 0),
                    ZIndex = 3,
                    Parent = s,
                })
                local t = ar(
                    "Frame",
                    {
                        Name = "Header",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, -1, 0, av),
                        ZIndex = 3,
                        Parent = s,
                    },
                    { ag.Padding(4, 8, 4, 10) }
                )
                o._brand = t
                local u, v, w =
                    ar("Frame", {
                        Name = "Brand",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, ay),
                        ClipsDescendants = true,
                        ZIndex = 3,
                        Parent = t,
                    }), l:Icon(n.Icon), 2
                if v then
                    local x = ar("Frame", {
                        Name = "Logo",
                        BackgroundColor3 = as.SidebarPrimary,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, 0, 0.5, 0),
                        Size = UDim2.fromOffset(32, 32),
                        ZIndex = 4,
                        Parent = u,
                    }, { ag.Corner(ae.Radius.Lg) })
                    if ah.IsImage(n.Icon) then
                        x.BackgroundTransparency = 1
                        ar("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = v,
                            ScaleType = Enum.ScaleType.Crop,
                            Size = UDim2.fromScale(1, 1),
                            ZIndex = 5,
                            Parent = x,
                        }, { ag.Corner(ae.Radius.Lg) })
                    else
                        ar("ImageLabel", {
                            Name = "Icon",
                            BackgroundTransparency = 1,
                            Image = v,
                            ImageColor3 = as.SidebarPrimaryForeground,
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.fromScale(0.5, 0.5),
                            Size = UDim2.fromOffset(18, 18),
                            ZIndex = 5,
                            Parent = x,
                        })
                    end
                    w = 40
                end
                local x = ar("Frame", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(w, 0),
                    Size = UDim2.new(1, -w, 1, 0),
                    ZIndex = 4,
                    Parent = u,
                }, {
                    ar("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                ag.Text({
                    Name = "Title",
                    Text = o.Title,
                    TextColor3 = as.SidebarForeground,
                    FontFace = af.SemiBold,
                    TextSize = ae.TextSize.Base,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.new(1, 0, 0, 19),
                    LayoutOrder = 1,
                    ZIndex = 4,
                    Parent = x,
                })
                if n.Subtitle then
                    ag.Text({
                        Name = "Subtitle",
                        Text = n.Subtitle,
                        TextColor3 = as.MutedForeground,
                        FontFace = af.Medium,
                        TextSize = ae.TextSize.Xs,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(1, 0, 0, 16),
                        LayoutOrder = 2,
                        ZIndex = 4,
                        Parent = x,
                    })
                end
                local y, z = n.Footer, 0
                if y ~= false then
                    z = ay + 16
                end
                o._nav = ar("ScrollingFrame", {
                    Name = "Content",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2.fromOffset(0, av),
                    Size = UDim2.new(1, -1, 1, -(av + z)),
                    CanvasSize = UDim2.new(),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    ZIndex = 3,
                    Parent = s,
                }, { ag.List(0) })
                o._navLabel = n.NavigationLabel
                o._tabIcons = n.TabIcons or "Accent"
                if y ~= false then
                    o:_buildFooter(s, y, z)
                end
                local A = ar("Frame", {
                    Name = "Main",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(at, 0),
                    Size = UDim2.new(1, -at, 1, 0),
                    ZIndex = 2,
                    Parent = r,
                })
                o._main = A
                o._surface = ar("Frame", {
                    Name = "Surface",
                    BackgroundColor3 = as.Background,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    Visible = false,
                    ZIndex = 1,
                    Parent = A,
                }, {
                    ag.Corner(ae.Radius.Xl),
                    ar("Frame", {
                        Name = "Filler",
                        BackgroundColor3 = as.Background,
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, ae.Radius.Xl, 1, 0),
                        ZIndex = 1,
                    }),
                })
                local B = ar(
                    "Frame",
                    {
                        Name = "Topbar",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, av),
                        ZIndex = 3,
                        Parent = A,
                    }
                )
                ar("Frame", {
                    Name = "Edge",
                    BackgroundColor3 = as.Foreground,
                    BackgroundTransparency = 0.92,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.fromScale(0, 1),
                    Size = UDim2.new(1, 0, 0, 1),
                    ZIndex = 3,
                    Parent = B,
                })
                local C = ak.new(m, {
                    Title = "\u{2261}",
                    Icon = "panel-left",
                    Variant = "Ghost",
                    Size = "Icon",
                    Callback = function()
                        o:SetSidebarCollapsed(not o._collapsed, true)
                    end,
                })
                C.Size = UDim2.fromOffset(28, 28)
                C.AnchorPoint = Vector2.new(0, 0.5)
                C.Position = UDim2.new(0, 12, 0.5, 0)
                C.ZIndex = 4
                C.Parent = B
                ar("Frame", {
                    Name = "Separator",
                    BackgroundColor3 = as.Border,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 48, 0.5, 0),
                    Size = UDim2.fromOffset(1, 16),
                    ZIndex = 4,
                    Parent = B,
                })
                local D = ar("Frame", {
                    Name = "Heading",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(61, 0),
                    Size = UDim2.new(1, -150, 1, 0),
                    ZIndex = 3,
                    Parent = B,
                }, {
                    ar("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 1),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                local E = ar("Frame", {
                    Name = "Breadcrumb",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    LayoutOrder = 1,
                    ZIndex = 3,
                    Parent = D,
                }, {
                    ar("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 6),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                o._crumbGroup = ag.Text({
                    Name = "Group",
                    Text = "",
                    TextColor3 = as.MutedForeground,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 20),
                    LayoutOrder = 1,
                    Visible = false,
                    ZIndex = 3,
                    Parent = E,
                })
                local F = l:Icon("chevron-right")
                o._crumbChevron = ar("ImageLabel", {
                    Name = "Chevron",
                    BackgroundTransparency = 1,
                    Image = F or "",
                    ImageColor3 = as.MutedForeground,
                    Size = UDim2.fromOffset(16, 16),
                    LayoutOrder = 2,
                    Visible = false,
                    ZIndex = 3,
                    Parent = E,
                })
                o._heading = ag.Text({
                    Name = "Title",
                    Text = "",
                    FontFace = af.HeadingMedium,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.fromOffset(0, 20),
                    LayoutOrder = 3,
                    ZIndex = 3,
                    Parent = E,
                })
                o._subheading = ag.Text({
                    Name = "Description",
                    Text = "",
                    TextColor3 = as.MutedForeground,
                    TextSize = ae.TextSize.Xs,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.new(1, 0, 0, 15),
                    LayoutOrder = 2,
                    Visible = false,
                    ZIndex = 3,
                    Parent = D,
                })
                local G, H =
                    ar("Frame", {
                        Name = "Controls",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -16, 0.5, 0),
                        Size = UDim2.fromOffset(52, 28),
                        ZIndex = 3,
                        Parent = B,
                    }, {
                        ar("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal,
                            HorizontalAlignment = Enum.HorizontalAlignment.Right,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 8),
                            SortOrder = Enum.SortOrder.LayoutOrder,
                        }),
                    }), {}
                for I, J in ipairs({
                    {
                        name = "Close",
                        color = "ff5f57",
                        ring = "e0443e",
                        glyph = "x",
                        press = function()
                            o:Destroy("Close")
                        end,
                    },
                    {
                        name = "Minimize",
                        color = "febc2e",
                        ring = "dea123",
                        glyph = "minus",
                        press = function()
                            o:SetVisible(false)
                        end,
                    },
                    {
                        name = "Zoom",
                        color = "28c840",
                        ring = "1aab29",
                        glyph = "maximize-2",
                        press = function()
                            o:_toggleZoom()
                        end,
                    },
                }) do
                    local K = Color3.fromHex(J.color)
                    local L = ar("TextButton", {
                        Name = J.name,
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = K,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(12, 12),
                        LayoutOrder = I,
                        ZIndex = 4,
                        Parent = G,
                    }, { ag.Corner(6), ag.Stroke(Color3.fromHex(J.ring), 0.5) })
                    local M = ar("ImageLabel", {
                        Name = "Glyph",
                        BackgroundTransparency = 1,
                        Image = l:Icon(J.glyph) or "",
                        ImageColor3 = Color3.new(0, 0, 0),
                        ImageTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(8, 8),
                        ZIndex = 5,
                        Parent = L,
                    })
                    m:Connect(L.MouseButton1Down, function()
                        L.BackgroundColor3 = K:Lerp(Color3.new(0, 0, 0), 0.2)
                    end)
                    m:Connect(L.MouseButton1Up, function()
                        L.BackgroundColor3 = K
                    end)
                    m:Connect(L.MouseLeave, function()
                        L.BackgroundColor3 = K
                    end)
                    m:Connect(L.MouseButton1Click, function()
                        task.spawn(J.press)
                    end)
                    table.insert(H, M)
                end
                o._zoomGlyph = H[3]
                local function I(J)
                    local K = 1
                    if J then
                        K = 0.45
                    end
                    for L, M in ipairs(H) do
                        ae.Tween(M, { ImageTransparency = K })
                    end
                end
                m:Connect(G.MouseEnter, function()
                    I(true)
                end)
                m:Connect(G.MouseLeave, function()
                    I(false)
                end)
                o._pages = ar("Frame", {
                    Name = "Pages",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, av),
                    Size = UDim2.new(1, 0, 1, -av),
                    ClipsDescendants = true,
                    ZIndex = 2,
                    Parent = A,
                })
                local J, K = nil, nil
                local function L(M)
                    return M.UserInputType == Enum.UserInputType.MouseButton1
                        or M.UserInputType == Enum.UserInputType.Touch
                end
                o._isPress = L
                local function M(N, O)
                    if L(O) then
                        J = {
                            kind = N,
                            start = O.Position,
                            position = q.Position,
                            size = Vector2.new(q.Size.X.Offset, q.Size.Y.Offset),
                        }
                        K = nil
                        if N == "move" then
                            o:_closePopover()
                        end
                    end
                end
                function o._drag(N, O, P, Q)
                    if L(O) then
                        J = {
                            kind = "custom",
                            start = O.Position,
                            position = q.Position,
                            size = q.AbsoluteSize,
                            move = P,
                            finish = Q,
                        }
                        K = O.Position
                    end
                end
                m:Connect(B.InputBegan, function(N)
                    M("move", N)
                end)
                m:Connect(t.InputBegan, function(N)
                    M("move", N)
                end)
                m:Connect(ac.InputChanged, function(N)
                    if
                        J
                        and (
                            N.UserInputType == Enum.UserInputType.MouseMovement
                            or N.UserInputType == Enum.UserInputType.Touch
                        )
                    then
                        K = N.Position
                    end
                end)
                m:Connect(ac.InputEnded, function(N)
                    if L(N) then
                        local O = J
                        J = nil
                        K = nil
                        if O and O.finish then
                            task.spawn(O.finish)
                        end
                    end
                end)
                o._toggleKey = n.ToggleKey or Enum.KeyCode.RightShift
                o._gamepadToggleKey = n.GamepadToggleKey
                if o._gamepadToggleKey == nil then
                    o._gamepadToggleKey = Enum.KeyCode.ButtonSelect
                end
                o._keybinds = {}
                m:Connect(ac.InputEnded, function(N)
                    for O, P in ipairs(o._keybinds) do
                        P.ended(N)
                    end
                end)
                m:Connect(ac.InputBegan, function(N, O)
                    if (not O and N.KeyCode == o._toggleKey) or N.KeyCode == o._gamepadToggleKey then
                        o:SetVisible(not o._visible)
                        if o._visible and N.UserInputType.Name:match("^Gamepad") and o._selected then
                            pcall(function()
                                game:GetService("GuiService").SelectedObject = o._selected._item
                            end)
                        end
                    end
                    for P, Q in ipairs(o._keybinds) do
                        Q.began(N, O)
                    end
                    local P = o._popover
                    if P and L(N) then
                        local Q = Vector2.new(N.Position.X, N.Position.Y)
                        local function R(S)
                            local T, U = S.AbsolutePosition, S.AbsoluteSize
                            return Q.X >= T.X and Q.Y >= T.Y and Q.X <= T.X + U.X and Q.Y <= T.Y + U.Y
                        end
                        if not R(P.panel) and not R(P.anchor) then
                            o:_closePopover()
                        end
                    end
                    if P and (N.KeyCode == Enum.KeyCode.Escape or N.KeyCode == Enum.KeyCode.ButtonB) then
                        o:_closePopover()
                    end
                end)
                local function N()
                    local O, P = workspace.CurrentCamera, Vector2.new(1920, 1080)
                    if O then
                        P = O.ViewportSize
                    end
                    return Vector2.new(math.max(P.X - b * 2, 0), math.max(P.Y - b * 2, 0))
                end
                o._fit = 1
                local function O(P)
                    return math.clamp(math.min(P.X / az.X, P.Y / az.Y), 0.4, 1)
                end
                local function P(Q)
                    local R = N() / o._fit
                    local S, T = math.min(math.max(Q.X, az.X), R.X), math.min(math.max(Q.Y, az.Y), R.Y)
                    return Vector2.new(math.floor(S / 2) * 2, math.floor(T / 2) * 2)
                end
                local function Q(R)
                    q.Size = UDim2.fromOffset(R.X, R.Y)
                end
                local R = nil
                function o._zoom()
                    local S, T = R ~= nil, "maximize-2"
                    if S then
                        local U = R
                        R = nil
                        ae.Tween(q, { Size = U.size, Position = U.position }, c)
                    else
                        R = { size = q.Size, position = q.Position }
                        local U, V = P(N() / o._fit), p.AbsoluteSize
                        T = "minimize-2"
                        ae.Tween(q, {
                            Size = UDim2.fromOffset(U.X, U.Y),
                            Position = UDim2.fromOffset(math.floor(V.X / 2), math.floor(V.Y / 2)),
                        }, c)
                    end
                    if o._zoomGlyph then
                        o._zoomGlyph.Image = l:Icon(T) or ""
                    end
                end
                m:Connect(ad.RenderStepped, function()
                    if o._popover then
                        o:_placePopover()
                    end
                    local S = J
                    if not (S and K) then
                        return
                    end
                    local T = K - S.start
                    if S.kind == "custom" then
                        local U = K
                        K = nil
                        (S.move)(U)
                        return
                    end
                    K = nil
                    if S.kind == "move" then
                        q.Position = S.position + UDim2.fromOffset(math.round(T.X), math.round(T.Y))
                    else
                        local U, V = T.X / o._fit, T.Y / o._fit
                        if S.kind == "resizeY" then
                            U = 0
                        elseif S.kind == "resizeX" then
                            V = 0
                        end
                        local W = P(S.size + Vector2.new(U, V))
                        local X = (W - S.size) * o._fit
                        Q(W)
                        o._preferred = W
                        q.Position = S.position + UDim2.fromOffset(math.round(X.X / 2), math.round(X.Y / 2))
                    end
                end)
                o._preferred = Vector2.new(q.Size.X.Offset, q.Size.Y.Offset)
                local function S()
                    local T = N()
                    local U = O(T)
                    o._fit = U
                    if o._scale then
                        o._scale.Scale = U
                    end
                    local V = P(o._preferred)
                    if R ~= nil then
                        V = P(T / U)
                    end
                    Q(V)
                    local W = p.AbsoluteSize
                    if W.X < 1 or W.Y < 1 then
                        return
                    end
                    local X, Y = q.Position, V * U / 2
                    local Z, _, aB, aC, aD, aE =
                        X.X.Scale * W.X + X.X.Offset,
                        X.Y.Scale * W.Y + X.Y.Offset,
                        Y.X + b,
                        W.X - Y.X - b,
                        Y.Y + b,
                        W.Y - Y.Y - b
                    if aB > aC then
                        Z = W.X / 2
                    else
                        Z = math.clamp(Z, aB, aC)
                    end
                    if aD > aE then
                        _ = W.Y / 2
                    else
                        _ = math.clamp(_, aD, aE)
                    end
                    q.Position = UDim2.fromOffset(math.round(Z), math.round(_))
                end
                o._fitToScreen = S
                local aB, aC = nil, nil
                local function aD()
                    local aE = workspace.CurrentCamera
                    if aE == aB then
                        return
                    end
                    aB = aE
                    if aC then
                        aC:Disconnect()
                    end
                    if aE then
                        aC = m:Connect(aE:GetPropertyChangedSignal("ViewportSize"), S)
                    end
                    S()
                end
                m:Connect(workspace:GetPropertyChangedSignal("CurrentCamera"), aD)
                m:Connect(p:GetPropertyChangedSignal("AbsoluteSize"), S)
                task.defer(aD)
                if n.Resizable ~= false then
                    local aE, T, U = ac.TouchEnabled and not ac.MouseEnabled, 10, 22
                    if aE then
                        T = 28
                        U = 44
                    end
                    local function V(W, X, Y, Z, _)
                        local aF = ar("TextButton", {
                            Name = W,
                            Text = "",
                            BackgroundTransparency = 1,
                            AutoButtonColor = false,
                            AnchorPoint = Y,
                            Position = Z,
                            Size = _,
                            ZIndex = 8,
                            Parent = q,
                        })
                        m:Connect(aF.InputBegan, function(aG)
                            M(X, aG)
                        end)
                        return aF
                    end
                    V(
                        "ResizeRight",
                        "resizeX",
                        Vector2.new(0.3, 0),
                        UDim2.new(1, 0, 0, av),
                        UDim2.new(0, T, 1, -(av + U / 2))
                    )
                    V(
                        "ResizeBottom",
                        "resizeY",
                        Vector2.new(0, 0.3),
                        UDim2.new(0, ae.Radius.Xl, 1, 0),
                        UDim2.new(1, -(ae.Radius.Xl + U / 2), 0, T)
                    )
                    local aF, aG, W, X =
                        V("Resize", "resize", Vector2.new(0.5, 0.5), UDim2.fromScale(1, 1), UDim2.fromOffset(U, U)),
                        11,
                        4,
                        3
                    if aE then
                        aG = 14
                        X = 4
                    end
                    local Y = ar("Frame", {
                        Name = "ResizeArc",
                        BackgroundTransparency = 1,
                        ClipsDescendants = true,
                        AnchorPoint = Vector2.new(1, 1),
                        Position = UDim2.new(1, -W, 1, -W),
                        Size = UDim2.fromOffset(aG + X, aG + X),
                        ZIndex = 7,
                        Parent = r,
                    })
                    local Z = ar("Frame", {
                        Name = "Ring",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(1, 1),
                        Position = UDim2.fromScale(1, 1),
                        Size = UDim2.fromOffset((aG + X) * 2, (aG + X) * 2),
                        ZIndex = 7,
                        Parent = Y,
                    }, { ag.Corner(aG + X) })
                    local _, aH =
                        ar("UIStroke", {
                            Color = as.MutedForeground,
                            Thickness = X,
                            Transparency = 0.55,
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                            Parent = Z,
                        }), 0.55
                    if aE then
                        aH = 0.25
                    end
                    _.Transparency = aH
                    m:Connect(aF.MouseEnter, function()
                        ae.Rebind(_, "Color", "Foreground")
                        ae.Tween(_, { Transparency = 0.15 })
                    end)
                    m:Connect(aF.MouseLeave, function()
                        ae.Rebind(_, "Color", "MutedForeground")
                        ae.Tween(_, { Transparency = aH })
                    end)
                    local aI = nil
                    m:Connect(ac.TouchPinch, function(aJ, aK, aL, aM)
                        if aM == Enum.UserInputState.Begin then
                            aI = nil
                            local aN, aO, aP = q.AbsolutePosition, q.AbsoluteSize, #aJ > 0
                            for aQ, aR in ipairs(aJ) do
                                if aR.X < aN.X or aR.Y < aN.Y or aR.X > aN.X + aO.X or aR.Y > aN.Y + aO.Y then
                                    aP = false
                                end
                            end
                            if aP and o._visible then
                                aI = aO
                                o:_closePopover()
                            end
                        elseif aM == Enum.UserInputState.Change and aI then
                            Q(P(aI * aK))
                        else
                            aI = nil
                        end
                    end)
                end
                local function aE()
                    Q(P(q.AbsoluteSize))
                end
                local function aF()
                    local aG = workspace.CurrentCamera
                    if aG then
                        m:Connect(aG:GetPropertyChangedSignal("ViewportSize"), aE)
                    end
                end
                aF()
                m:Connect(workspace:GetPropertyChangedSignal("CurrentCamera"), aF)
                o._collapsed = false
                o._userCollapsed = nil
                local aG = false
                m:Connect(q:GetPropertyChangedSignal("AbsoluteSize"), function()
                    local aH = q.AbsoluteSize.X < aA
                    if aH ~= aG then
                        aG = aH
                        o._userCollapsed = nil
                        o:SetSidebarCollapsed(aH)
                    elseif o._userCollapsed == nil then
                        o:SetSidebarCollapsed(aH)
                    end
                end)
                Q(P(Vector2.new(q.Size.X.Offset, q.Size.Y.Offset)))
                if n.Island ~= false then
                    o._island = al.new(m, p, {
                        Title = o.Title,
                        Icon = n.Icon,
                        Library = l,
                        Hint = function()
                            return o._toggleKey.Name
                        end,
                        Open = function()
                            o:SetVisible(true)
                        end,
                    })
                end
                p.Parent = ag.GuiParent()
                local aH = Vector2.new(1920, 1080)
                if workspace.CurrentCamera then
                    aH = workspace.CurrentCamera.ViewportSize
                end
                q.Position = UDim2.fromOffset(math.floor(aH.X / 2), math.floor(aH.Y / 2))
                if q.AbsoluteSize.X < aA then
                    aG = true
                    o:SetSidebarCollapsed(true)
                end
                o._scale = ar("UIScale", { Scale = 0.96 * o._fit, Parent = q })
                ae.Tween(
                    o._scale,
                    { Scale = o._fit },
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                )
                if n.Glass then
                    o:SetGlass(true)
                end
                if n.Loading then
                    o:SetLoading(true)
                end
                return o
            end
            local aB, aC, aE, aF =
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                0.25,
                0.6
            local function aG(aH, aI, aJ, aK, aL)
                local aM = ar("Frame", {
                    Name = "Bar",
                    BackgroundColor3 = as.Muted,
                    BackgroundTransparency = aE,
                    BorderSizePixel = 0,
                    Position = aI,
                    Size = aJ,
                    ZIndex = 21,
                    Parent = aH,
                }, { ag.Corner(aK) })
                table.insert(aL, aM)
                return aM
            end
            function d:SetLoading(aH)
                if aH then
                    if self._skeleton then
                        return
                    end
                    local aI, aJ, aK =
                        {}, {}, ar("Frame", {
                            Name = "Skeleton",
                            BackgroundTransparency = 1,
                            Position = self._nav.Position,
                            Size = self._nav.Size,
                            ZIndex = 20,
                            Parent = self._nav.Parent,
                        })
                    for aL = 0, 7 do
                        local aM, aN = 12 + aL * 36, ({ 0.55, 0.42, 0.6, 0.5, 0.38, 0.58, 0.46, 0.52 })[aL + 1]
                        aG(aK, UDim2.fromOffset(16, aM), UDim2.fromOffset(16, 16), ae.Radius.Sm, aI)
                        aG(aK, UDim2.new(0, 42, 0, aM + 3), UDim2.new(aN, -42, 0, 10), ae.Radius.Full, aI)
                    end
                    local aL = ar("Frame", {
                        Name = "Skeleton",
                        BackgroundColor3 = as.Background,
                        BackgroundTransparency = 0,
                        BorderSizePixel = 0,
                        Position = self._pages.Position,
                        Size = self._pages.Size,
                        ZIndex = 20,
                        Parent = self._pages.Parent,
                    })
                    aG(aL, UDim2.fromOffset(20, 18), UDim2.new(0.32, 0, 0, 14), ae.Radius.Full, aI)
                    aG(aL, UDim2.fromOffset(20, 40), UDim2.new(0.5, 0, 0, 10), ae.Radius.Full, aI)
                    local aM = {}
                    for aN = 0, 1 do
                        local aO = ar("Frame", {
                            Name = "Card",
                            BackgroundColor3 = as.Card,
                            BorderSizePixel = 0,
                            Position = UDim2.fromOffset(16, 70 + aN * 150),
                            Size = UDim2.new(1, -32, 0, 134),
                            ZIndex = 21,
                            Parent = aL,
                        }, { ag.Corner(ae.Radius.Xl) })
                        table.insert(aM, aO)
                        for aP = 0, 2 do
                            local aQ = 16 + aP * 40
                            aG(aO, UDim2.fromOffset(16, aQ), UDim2.new(0.38, 0, 0, 12), ae.Radius.Full, aI).ZIndex = 22
                            aG(aO, UDim2.fromOffset(16, aQ + 18), UDim2.new(0.56, 0, 0, 9), ae.Radius.Full, aI).ZIndex =
                                22
                            aG(aO, UDim2.new(1, -60, 0, aQ + 4), UDim2.fromOffset(44, 20), ae.Radius.Full, aI).ZIndex =
                                22
                        end
                    end
                    for aN, aO in ipairs(aI) do
                        local aP = aq:Create(aO, aB, { BackgroundTransparency = aF })
                        aP:Play()
                        table.insert(aJ, aP)
                    end
                    self._nav.Visible = false
                    self._skeleton = { nav = aK, page = aL, bars = aI, cards = aM, tweens = aJ }
                    return
                end
                local aI = self._skeleton
                if not aI then
                    return
                end
                self._skeleton = nil
                self._nav.Visible = true
                for aJ, aK in ipairs(aI.tweens) do
                    aK:Cancel()
                end
                for aJ, aK in ipairs(aI.bars) do
                    ae.Tween(aK, { BackgroundTransparency = 1 }, aC)
                end
                for aJ, aK in ipairs(aI.cards) do
                    ae.Tween(aK, { BackgroundTransparency = 1 }, aC)
                end
                ae.Tween(aI.page, { BackgroundTransparency = 1 }, aC)
                task.delay(aC.Time + 0.05, function()
                    aI.nav:Destroy()
                    aI.page:Destroy()
                end)
            end
            function d:_buildFooter(aH, aI, aJ)
                local aK, aL, aM = self._maid, ab.LocalPlayer, {}
                if type(aI) == "table" then
                    aM = aI
                end
                local aN, aO = aM.Title, aM.Subtitle
                if not aN and aL then
                    aN = aL.DisplayName
                    if aM.Mask ~= false then
                        aN = h(aN)
                    end
                end
                local aP = ar("Frame", {
                    Name = "Footer",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.fromScale(0, 1),
                    Size = UDim2.new(1, -1, 0, aJ),
                    ZIndex = 3,
                    Parent = aH,
                }, { ag.Padding(8, 8, 8, 10) })
                local aQ = ar("TextButton", {
                    Name = "User",
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundColor3 = as.SidebarAccent,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    ClipsDescendants = true,
                    ZIndex = 4,
                    Parent = aP,
                }, { ag.Corner(ae.Radius.Md) })
                local aR = ar("ImageLabel", {
                    Name = "Avatar",
                    BackgroundColor3 = as.Muted,
                    BorderSizePixel = 0,
                    Image = "",
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.fromOffset(32, 32),
                    ZIndex = 5,
                    Parent = aQ,
                }, { ag.Corner(ae.Radius.Lg) })
                if aM.Image then
                    aR.Image = self.Library:Icon(aM.Image) or aM.Image
                elseif aL then
                    task.spawn(function()
                        local l, m = pcall(function()
                            return ab:GetUserThumbnailAsync(
                                aL.UserId,
                                Enum.ThumbnailType.HeadShot,
                                Enum.ThumbnailSize.Size100x100
                            )
                        end)
                        if l and aR.Parent then
                            aR.Image = m
                        end
                    end)
                end
                local l = ar("Frame", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(40, 0),
                    Size = UDim2.new(1, -64, 1, 0),
                    ZIndex = 5,
                    Parent = aQ,
                }, {
                    ar(
                        "UIListLayout",
                        { VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder }
                    ),
                })
                ag.Text({
                    Name = "Name",
                    Text = aN or "",
                    TextColor3 = as.SidebarForeground,
                    FontFace = af.Medium,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    Size = UDim2.new(1, 0, 0, 18),
                    LayoutOrder = 1,
                    ZIndex = 5,
                    Parent = l,
                })
                if aO then
                    ag.Text({
                        Name = "Subtitle",
                        Text = aO,
                        TextColor3 = as.MutedForeground,
                        TextSize = ae.TextSize.Xs,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(1, 0, 0, 16),
                        LayoutOrder = 2,
                        ZIndex = 5,
                        Parent = l,
                    })
                end
                self._footerText = l
                local m = self.Library:Icon("chevrons-up-down")
                if m then
                    self._footerChevron = ar("ImageLabel", {
                        Name = "Chevron",
                        BackgroundTransparency = 1,
                        Image = m,
                        ImageColor3 = as.MutedForeground,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -8, 0.5, 0),
                        Size = UDim2.fromOffset(18, 18),
                        ZIndex = 5,
                        Parent = aQ,
                    })
                end
                aK:Connect(aQ.MouseEnter, function()
                    ae.Tween(aQ, { BackgroundTransparency = 0 })
                end)
                aK:Connect(aQ.MouseLeave, function()
                    if not self._footerOpen then
                        ae.Tween(aQ, { BackgroundTransparency = 1 })
                    end
                end)
                aK:Connect(aQ.MouseButton1Click, function()
                    if self._footerOpen then
                        self:_closePopover()
                        return
                    end
                    self._footerOpen = true
                    ae.Tween(aQ, {
                        BackgroundTransparency = 0,
                    })
                    local n, o =
                        self:_menu({ {
                            Title = "Toggle theme",
                            Icon = "sun-moon",
                            Callback = function()
                                local n = "Dark"
                                if ae.Mode == "Dark" then
                                    n = "Light"
                                end
                                self.Library:SetTheme(n)
                            end,
                        }, {
                            Title = "Hide",
                            Icon = "eye-off",
                            Shortcut = self._toggleKey.Name,
                            Callback = function()
                                self:SetVisible(false)
                            end,
                        }, false, {
                            Title = "Close",
                            Icon = "log-out",
                            Destructive = true,
                            Callback = function()
                                self:Destroy("Close")
                            end,
                        } }, aN, aO), "top"
                    if self._collapsed then
                        o = "right"
                    end
                    self:_openPopover(n, aQ, function()
                        self._footerOpen = false
                        ae.Tween(aQ, { BackgroundTransparency = 1 })
                        n:Destroy()
                    end, o)
                end)
                self._footer = aP
            end
            function d:_menu(aH, aI, aJ)
                local aK, aL =
                    ar("Frame", {
                        Name = "Menu",
                        BackgroundColor3 = as.Popover,
                        BackgroundTransparency = 0.04,
                        BorderSizePixel = 0,
                        Size = UDim2.fromOffset(224, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        ZIndex = 21,
                    }, { ag.Corner(ae.Radius.Lg), ag.Stroke(as.Border), ag.Padding(4), ag.List(0) }), 0
                local function aM()
                    aL += 1
                    return aL
                end
                if aI then
                    local aN = ar("Frame", {
                        Name = "Label",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = aM(),
                        ZIndex = 22,
                        Parent = aK,
                    }, { ag.Padding(6, 8, 6, 8), ag.List(0) })
                    ag.Text({
                        Text = aI,
                        FontFace = af.Medium,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(1, 0, 0, 18),
                        LayoutOrder = 1,
                        ZIndex = 22,
                        Parent = aN,
                    })
                    if aJ then
                        ag.Text({
                            Text = aJ,
                            TextColor3 = as.MutedForeground,
                            TextSize = ae.TextSize.Xs,
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            Size = UDim2.new(1, 0, 0, 16),
                            LayoutOrder = 2,
                            ZIndex = 22,
                            Parent = aN,
                        })
                    end
                    ar("Frame", {
                        Name = "Separator",
                        BackgroundColor3 = as.Border,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 8, 0, 1),
                        Position = UDim2.fromOffset(-4, 0),
                        LayoutOrder = aM(),
                        ZIndex = 22,
                        Parent = aK,
                    })
                end
                for aN, aO in ipairs(aH) do
                    if aO == false then
                        ar("Frame", {
                            Name = "Gap",
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, 0, 0, 9),
                            LayoutOrder = aM(),
                            ZIndex = 22,
                            Parent = aK,
                        }, {
                            ar("Frame", {
                                BackgroundColor3 = as.Border,
                                BorderSizePixel = 0,
                                AnchorPoint = Vector2.new(0, 0.5),
                                Position = UDim2.new(0, -4, 0.5, 0),
                                Size = UDim2.new(1, 8, 0, 1),
                                ZIndex = 22,
                            }),
                        })
                    else
                        local aP = as.Foreground
                        if aO.Destructive then
                            aP = as.Destructive
                        end
                        local aQ, aR, l =
                            ar("TextButton", {
                                Name = aO.Title,
                                Text = "",
                                AutoButtonColor = false,
                                BackgroundColor3 = as.Accent,
                                BackgroundTransparency = 1,
                                BorderSizePixel = 0,
                                Size = UDim2.new(1, 0, 0, 32),
                                LayoutOrder = aM(),
                                ZIndex = 22,
                                Parent = aK,
                            }, { ag.Corner(ae.Radius.Md), ag.Padding(0, 8, 0, 8) }), self.Library:Icon(aO.Icon), 0
                        if aR then
                            l = 26
                            ar("ImageLabel", {
                                BackgroundTransparency = 1,
                                Image = aR,
                                ImageColor3 = aP,
                                AnchorPoint = Vector2.new(0, 0.5),
                                Position = UDim2.fromScale(0, 0.5),
                                Size = UDim2.fromOffset(18, 18),
                                ZIndex = 23,
                                Parent = aQ,
                            })
                        end
                        ag.Text({
                            Text = aO.Title,
                            TextColor3 = aP,
                            Position = UDim2.fromOffset(l, 0),
                            Size = UDim2.new(1, -l, 1, 0),
                            ZIndex = 23,
                            Parent = aQ,
                        })
                        if aO.Shortcut then
                            ag.Text({
                                Text = aO.Shortcut,
                                TextColor3 = as.MutedForeground,
                                TextSize = ae.TextSize.Xs,
                                TextXAlignment = Enum.TextXAlignment.Right,
                                Size = UDim2.fromScale(1, 1),
                                ZIndex = 23,
                                Parent = aQ,
                            })
                        end
                        if aO.Disabled then
                            for m, n in ipairs(aQ:GetChildren()) do
                                if n:IsA("TextLabel") then
                                    n.TextTransparency = 0.5
                                elseif n:IsA("ImageLabel") then
                                    n.ImageTransparency = 0.5
                                end
                            end
                        end
                        aQ.MouseEnter:Connect(function()
                            if not aO.Disabled then
                                ae.Tween(aQ, { BackgroundTransparency = 0 })
                            end
                        end)
                        aQ.MouseLeave:Connect(function()
                            ae.Tween(aQ, {
                                BackgroundTransparency = 1,
                            })
                        end)
                        aQ.MouseButton1Click:Connect(function()
                            if aO.Disabled then
                                return
                            end
                            self:_closePopover()
                            if aO.Callback then
                                task.spawn(aO.Callback)
                            end
                        end)
                    end
                end
                return aK
            end
            function d:Track(aH)
                return self._maid:Give(aH)
            end
            function d:SetToggleKey(aH)
                if typeof(aH) == "EnumItem" then
                    self._toggleKey = aH
                else
                    self._toggleKey = (Enum.KeyCode)[aH]
                end
            end
            function d:GetFlag(aH, aI)
                if self.Config then
                    local aJ = self.Config:Get(aH)
                    if aJ ~= nil then
                        return aJ
                    end
                end
                return aI
            end
            function d:SetFlag(aH, aI)
                local aJ = self.Controls[aH]
                if aJ and aJ.Value ~= aI then
                    aJ:Set(aI)
                    return
                end
                self:_saveFlag(aH, aI)
            end
            function d:SaveProfile(aH)
                if not self.Config then
                    return false
                end
                return self.Config:SaveProfile(aH)
            end
            function d:LoadProfile(aH)
                if not self.Config then
                    return false
                end
                local aI = self.Config:ReadProfile(aH)
                if not aI then
                    return false
                end
                local aJ = { Data = aI }
                for aK in pairs(self.Controls) do
                    local aL = ai.Get(aJ, aK)
                    if aL ~= nil then
                        self:SetFlag(aK, aL)
                    end
                end
                self.Library:_applySavedTheme(aI.__shadcn)
                return true
            end
            function d:_saveFlag(aH, aI)
                if self.Config then
                    self.Config:Set(aH, aI)
                end
            end
            function d:AddGroup(aH)
                local aI = #self._groups + 1
                local aJ, aK =
                    ar("Frame", {
                        Name = aH or "Group",
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        LayoutOrder = aI,
                        ZIndex = 3,
                        Parent = self._nav,
                    }, { ag.Padding(8, 8, 0, 8), ag.List(0) }), nil
                if aH and aH ~= "" then
                    aK = ag.Text({
                        Name = "Label",
                        Text = aH,
                        TextColor3 = as.SidebarForeground,
                        TextTransparency = 0.3,
                        FontFace = af.Bold,
                        TextSize = ae.TextSize.Xs,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Size = UDim2.new(1, 0, 0, aw),
                        LayoutOrder = 0,
                        ZIndex = 4,
                        Parent = aJ,
                    })
                    ag.Padding(0, 8, 0, 8).Parent = aK
                end
                local aL = ar("Frame", {
                    Name = "Menu",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 1,
                    ZIndex = 3,
                    Parent = aJ,
                }, { ag.List(2) })
                local aM = { Title = aH, Instance = aJ, _label = aK, _menu = aL, _window = self }
                function aM.AddTab(aN, aO, aP)
                    return self:_addTab(aM, aO, aP)
                end
                table.insert(self._groups, aM)
                if aK and self._collapsed then
                    aK.Size = UDim2.new(1, 0, 0, 0)
                    aK.TextTransparency = 1
                end
                return aM
            end
            function d:AddTab(aH, aI)
                local aJ, aK = nil, nil
                if type(aH) == "table" then
                    aK = aH.Group
                end
                if aK then
                    for aL, aM in ipairs(self._groups) do
                        if aM.Title == aK then
                            aJ = aM
                        end
                    end
                    if not aJ then
                        aJ = self:AddGroup(aK)
                    end
                else
                    aJ = self._defaultGroup
                    if not aJ then
                        aJ = self:AddGroup(self._navLabel)
                        self._defaultGroup = aJ
                    end
                end
                return self:_addTab(aJ, aH, aI)
            end
            function d:_addTab(aH, aI, aJ)
                local aK = {}
                if type(aI) == "string" then
                    aK = { Title = aI, Icon = aJ }
                else
                    aK = aI
                end
                local aL = #self._tabs + 1
                local aM, aN = aK.Title or ("Tab " .. aL), self._maid
                local aO, aP, aQ, aR, l, m =
                    ar("TextButton", {
                        Name = aM,
                        BackgroundColor3 = as.SidebarAccent,
                        BackgroundTransparency = 1,
                        AutoButtonColor = false,
                        BorderSizePixel = 0,
                        Text = "",
                        Size = UDim2.new(1, 0, 0, ax),
                        ClipsDescendants = true,
                        LayoutOrder = aL,
                        ZIndex = 4,
                        Parent = aH._menu,
                    }, { ag.Corner(ae.Radius.Md) }), self._tabIcons ~= "Plain", self.Library:Icon(aK.Icon) ~= nil, nil, nil, nil
                if not aQ then
                    ag.Padding(0, 8, 0, 10).Parent = aO
                    aR = g(self.Library, aO, nil, aM, as.SidebarForeground)
                    aR.Visible = self._collapsed == true
                    aR.Position = UDim2.new(0, -3, 0.5, 0)
                    m = -8
                elseif self._tabIcons == "Accent" then
                    ag.Padding(0, 8, 0, 10).Parent = aO
                    aR = g(self.Library, aO, aK.Icon, aM, as.MutedForeground)
                    aR.Size = UDim2.fromOffset(f, f)
                    m = f
                    ar("Frame", {
                        Name = "AccentBar",
                        BackgroundColor3 = as.Primary,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Position = UDim2.new(0, -10, 0.5, 0),
                        Size = UDim2.new(0, 3, 0.6, 0),
                        Visible = false,
                        ZIndex = 5,
                        Parent = aO,
                    }, { ar("UICorner", { CornerRadius = UDim.new(1, 0) }) })
                elseif aP then
                    ag.Padding(0, 8, 0, 3).Parent = aO
                    l, aR = am.new(aO, aK.Icon, aM, am.Color(aK.Color, aL), i, j)
                    m = i
                else
                    ag.Padding(0, 8, 0, 8).Parent = aO
                    aR = g(self.Library, aO, aK.Icon, aM, as.SidebarForeground)
                    m = e
                end
                local n, o =
                    ag.Text({
                        Text = aM,
                        FontFace = af.Regular,
                        TextSize = ae.TextSize.Title,
                        TextColor3 = as.SidebarForeground,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        Position = UDim2.fromOffset(m + 8, 0),
                        Size = UDim2.new(1, -(m + 8), 1, 0),
                        ZIndex = 5,
                        Parent = aO,
                    }), ag.Text({
                        Name = "Badge",
                        Text = "",
                        TextColor3 = as.SidebarForeground,
                        FontFace = af.Medium,
                        TextSize = ae.TextSize.Xs,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, 4, 0.5, 0),
                        AutomaticSize = Enum.AutomaticSize.X,
                        Size = UDim2.fromOffset(20, 20),
                        Visible = false,
                        ZIndex = 5,
                        Parent = aO,
                    })
                ar("UISizeConstraint", { MinSize = Vector2.new(20, 20), Parent = o })
                ag.Padding(0, 4, 0, 4).Parent = o
                local p = ar("ScrollingFrame", {
                    Name = aM,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    CanvasSize = UDim2.new(),
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 4,
                    ScrollBarImageColor3 = as.Border,
                    ScrollingDirection = Enum.ScrollingDirection.Y,
                    ZIndex = 2,
                }, { ag.Padding(17), ag.List(25) })
                local q = ap.new(self, p, aO, n, aM)
                q.Description = aK.Description
                q.Group = aH
                q._icon = aR
                q._tile = l
                q._iconless = not aQ
                q._badge = o
                if aK.Badge ~= nil then
                    q:SetBadge(aK.Badge)
                end
                if self._collapsed then
                    n.TextTransparency = 1
                    o.Visible = false
                end
                aN:Connect(aO.MouseEnter, function()
                    if self._selected ~= q then
                        self:_paintTab(q, true)
                    end
                    if self._collapsed then
                        self:_showTooltip(aO, q.Title)
                    end
                end)
                aN:Connect(aO.MouseLeave, function()
                    if self._selected ~= q then
                        self:_paintTab(q, false)
                    end
                    self._tooltip.Visible = false
                end)
                aN:Connect(aO.MouseButton1Click, function()
                    self:SelectTab(q)
                end)
                table.insert(self._tabs, q)
                if not self._selected then
                    self:SelectTab(q)
                end
                return q
            end
            function d:_paintTab(aH, aI, aJ)
                local aK = aJ
                if aK == nil then
                    aK = self._selected == aH
                end
                local aL, aM, aN, aO = aH._item, self._glassOn == true, 1, self._tabIcons == "Accent"
                if aO then
                    if aK then
                        ae.Rebind(aL, "BackgroundColor3", "Primary")
                        aN = 0.88
                    else
                        ae.Rebind(aL, "BackgroundColor3", "Foreground")
                        if aI then
                            aN = 0.95
                        end
                    end
                elseif aM then
                    ae.Rebind(aL, "BackgroundColor3", "Foreground")
                    if aK then
                        aN = 0.88
                    elseif aI then
                        aN = 0.94
                    end
                else
                    ae.Rebind(aL, "BackgroundColor3", "SidebarAccent")
                    if aK then
                        aN = 0
                    elseif aI then
                        aN = 0.4
                    end
                end
                ae.Tween(aL, { BackgroundTransparency = aN })
                local aP = (aL:FindFirstChild("GlassRim"))
                if aM and aK and not aO and not aP then
                    aP = ar("UIStroke", {
                        Name = "GlassRim",
                        Color = as.Foreground,
                        Thickness = 1,
                        Transparency = 0.88,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                        Parent = aL,
                    })
                end
                if aP then
                    aP.Enabled = aM and aK and not aO
                end
                if self._tabIcons == "Accent" and aH._icon and not aH._iconless then
                    local aQ = "MutedForeground"
                    if aK then
                        aQ = "Primary"
                    elseif aI then
                        aQ = "SidebarForeground"
                    end
                    if aH._icon:IsA("ImageLabel") then
                        ae.Rebind(aH._icon, "ImageColor3", aQ)
                    else
                        ae.Rebind(aH._icon, "TextColor3", aQ)
                    end
                    local aR = (aL:FindFirstChild("AccentBar"))
                    if aR then
                        aR.Visible = aK == true
                    end
                end
            end
            function d:_showTooltip(aH, aI)
                local aJ, aK = self._tooltip, self._overlay.AbsolutePosition
                aJ.Text = aI
                aJ.Position = UDim2.fromOffset(
                    aH.AbsolutePosition.X + aH.AbsoluteSize.X + 10 - aK.X,
                    aH.AbsolutePosition.Y + aH.AbsoluteSize.Y / 2 - aK.Y
                )
                aJ.Visible = true
            end
            function d:SelectTab(aH)
                if self._selected == aH then
                    return
                end
                local aI = self._selected
                self:_closePopover()
                if aI then
                    aI._page.Parent = nil
                    aI._label.FontFace = af.Regular
                    if not aI._tile then
                        ae.Rebind(aI._icon, k(aI._icon), "SidebarForeground")
                    end
                    self:_paintTab(aI, false, false)
                end
                self._selected = aH
                aH._label.FontFace = af.Regular
                if not aH._tile then
                    ae.Rebind(aH._icon, k(aH._icon), "SidebarPrimary")
                end
                self:_paintTab(aH, false)
                local aJ = aH.Group and aH.Group.Title
                local aK = type(aJ) == "string" and aJ ~= ""
                self._crumbGroup.Text = aJ or ""
                self._crumbGroup.Visible = aK
                self._crumbChevron.Visible = aK
                self._heading.Text = aH.Title
                self._subheading.Text = aH.Description or ""
                self._subheading.Visible = (aH.Description or "") ~= ""
                aH._page.Position = UDim2.fromOffset(0, 6)
                aH._page.Parent = self._pages
                ae.Tween(aH._page, { Position = UDim2.fromOffset(0, 0) })
            end
            function d:SetSidebarCollapsed(aH, aI)
                if aI then
                    self._userCollapsed = aH
                end
                if self._collapsed == aH then
                    return
                end
                self._collapsed = aH
                -- Hide the whole brand text block in compact mode, including Subtitle.
                local brand = self._brand and self._brand:FindFirstChild("Brand")
                local brandText = brand and brand:FindFirstChild("Text")
                if brandText then
                    brandText.Visible = not aH
                end
                self._tooltip.Visible = false
                self:_closePopover()
                local aJ, aK = at, 0
                if aH then
                    aJ = au
                    aK = 1
                end
                ae.Tween(self._sidebar, { Size = UDim2.new(0, aJ, 1, 0) }, c)
                self._main.Position = UDim2.fromOffset(aJ, 0)
                self._main.Size = UDim2.new(1, -aJ, 1, 0)
                for aL, aM in ipairs(self._groups) do
                    local aN = aM._label
                    if aN then
                        local aO = aw
                        if aH then
                            aO = 0
                        end
                        ae.Tween(aN, {
                            TextTransparency = 0.3 + 0.7 * aK,
                            Size = UDim2.new(1, 0, 0, aO),
                        }, c)
                    end
                end
                for aL, aM in ipairs(self._tabs) do
                    ae.Tween(aM._label, { TextTransparency = aK }, c)
                    if aM._iconless then
                        aM._icon.Visible = aH
                    end
                    aM._badge.Visible = not aH and aM._badge.Text ~= ""
                end
                if self._footerText then
                    self._footerText.Visible = not aH
                end
                if self._footerChevron then
                    self._footerChevron.Visible = not aH
                end
            end
            function d:_openPopover(aH, aI, aJ, aK)
                self:_closePopover()
                aH.Parent = self._overlay
                self._popover = { panel = aH, anchor = aI, onClose = aJ, placement = aK or "bottom" }
                self:_placePopover()
            end
            function d:_closePopover()
                local aH = self._popover
                if not aH then
                    return
                end
                self._popover = nil
                aH.panel.Parent = nil
                if aH.onClose then
                    task.spawn(aH.onClose)
                end
            end
            function d:_placePopover()
                local aH = self._popover
                if not aH then
                    return
                end
                local aI, aJ = aH.anchor, aH.panel
                if not aI:IsDescendantOf(self.Instance) or not aI.Visible or not self._visible then
                    self:_closePopover()
                    return
                end
                local aK, aL = workspace.CurrentCamera, Vector2.new(1920, 1080)
                if aK then
                    aL = aK.ViewportSize
                end
                local aM, aN, aO, aP, aQ = aI.AbsolutePosition, aI.AbsoluteSize, aJ.AbsoluteSize, nil, nil
                if aH.placement == "top" then
                    aP = aM.X
                    aQ = aM.Y - 4 - aO.Y
                elseif aH.placement == "right" then
                    aP = aM.X + aN.X + 8
                    aQ = aM.Y + aN.Y - aO.Y
                else
                    aQ = aM.Y + aN.Y + 4
                    if aQ + aO.Y > aL.Y - 8 and aM.Y - 4 - aO.Y > 8 then
                        aQ = aM.Y - 4 - aO.Y
                    end
                    aP = aM.X + aN.X - aO.X
                end
                local aR = self._overlay.AbsolutePosition
                aP = math.clamp(aP, 8, math.max(8, aL.X - aO.X - 8)) - aR.X
                aQ = math.clamp(aQ, 8 + aR.Y, math.max(8 + aR.Y, aL.Y + aR.Y - aO.Y - 8)) - aR.Y
                aJ.Position = UDim2.fromOffset(aP, aQ)
            end
            function d:Dialog(aH)
                if not self._visible then
                    self:SetVisible(true)
                end
                return an.open(self, aH)
            end
            function d:Confirm(aH)
                local aI, aJ, aK = coroutine.running(), false, table.clone(aH)
                aK.Buttons = nil
                aK.OnClose = function(aL)
                    if aJ then
                        return
                    end
                    aJ = true
                    task.spawn(aI, aL == 2)
                end
                self:Dialog(aK)
                return coroutine.yield()
            end
            function d:_toggleZoom()
                self._zoom()
            end
            function d:SetGlass(aH)
                aH = aH == true
                if self._glassOn == aH then
                    return
                end
                self._glassOn = aH
                local aI = 0
                if aH then
                    aI = 0.15
                    if ae.Mode ~= "Dark" then
                        aI = 0.2
                    end
                    self._root.BackgroundTransparency = 1
                else
                    self._root.BackgroundTransparency = 0
                end
                self._surface.Visible = aH
                self._sidebarBody.BackgroundTransparency = aI
                for aJ, aK in ipairs(self._tabs) do
                    self:_paintTab(aK, false)
                end
                if aH and not self._acrylic then
                    self._acrylic = ao.new(self._maid, self._sidebar, { Right = true })
                    if self._acrylic then
                        self._acrylic.SetVisible(self._visible)
                    end
                elseif not aH and self._acrylic then
                    self._acrylic.Destroy()
                    self._acrylic = nil
                end
            end
            function d:SetVisible(aH)
                if self._destroyed or self._visible == aH then
                    return
                end
                if not aH then
                    self:_closePopover()
                    self._tooltip.Visible = false
                end
                self._visible = aH
                self._holder.Visible = aH
                if aH then
                    self._scale.Scale = 0.96 * self._fit
                    ae.Tween(self._scale, {
                        Scale = self._fit,
                    }, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
                end
                if self._island then
                    self._island:SetShown(not aH)
                end
                if self._acrylic then
                    self._acrylic.SetVisible(aH)
                end
                self.VisibilityChanged:Fire(aH)
            end
            function d:Destroy(aH)
                if self._destroyed then
                    return
                end
                self._destroyed = true
                self.Closing:Fire(aH or "Destroy")
                if self.Config then
                    self.Config:Save()
                end
                self._maid:Destroy()
                self.Closing:Destroy()
                ae.Prune()
                self.Library:_forget(self)
            end
            return d
        end
        function a.t()
            local ab = a.cache.t
            if not ab then
                ab = { c = aa() }
                a.cache.t = ab
            end
            return ab.c
        end
    end
    do
        local function aa()
            local ab, ac, ad, ae, af, ag, ah =
                game:GetService("UserInputService"),
                game:GetService("RunService"),
                a.Theme(),
                a.Fonts(),
                a.Icons(),
                a.Creator(),
                a.h()
            local ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at =
                ag.Create,
                ad.Token,
                360,
                16,
                12,
                12,
                3,
                5,
                TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {
                    Success = {
                        icon = "circle-check",
                        color = "Foreground",
                    },
                    Info = { icon = "info", color = "Foreground" },
                    Warning = { icon = "alert-circle", color = "Foreground" },
                    Error = { icon = "circle-x", color = "Destructive" },
                    Loading = { icon = "arrowTriangle2Circlepath", color = "Foreground" },
                },
                {}
            at.__index = at
            function at.new(au)
                local av, aw =
                    setmetatable({ _maid = au, _toasts = {}, _hovered = false, _nextId = 0 }, at),
                    au:Give(ai("ScreenGui", {
                        Name = "shadcn-toasts",
                        ResetOnSpawn = false,
                        IgnoreGuiInset = true,
                        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                        DisplayOrder = 200,
                    }))
                av._viewport = ai("Frame", {
                    Name = "Viewport",
                    BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 1),
                    Position = UDim2.new(1, -al, 1, -al),
                    Size = UDim2.fromOffset(ak, 0),
                    Parent = aw,
                })
                aw.Parent = ag.GuiParent()
                av.Instance = aw
                au:Connect(ac.RenderStepped, function(ax)
                    av:_step(ax)
                end)
                return av
            end
            function at:_inside()
                local au, av = ab:GetMouseLocation(), game:GetService("GuiService"):GetGuiInset()
                local aw = au - av
                for ax, ay in ipairs(self._toasts) do
                    if not ay.leaving then
                        local az, aA = ay.frame.AbsolutePosition, ay.frame.AbsoluteSize
                        if aw.X >= az.X and aw.X <= az.X + aA.X and aw.Y >= az.Y and aw.Y <= az.Y + aA.Y + am + 1 then
                            return true
                        end
                    end
                end
                return false
            end
            function at:_step(au)
                if #self._toasts == 0 then
                    return
                end
                local av = self:_inside()
                if av ~= self._hovered then
                    self._hovered = av
                    self:_layout()
                end
                if av then
                    return
                end
                for aw, ax in ipairs(table.clone(self._toasts)) do
                    if not ax.leaving and ax.remaining then
                        ax.remaining -= au
                        if ax.remaining <= 0 then
                            self:_remove(ax)
                        end
                    end
                end
            end
            local function au(av)
                return math.max(av.content.AbsoluteSize.Y / math.max(av.scale.Scale, 0.01), 48)
            end
            local function av(aw, ax)
                if aw.faded == ax then
                    return
                end
                aw.faded = ax
                ad.Tween(aw.title, { TextTransparency = ax }, ar)
                ad.Tween(aw.description, { TextTransparency = ax }, ar)
                ad.Tween(aw.icon, { ImageTransparency = ax }, ar)
                local ay = ax < 1
                if aw.action then
                    aw.action.Visible = ay
                end
                aw.closeVisible = ay
            end
            function at:_layout()
                local aw = {}
                for ax, ay in ipairs(self._toasts) do
                    if not ay.leaving then
                        table.insert(aw, ay)
                    end
                end
                local ax = aw[1]
                if not ax then
                    return
                end
                local ay, az, aA = au(ax), 0, self._hovered
                for aB, aC in ipairs(aw) do
                    local aE, aF, aG, aH, aI = aB - 1, au(aC), nil, nil, nil
                    if aA then
                        aG = -az
                        aH = 1
                        aI = 0
                        az += aF + am
                    else
                        aH = math.max(0, 1 - aE * 0.1)
                        aF = ay
                        aG = -(aE * an) - (1 - aH) * ay
                        aI = 0
                        if aE > 0 then
                            aI = 1
                        end
                    end
                    aC.frame.ZIndex = 1000 - aE
                    ad.Tween(aC.frame, { Position = UDim2.new(0.5, 0, 1, aG), Size = UDim2.new(1, 0, 0, aF) }, aq)
                    ad.Tween(aC.scale, { Scale = aH }, aq)
                    av(aC, aI)
                end
                self._viewport.Size = UDim2.fromOffset(ak, math.max(az, ay))
            end
            function at:_remove(aw)
                if aw.leaving then
                    return
                end
                aw.leaving = true
                local ax = table.find(self._toasts, aw)
                ad.Tween(
                    aw.frame,
                    { Position = aw.frame.Position + UDim2.fromOffset(0, aw.frame.AbsoluteSize.Y * 1.5 + al) },
                    aq
                )
                av(aw, 1)
                ad.Tween(aw.card, { BackgroundTransparency = 1 }, aq)
                task.delay(0.35, function()
                    local ay = table.find(self._toasts, aw)
                    if ay then
                        table.remove(self._toasts, ay)
                    end
                    aw.maid:Destroy()
                end)
                if ax then
                    self:_layout()
                end
                if aw.onClose then
                    task.spawn(aw.onClose)
                end
            end
            function at:_fill(aw, ax)
                local ay = as[ax.Type or ""]
                if aw.spin then
                    aw.spin:Cancel()
                    aw.spin = nil
                end
                aw.icon.Visible = false
                local az = af.Get(ax.Icon)
                if az and not ay then
                    ay = { icon = ax.Icon, color = "Foreground" }
                end
                if ay then
                    local aA = az or af.Get(ay.icon)
                    if aA then
                        aw.icon.Image = aA
                        aw.icon.Visible = true
                        aw.icon.Rotation = 0
                        ad.Bind(aw.icon, "ImageColor3", ay.color)
                        if ax.Type == "Loading" then
                            aw.spin = ad.Tween(
                                aw.icon,
                                { Rotation = 360 },
                                TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
                            )
                        end
                    end
                end
                aw.title.Text = ax.Title or ""
                aw.description.Text = ax.Description or ""
                aw.description.Visible = (ax.Description or "") ~= ""
                if aw.action then
                    aw.action:Destroy()
                    aw.action = nil
                end
                local aA = ax.Action
                if aA then
                    local aB = ah.new(aw.maid, {
                        Title = aA.Title or "Undo",
                        Variant = "Outline",
                        Size = "Sm",
                        LayoutOrder = 3,
                        Callback = function()
                            if aA.Callback then
                                task.spawn(aA.Callback)
                            end
                            self:_remove(aw)
                        end,
                    })
                    aB.Size = UDim2.fromOffset(aB.Size.X.Offset, 28)
                    aB.Parent = aw.row
                    aw.action = aB
                end
                local aB = ax.Duration
                if aB == nil then
                    aB = ap
                end
                if ax.Type == "Loading" or aB == math.huge or aB <= 0 then
                    aw.remaining = nil
                else
                    aw.remaining = aB
                end
            end
            function at:Add(aw)
                local ax = {}
                if type(aw) == "string" then
                    ax = { Title = aw }
                else
                    ax = aw
                end
                self._nextId += 1
                local ay = self._maid:Sub()
                local az, aA =
                    { id = self._nextId, maid = ay, leaving = false, onClose = ax.OnClose }, ay:Give(ai("Frame", {
                        Name = "Toast",
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 1),
                        Position = UDim2.new(0.5, 0, 1, 160),
                        Size = UDim2.new(1, 0, 0, 64),
                        Parent = self._viewport,
                    }))
                az.scale = ai("UIScale", { Parent = aA })
                local aB = ai("Frame", {
                    Name = "Card",
                    BackgroundColor3 = aj.Popover,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 2,
                    Parent = aA,
                }, { ag.Corner(ad.Radius.Xxl), ag.Stroke(aj.Border) })
                az.fade = ai("Frame", {
                    Name = "Fade",
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 2,
                    Parent = aB,
                })
                az.card = aB
                local aC = ai("Frame", {
                    Name = "Content",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ZIndex = 2,
                    Parent = az.fade,
                }, { ag.Padding(16) })
                local aE = ai("Frame", {
                    Name = "Row",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ZIndex = 2,
                    Parent = aC,
                }, {
                    ai("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 12),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                    }),
                })
                az.icon = ai("ImageLabel", {
                    Name = "Icon",
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(20, 20),
                    LayoutOrder = 1,
                    Visible = false,
                    ZIndex = 3,
                    Parent = aE,
                })
                local aF = ai("Frame", {
                    Name = "Text",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -110, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 2,
                    Parent = aE,
                }, { ai("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }), ag.List(4) })
                az.title = ag.Text({
                    Name = "Title",
                    Text = "",
                    TextColor3 = aj.Foreground,
                    FontFace = ae.Medium,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 18),
                    LayoutOrder = 1,
                    ZIndex = 3,
                    Parent = aF,
                })
                az.description = ag.Text({
                    Name = "Description",
                    Text = "",
                    TextColor3 = aj.MutedForeground,
                    TextWrapped = true,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 18),
                    LayoutOrder = 2,
                    ZIndex = 3,
                    Parent = aF,
                })
                local aG, aH =
                    ai("TextButton", {
                        Name = "Close",
                        Text = "",
                        AutoButtonColor = false,
                        BackgroundColor3 = aj.Popover,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromOffset(6, 6),
                        Size = UDim2.fromOffset(20, 20),
                        Visible = false,
                        ZIndex = 6,
                        Parent = aA,
                    }, { ai("UICorner", { CornerRadius = UDim.new(1, 0) }) }), ag.Stroke(aj.Border)
                aH.Transparency = 1
                aH.Parent = aG
                local aI, aJ, aK, aL, aM =
                    ai("ImageLabel", {
                        Name = "Glyph",
                        BackgroundTransparency = 1,
                        Image = af.Get("x") or "",
                        ImageColor3 = aj.MutedForeground,
                        ImageTransparency = 1,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        Size = UDim2.fromOffset(10, 10),
                        ZIndex = 7,
                        Parent = aG,
                    }), ai("UIScale", { Scale = 0.6, Parent = aG }), TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), false, false
                local function aN(aO)
                    if aO and az.closeVisible == false then
                        aO = false
                    end
                    if aO then
                        aG.Visible = true
                        ad.Tween(aG, { BackgroundTransparency = 0 }, ar)
                        ad.Tween(aH, {
                            Transparency = 0,
                        }, ar)
                        ad.Tween(aI, { ImageTransparency = 0 }, ar)
                        ad.Tween(aJ, { Scale = 1 }, aK)
                    else
                        ad.Tween(aG, { BackgroundTransparency = 1 }, ar)
                        ad.Tween(aH, { Transparency = 1 }, ar)
                        ad.Tween(aI, { ImageTransparency = 1 }, ar)
                        ad.Tween(aJ, { Scale = 0.6 }, ar)
                        task.delay(ar.Time, function()
                            if not (aL or aM) then
                                aG.Visible = false
                            end
                        end)
                    end
                end
                local function aO()
                    aN(aL or aM)
                end
                ay:Connect(aB.MouseEnter, function()
                    aL = true
                    aO()
                end)
                ay:Connect(aB.MouseLeave, function()
                    aL = false
                    aO()
                end)
                ay:Connect(aG.MouseEnter, function()
                    aM = true
                    aO()
                    ad.Rebind(aI, "ImageColor3", "Destructive")
                    ad.Rebind(aH, "Color", "Destructive")
                end)
                ay:Connect(aG.MouseLeave, function()
                    aM = false
                    aO()
                    ad.Rebind(aI, "ImageColor3", "MutedForeground")
                    ad.Rebind(aH, "Color", "Border")
                end)
                ay:Connect(aG.MouseButton1Down, function()
                    ad.Tween(aJ, { Scale = 0.85 }, ar)
                end)
                ay:Connect(aG.MouseButton1Click, function()
                    self:_remove(az)
                end)
                az.frame = aA
                az.content = aC
                az.row = aE
                self:_fill(az, ax)
                table.insert(self._toasts, 1, az)
                local aP = 0
                for aQ, aR in ipairs(table.clone(self._toasts)) do
                    if not aR.leaving then
                        aP += 1
                        if aP > ao then
                            self:_remove(aR)
                        end
                    end
                end
                task.defer(function()
                    self:_layout()
                end)
                local aQ = {}
                function aQ.Update(aR, b)
                    if az.leaving then
                        return
                    end
                    local c = {}
                    if type(b) == "string" then
                        c = { Title = b }
                    else
                        c = b
                    end
                    self:_fill(az, c)
                    task.defer(function()
                        self:_layout()
                    end)
                end
                function aQ.Close()
                    self:_remove(az)
                end
                return aQ
            end
            function at:Promise(aw, ax)
                local function ay(az, aA)
                    if type(az) == "function" then
                        return az(aA)
                    end
                    return az
                end
                local az = self:Add({
                    Title = ay(ax.Loading, nil) or "Loading",
                    Type = "Loading",
                    Description = ax.Description,
                })
                task.spawn(function()
                    local aA, aB = pcall(aw)
                    if aA then
                        az:Update({ Title = ay(ax.Success, aB) or "Done", Type = "Success" })
                    else
                        az:Update({ Title = ay(ax.Error, aB) or "Failed", Type = "Error", Description = tostring(aB) })
                    end
                end)
                return az
            end
            function at:Clear()
                for aw, ax in ipairs(table.clone(self._toasts)) do
                    self:_remove(ax)
                end
            end
            return at
        end
        function a.u()
            local ab = a.cache.u
            if not ab then
                ab = { c = aa() }
                a.cache.u = ab
            end
            return ab.c
        end
    end
end
local aa, ab, ac, ad, ae, af, ag, ah = a.Maid(), a.Theme(), a.Fonts(), a.Icons(), a.Creator(), a.t(), a.u(), a.g()
local ai, aj, ak, al, am =
    {
        Version = "0.1.0",
        Themes = ab.Themes,
        Accents = ab.Accents,
        Fonts = ac,
        Create = ae.Create,
        Token = ab.Token,
        Windows = {},
        Unloading = ah.new(),
    }, aa.new(), "__shadcn.Theme", "__shadcn.Accent", "__shadcn.Colors"
ai.ThemeChanged = ah.new()
ai.Features = { ConfigStore = true }
ai.ThemeTokens = {
    {
        Title = "Surfaces",
        Tokens = { "Background", "Card", "Popover", "Muted", "Accent", "Secondary", "Border", "Input" },
    },
    {
        Title = "Text",
        Tokens = { "Foreground", "MutedForeground", "CardForeground", "AccentForeground", "SecondaryForeground" },
    },
    {
        Title = "Brand",
        Tokens = { "Primary", "PrimaryForeground", "Ring", "Destructive", "DestructiveForeground", "SwitchThumb" },
    },
    {
        Title = "Sidebar",
        Tokens = {
            "Sidebar",
            "SidebarForeground",
            "SidebarAccent",
            "SidebarBorder",
            "SidebarPrimary",
            "SidebarPrimaryForeground",
        },
    },
}
local function an()
    for ao, ap in ipairs(ai.Windows) do
        ap:SetFlag(ak, ab.Mode)
        ap:SetFlag(al, ab.Accent)
        ap:SetFlag(am, table.clone(ab.Overrides))
    end
end
local function ao(ap)
    ab.Apply(ab.Build(), ap)
    an()
    ai.ThemeChanged:Fire(ab.Current)
end
function ai:CreateWindow(ap)
    local aq, ar = ap or {}, aj:Sub()
    ac.Load(aq.Font)
    if aq.IconSet == "SF" or aq.IconSet == "Lucide" then
        ad.Set = aq.IconSet
    end
    aq.BeforeBuild = function(as)
        ab.Defaults = { Mode = aq.Theme or "Dark", Accent = aq.Accent or "Default" }
        ab.Mode = as:GetFlag(ak, aq.Theme or ab.Mode)
        ab.Accent = as:GetFlag(al, aq.Accent or ab.Accent)
        local at = {}
        if type(aq.Palette) == "table" then
            for au, av in pairs(aq.Palette) do
                if ab.Themes[au] and type(av) == "table" then
                    at[au] = {}
                    for aw, ax in pairs(av) do
                        if typeof(ax) == "Color3" and ab.Themes.Dark[aw] then
                            at[au][aw] = ax
                        end
                    end
                end
            end
        end
        ab.Palette = at
        local au, av = as:GetFlag(am, nil), {}
        if type(au) == "table" then
            for aw, ax in pairs(au) do
                if typeof(ax) == "Color3" and ab.Themes.Dark[aw] then
                    av[aw] = ax
                end
            end
        end
        ab.Overrides = av
        ab.Apply(ab.Build())
    end
    local as = af.new(ai, ar, aq)
    table.insert(ai.Windows, as)
    return as
end
function ai:_forget(ap)
    local aq = table.find(ai.Windows, ap)
    if aq then
        table.remove(ai.Windows, aq)
    end
end
function ai:SetTheme(ap)
    if type(ap) == "string" then
        if not ab.Themes[ap] then
            return
        end
        ab.Mode = ap
    else
        local aq = {}
        for ar, as in pairs(ap) do
            if ar == "Base" then
                ab.Mode = as
            elseif typeof(as) == "Color3" then
                aq[ar] = as
            end
        end
        ab.Overrides = aq
    end
    ao()
end
function ai:SetAccent(ap, aq)
    if type(ap) == "string" and not ab.Accents[ap] then
        return
    end
    ab.Accent = ap
    ao(aq)
end
function ai:SetColor(ap, aq, ar)
    if not ab.Themes.Dark[ap] or typeof(aq) ~= "Color3" then
        return
    end
    ab.Overrides[ap] = aq
    ao(ar)
end
function ai:ResetColor(ap)
    if ap then
        ab.Overrides[ap] = nil
    else
        ab.Overrides = {}
    end
    ao()
end
function ai:ResetTheme()
    ab.Mode = ab.Defaults.Mode
    ab.Accent = ab.Defaults.Accent
    ab.Overrides = {}
    ao()
end
function ai:DefaultColor(ap)
    local aq = ab.Overrides
    ab.Overrides = {}
    local ar = ab.Build()
    ab.Overrides = aq
    return ar[ap]
end
function ai:RandomTheme(ap)
    local aq, ar, as = (ap or ab.Mode) == "Dark", math.random(), 0.55 + math.random() * 0.3
    local function at(au, av)
        return Color3.fromHSV(ar, math.clamp(au, 0, 1), math.clamp(av, 0, 1))
    end
    local function au(av)
        local aw = 0.2126 * av.R + 0.7152 * av.G + 0.0722 * av.B
        if aw > 0.55 then
            return Color3.fromHex("0a0a0c")
        end
        return Color3.fromHex("fafafa")
    end
    local av = {}
    if aq then
        local aw = at(as, 0.72 + math.random() * 0.18)
        av.Background = at(0.25, 0.07)
        av.Sidebar = at(0.22, 0.095)
        av.Card = at(0.22, 0.105)
        av.Popover = at(0.2, 0.125)
        av.Muted = at(0.18, 0.17)
        av.Accent = av.Muted
        av.Secondary = av.Muted
        av.SidebarAccent = at(0.18, 0.16)
        av.Border = at(0.15, 0.21)
        av.Input = av.Border
        av.SidebarBorder = av.Border
        av.Foreground = at(0.05, 0.87)
        av.MutedForeground = at(0.08, 0.58)
        av.Primary = aw
        av.SidebarPrimary = at(as * 0.85, 0.95)
        av.Ring = at(as * 0.5, 0.55)
        av.SwitchThumb = av.Foreground
    else
        local aw = at(as, 0.55 + math.random() * 0.15)
        av.Background = at(0.04, 0.96)
        av.Sidebar = at(0.06, 0.935)
        av.Card = at(0.03, 0.985)
        av.Popover = av.Card
        av.Muted = at(0.06, 0.91)
        av.Accent = av.Muted
        av.Secondary = av.Muted
        av.SidebarAccent = at(0.08, 0.88)
        av.Border = at(0.08, 0.85)
        av.Input = av.Border
        av.SidebarBorder = av.Border
        av.Foreground = at(0.3, 0.13)
        av.MutedForeground = at(0.1, 0.45)
        av.Primary = aw
        av.SidebarPrimary = at(as, 0.62)
        av.Ring = aw
        av.SwitchThumb = Color3.new(1, 1, 1)
    end
    av.CardForeground = av.Foreground
    av.AccentForeground = av.Foreground
    av.SecondaryForeground = av.Foreground
    av.SidebarForeground = av.Foreground
    av.PrimaryForeground = au(av.Primary)
    av.SidebarPrimaryForeground = au(av.SidebarPrimary)
    if ap and ab.Themes[ap] then
        ab.Mode = ap
    end
    ab.Accent = av.Primary
    ab.Overrides = av
    ao()
    return ar
end
function ai:_applySavedTheme(ap)
    if type(ap) ~= "table" then
        return
    end
    if type(ap.Theme) == "string" and ab.Themes[ap.Theme] then
        ab.Mode = ap.Theme
    end
    if typeof(ap.Accent) == "Color3" or (type(ap.Accent) == "string" and ab.Accents[ap.Accent]) then
        ab.Accent = ap.Accent
    end
    local aq = {}
    if type(ap.Colors) == "table" then
        for ar, as in pairs(ap.Colors) do
            if typeof(as) == "Color3" and ab.Themes.Dark[ar] then
                aq[ar] = as
            end
        end
    end
    ab.Overrides = aq
    ao()
end
function ai:ExportTheme()
    local ap = {}
    for aq, ar in pairs(ab.Overrides) do
        ap[aq] = "#" .. string.upper(ar:ToHex())
    end
    local aq = ab.Accent
    if typeof(aq) == "Color3" then
        aq = "#" .. string.upper(aq:ToHex())
    end
    return game:GetService("HttpService"):JSONEncode({
        Mode = ab.Mode,
        Accent = aq,
        Colors = ap,
    })
end
function ai:ImportTheme(ap)
    local aq, ar = pcall(function()
        return game:GetService("HttpService"):JSONDecode(ap)
    end)
    if not aq or type(ar) ~= "table" then
        return false
    end
    if type(ar.Mode) == "string" and ab.Themes[ar.Mode] then
        ab.Mode = ar.Mode
    end
    if type(ar.Accent) == "string" then
        if ab.Accents[ar.Accent] then
            ab.Accent = ar.Accent
        elseif string.match(ar.Accent, "^#?%x%x%x%x%x%x$") then
            ab.Accent = Color3.fromHex((string.gsub(ar.Accent, "#", "")))
        end
    end
    local as = {}
    if type(ar.Colors) == "table" then
        for at, au in pairs(ar.Colors) do
            if ab.Themes.Dark[at] and type(au) == "string" and string.match(au, "^#?%x%x%x%x%x%x$") then
                as[at] = Color3.fromHex((string.gsub(au, "#", "")))
            end
        end
    end
    ab.Overrides = as
    ao()
    return true
end
function ai:AddTheme(ap, aq, ar)
    local as = table.clone(ab.Themes[ar or "Dark"] or ab.Themes.Dark)
    for at, au in pairs(aq) do
        as[at] = au
    end
    ab.Themes[ap] = as
end
function ai:GetColor(ap)
    return ab.Color(ap)
end
function ai:Icon(ap)
    return ad.Get(ap)
end
function ai:LoadIcons(ap)
    return ad.Load(ap)
end
local ap = nil
local function aq()
    if not ap then
        ap = ag.new(aj)
    end
    return ap
end
local function ar(as)
    local at, au = as, nil
    if type(as) == "table" then
        at, au = as.Title, as.Type
    end
    for av, aw in ipairs(ai.Windows) do
        if aw._island and not aw._visible then
            aw._island:Announce(tostring(at or ""), au)
        end
    end
end
function ai:Toast(as)
    ar(as)
    return aq():Add(as)
end
function ai:Notify(as)
    ar(as)
    return aq():Add(as)
end
function ai:Promise(as, at)
    return aq():Promise(as, at)
end
setmetatable(ai, {
    __index = function(as, at)
        if at == "IconsUrl" then
            return ad.Url
        end
        if at == "FontsUrl" then
            return ac.Url
        end
        if at == "SFIconsUrl" then
            return ad.SFUrl
        end
        if at == "IconSet" then
            return ad.Set
        end
        return nil
    end,
    __newindex = function(as, at, au)
        if at == "IconsUrl" then
            ad.Url = au
        elseif at == "SFIconsUrl" then
            ad.SFUrl = au
        elseif at == "IconSet" then
            ad.Set = au
        elseif at == "FontsUrl" then
            ac.Url = au
        else
            rawset(as, at, au)
        end
    end,
})
local as = false
function ai:Unload()
    if as then
        return
    end
    as = true
    ai.Unloading:Fire()
    for at = #ai.Windows, 1, -1 do
        ai.Windows[at]:Destroy("Unload")
    end
    as = false
    ai.ThemeChanged:DisconnectAll()
    aj:Clean()
    ap = nil
    ab.Reset()
    ad.Reset()
    ac.Reset()
end
function ai:_maidCount()
    return aj:Count()
end
return ai

end)()

return UI
