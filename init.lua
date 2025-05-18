local super = {"cmd", "alt", "ctrl"}

--
-- Auto reload config
--

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--
-- Window manipulation
--

-- Vertical split half screen to the left
hs.hotkey.bind(super, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Vertical split half screen to the right
hs.hotkey.bind(super, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(super, "T", function()
  hs.application.launchOrFocus("Terminal")
end)

hs.hotkey.bind(super, "V", function()
  hs.application.launchOrFocus("Visual Studio Code")
end)

hs.hotkey.bind(super, "C", function()
  hs.application.launchOrFocus("ChatGPT")
end)

hs.hotkey.bind(super, "G", function()
  hs.application.launchOrFocus("Google Chrome")
end)

--
-- Menubar Utils
--

caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("☕")
    else
        caffeine:setTitle("😴")
    end
end
function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end
if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end
