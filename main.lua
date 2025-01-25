loveframes = require 'libraries.loveframes'
lovedownloader = require 'libraries.lovedownloader'
nativefs = require 'libraries.nativefs'
require("src.Components.AddonLoad")()

local function loadView(path)
    loveframes.RemoveAll()
    --local f = require(path:gsub(".lua", ""))()
    love.filesystem.load(path)()()
end

function love.load()
    -- create folders --
    love.filesystem.createDirectory("instances")
    love.filesystem.createDirectory("instances/viewer")
    love.filesystem.createDirectory("instances/studio")
    love.filesystem.createDirectory("instances/player")

    loveframes.SetActiveSkin("Dark red")

    loadView("src/Views/MainView.lua")
end

function love.draw()
    loveframes.draw()
end

function love.update(elapsed)
    loveframes.update(elapsed)
end

function love.mousepressed(x, y, button)
    loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    loveframes.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
    loveframes.wheelmoved(x, y)
end

function love.keypressed(key, isrepeat)
    loveframes.keypressed(key, isrepeat)

    if key == "f1" then
        local debug = loveframes.config["DEBUG"]
        loveframes.config["DEBUG"] = not debug
    elseif key == "f5" then
        loadView("src/Views/MainView.lua")
    end
end

function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end