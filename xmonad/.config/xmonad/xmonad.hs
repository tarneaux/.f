import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import System.Exit
import qualified XMonad.StackSet as W
import Language.LSP.Types.Lens (HasWindow(window))
import XMonad.Layout.Spacing
import XMonad.Util.SpawnOnce
import XMonad.Layout.ToggleLayouts

myTerminal = "alacritty"
myBrowser = "qutebrowser"

myBorderWidth = 2
myGapWidth = 5 -- Gap both between windows and on the edge of the screen

myNormalBorderColor = "#ebdbb2"
myFocusedBorderColor = "#d65d0e"

-- Define layouts
myLayoutHook = spacingRaw False (Border myGapWidth myGapWidth myGapWidth myGapWidth) True (Border myGapWidth myGapWidth myGapWidth myGapWidth) True $
    Tall 1 (3/100) (1/2) ||| Full

myStartupHook = do
    spawnOnce "feh --bg-fill ~/.config/xmonad/walls/forest_house.png"
    spawn "xmodmap ~/.Xmodmap"
    spawn "xset r rate 300 50"
    spawn "xsetroot -cursor_name left_ptr"
    spawn "wg-quick up vpn"

myKeys = 
    [ ("M-S-q", io exitSuccess)
    , ("M-q", spawn "xmonad --recompile; xmonad --restart")
    , ("M-p", spawn "dmenu_run")
    -- Close focused window
    , ("M-w", kill)
    , ("M-b", spawn myBrowser)
    , ("M-<Return>", spawn myTerminal)
    -- Because I use colemak: e (up) and o (down) to switch windows
    , ("M-i", windows W.focusDown)
    , ("M-e", windows W.focusUp)
    -- same + Shift => swap windows
    , ("M-S-i", windows W.swapDown)
    , ("M-S-e", windows W.swapUp)
    -- Change number of windows in the master window
    , ("M-n", sendMessage (IncMasterN 1))
    , ("M-o", sendMessage (IncMasterN (-1)))
    -- Change the master window size
    , ("M-S-n", sendMessage Shrink)
    , ("M-S-o", sendMessage Expand)
    -- Toggle floating
    , ("M-f", withFocused $ windows . W.sink)
    -- Move focus to the master window
    , ("M-h", windows W.focusMaster)
    -- Swap the focused window and the master window
    , ("M-S-h", windows W.swapMaster)
    -- Super + a,r,s,t,d to move to workspaces 1,2,3,4,5
    , ("M-a", windows $ W.greedyView "1")
    , ("M-r", windows $ W.greedyView "2")
    , ("M-s", windows $ W.greedyView "3")
    , ("M-t", windows $ W.greedyView "4")
    , ("M-d", windows $ W.greedyView "5")
    -- Same + Shift => move window to workspace
    , ("M-S-a", windows $ W.shift "1")
    , ("M-S-r", windows $ W.shift "2")
    , ("M-S-s", windows $ W.shift "3")
    , ("M-S-t", windows $ W.shift "4")
    , ("M-S-d", windows $ W.shift "5")
    -- Change layout
    , ("M-,", sendMessage NextLayout)
    -- DMscripts
    , ("M-m", spawn "bash ~/.config/dmscripts/main.sh")
    ]

main :: IO ()

main = xmonad $ def 
    { modMask = mod4Mask -- super = mod
    , terminal = myTerminal
    , borderWidth = myBorderWidth
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , startupHook = myStartupHook
    , layoutHook = myLayoutHook
    }
    `additionalKeysP`
    myKeys
