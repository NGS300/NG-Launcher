return function()
    local boxList = loveframes.Create("panel")
    boxList:SetSize(love.graphics.getWidth(), love.graphics.getHeight())
    boxList.drawfunc = function()end
    
    local boxContent = loveframes.Create("list")
    boxContent:SetParent(boxList)
    boxContent:SetPos((love.graphics.getWidth() * 0.7) + 5, 5)
    boxContent:SetWidth((love.graphics.getWidth() - love.graphics.getWidth() * 0.7) - 10)
    boxContent:SetHeight(love.graphics.getHeight() - 10)


    local instancesList = loveframes.Create("list")
    instancesList:SetParent(boxList)
    instancesList:SetPos(5, 5)
    instancesList:SetWidth((love.graphics.getWidth() * 0.7) - 5)
    instancesList:SetHeight(175)

    -- simulate instances --
end