function love.conf(w)
    w.window.width      =       1024
    w.window.height     =       512
    w.console           =       not love.filesystem.isFused()
    w.window.resizable  =       false
    w.window.title      =       "NGS Engine - Launcher" 
    w.identity          =       "com.nge.launcher"
    w.externalstorage   =       true
end