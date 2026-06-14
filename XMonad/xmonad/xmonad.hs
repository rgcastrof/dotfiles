import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.ManageDocks
import XMonad.Util.Loggers

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- moonfly colors
colorFg = "#eeeeee"
colorBg = "#080808"
color0  = "#323437"
color1  = "#ff5454"
color2  = "#8cc85f"
color3  = "#e3c78a"
color4  = "#80a0ff"
color5  = "#d183e8"
color6  = "#79dac8"
color7  = "#a1aab8"
color8  = "#7c8f8f"
color9  = "#ff5189"
color10 = "#36c692"
color11 = "#bfbf97"
color12 = "#74b2ff"
color13 = "#ae81ff"
color14 = "#85dc85"
color15 = "#e2637f"

myBorderWidth = 2

myNormalBorderColor = color0
myFocusedBorderColor = color4

mySpacing = spacingWithEdge 3
myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]

myModMask = mod4Mask

myTerminal = "st"

myLayout = avoidStruts . smartBorders $
    renamed [Replace "Tile"] (mySpacing tiled)
    ||| renamed [Replace "Mirror"] (mySpacing (Mirror tiled))
    ||| renamed [Replace "Grid"] (mySpacing Grid)
    ||| renamed [Replace "Spiral"] (mySpacing (spiral (6/7)))
    ||| renamed [Replace "Full"] (mySpacing Full)
    where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 0.55
    delta   = 3/100

myXmobarPP :: PP
myXmobarPP = def
    { ppSep = xmobarColor color15 "" " | "
	, ppTitleSanitize = xmobarStrip
	, ppCurrent = xmobarColor color0 color4
	, ppHidden = xmobarColor color8 ""
	, ppHiddenNoWindows = xmobarColor color0 ""
	, ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
	, ppExtras = [logTitles formatFocused formatUnfocused]
    }
	where
	formatFocused = wrap (xmobarColor color6 "" "[") (xmobarColor color6 "" "]") . xmobarColor colorFg "" . ppWindow
	formatUnfocused = wrap (xmobarColor color0 "" "[") (xmobarColor color0 "" "]") . xmobarColor color8 "" . ppWindow
	ppWindow :: String -> String
	ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

myStatusBar = statusBarProp "xmobar" (pure myXmobarPP)

main :: IO ()
main = xmonad . ewmhFullscreen . ewmh . withEasySB myStatusBar defToggleStrutsKey $ myConfig

myConfig = def
    { modMask = myModMask
    , terminal = myTerminal
	, workspaces = myWorkspaces
    , borderWidth = myBorderWidth
	, normalBorderColor = myNormalBorderColor
	, focusedBorderColor = myFocusedBorderColor
	, mouseBindings = myMouseBindings
    , layoutHook = myLayout
    }
	`additionalKeysP`
	[ ("M-p", spawn "dmenu_run -l 10 -bw 3")
	, ("M-q", kill)
	, ("M-S-r", spawn "xmonad --recompile && xmonad --restart")
	, ("<Print>", unGrab *> spawn "scrot -s | xclip -selection clipboard -t image/png")
	]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm .|. shiftMask, button1), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]
