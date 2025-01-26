return function()
    local settings = {
        lpadding = 16
    }


    local window = loveframes.Create("panel")
    window:SetSize(love.graphics.getWidth(), love.graphics.getHeight())
    window.drawfunc = function()end
    

    local bgImage = loveframes.Create("image")
    bgImage:SetParent(window)
    bgImage:SetImage("assets/images/bg.png")
    --bgImage:CenterX()
    bgImage:SetX(love.graphics.getWidth() * 0.20)
    bgImage:SetScale(window:GetWidth() / bgImage:GetImageWidth() * 0.8, window:GetHeight() / bgImage:GetHeight() * 0.8)


    local gamesSidebar = loveframes.Create("panel")
    gamesSidebar:SetParent(window)
    gamesSidebar:SetSize(love.graphics.getWidth() * 0.20, love.graphics.getHeight())

    local bottomBar = loveframes.Create("panel")
    bottomBar:SetParent(window)
    bottomBar:SetPos(love.graphics.getWidth() * 0.20, love.graphics.getHeight() - love.graphics.getHeight() * 0.20)
    bottomBar:SetSize(love.graphics.getWidth() - love.graphics.getWidth() * 0.20, love.graphics.getHeight()* 0.20)

    -- gamelist
    local grid = loveframes.Create("grid")
    grid:SetParent(gamesSidebar)
    grid:SetPos(5, 30)
    grid:SetRows(3)
    grid:SetColumns(1)
    grid:SetCellWidth(96)
    grid:SetCellHeight(96)
    grid:SetCellPadding(10)
    grid:SetItemAutoSize(true)
    grid:SetX((gamesSidebar:GetWidth() / 2 - grid:GetWidth() / 2) - settings.lpadding)
    grid:SetY(128)
    grid.drawfunc = function()end

    -- settings button --
    local configButtonImage = loveframes.Create("image")
    configButtonImage:SetParent(gamesSidebar)
    configButtonImage:SetImage("assets/images/settings_ico.png")
    configButtonImage:SetScale(0.12, 0.12)
    configButtonImage:CenterX()
    configButtonImage:SetY(settings.lpadding)
    local iw, ih = configButtonImage:GetSize()
    local configButton = loveframes.Create("button")
    configButton:SetParent(gamesSidebar)
    configButton:SetSize(iw * 0.12, ih * 0.12)
    configButton:CenterX()
    configButton:SetY(settings.lpadding)
    configButton.drawfunc = function()end

    for i = 1, 3, 1 do
        --iconGame:CenterX()
        local iconGame = loveframes.Create("image")
        --iconGame:SetParent(gamesSidebar)
        iconGame:SetImage("assets/images/icon_player.png")
        iconGame:SetScale(0.17, 0.17)
        --iconGame:SetOffsetX(iconGame:GetImageWidth() / 5)

        local iconButton = loveframes.Create("button")
        --iconButton.drawfunc = function()end

        local tooltip = loveframes.Create("tooltip")
        tooltip:SetObject(iconButton)
        tooltip:SetPadding(10)
        tooltip:SetText("This is a panel object.")

        grid:AddItem(iconGame, i, 1, "center")
        grid:AddItem(iconButton, i, 1, "center")
    end

    -- stateful button
    local useButton = loveframes.Create("button")
    useButton:SetParent(bottomBar)
    useButton:CenterX()
    useButton:SetX((bottomBar:GetWidth() / 2 - useButton:GetWidth() / 2) - settings.lpadding)
    useButton:SetSize(169, 72)
    local sizedFont = love.graphics.newFont("assets/fonts/ComfortaaMedium.ttf", 20)
    useButton:SetFont(sizedFont)
    useButton:SetText("Play")
    useButton:SetY(useButton:GetY() - useButton:GetHeight() / 2)


    --local panel = loveframes.Create("panel")


    --local games


    --window.drawfunc = function()end
    -- simulate instances --
end