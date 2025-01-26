return function()
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

    local useButton = loveframes.Create("button")
    useButton:SetParent(bottomBar)
    useButton:CenterX()
    useButton:SetSize(169, 72)
    useButton:SetText("Play")
    useButton:SetY(useButton:GetY() - useButton:GetHeight() / 2)

    --local games


    --window.drawfunc = function()end
    -- simulate instances --
end