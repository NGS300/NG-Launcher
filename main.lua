loveframes = require 'libraries.loveframes'
lovedownloader = require 'libraries.lovedownloader'
nativefs = require 'libraries.nativefs'
resolution = require 'libraries.resolution'
neuron = require 'libraries.neuron'

viewmanager = require 'src.Components.ViewManager'

require("src.Components.AddonLoad")()

local function loadView(path)
    loveframes.RemoveAll()
    --local f = require(path:gsub(".lua", ""))()
    love.filesystem.load(path)()()
end

function love.load()
    winconfig = {
        width = 1024,
        height = 512,
        aspectRatio = true,
        centered = true,
        clampMouse = true,
        clip = true,
    }

    launcherSettings = neuron.new()
    launcherSettings.save.config = {
        user = {
            theme = "Dark red",
        }
    }

    launcherSettings:initialize()

    resolution.init(winconfig)

    -- create folders --
    love.filesystem.createDirectory("instances")
    love.filesystem.createDirectory("instances/viewer")
    love.filesystem.createDirectory("instances/studio")
    love.filesystem.createDirectory("instances/player")

    loveframes.SetActiveSkin("Dark red")

    --loadView("src/Views/MainView.lua")

    viewmanager.load("assets/data/views/MainView.lua")
end

function love.draw()
    loveframes.draw()
end

function love.update(elapsed)
    loveframes.update(elapsed)
    viewmanager.reloadViews()
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
    end
end

function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end