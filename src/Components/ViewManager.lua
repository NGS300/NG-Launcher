local ViewManager = {}
ViewManager.views = {}

ViewManager.currentActiveView = ""

function ViewManager.load(path)
    loveframes.RemoveAll()
    --local f = require(path:gsub(".lua", ""))()

    local fileinfo = love.filesystem.getInfo(path)
    
    if fileinfo ~= nil then
        local viewstruct = {}

        local viewfile = love.filesystem.load(path)()

        viewstruct.path = path
        viewstruct.lastmod = fileinfo.modtime

        local sucess, err = pcall(viewfile)
        if not sucess then
            print(err)
        else
            table.insert(ViewManager.views, #ViewManager.views + 1, viewstruct)
        end
    else
        print("File not found, ignoring it")
    end
end

function ViewManager.reloadViews()
    for _, view in ipairs(ViewManager.views) do
        local fileinfo = love.filesystem.getInfo(view.path)
        if fileinfo.modtime > view.lastmod then
            loveframes.RemoveAll()
            ViewManager.views[_].lastmod = fileinfo.modtime

            local chunk = love.filesystem.load(view.path)()

            local sucess, err = pcall(chunk)
            if err then
                print(err)
            else
                print("[VIEW] : Updated view")
            end
        end
    end
end


return ViewManager