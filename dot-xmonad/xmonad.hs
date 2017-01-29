import Control.Monad
import qualified XMonad.StackSet as W

import XMonad
import qualified Data.Map as M

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName

import XMonad.Layout.IndependentScreens
import XMonad.Layout.MosaicAlt
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Circle

import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders

dmenuOptions = " -nf '#ffffff' -nb '#000000' -fn '-*-DejaVu sans mono-medium-r-*-*-24-*'"

myDmenu = "dmenu_run" ++ dmenuOptions

myKeys conf@(XConfig {XMonad.modMask = mod4Mask}) = M.fromList $
       [ ((mod4Mask, xK_p), spawn myDmenu) ]

myBar = "xmobar"

fBorderColor = "#808080"

myPP = xmobarPP {ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }
-- 

myLayoutHook = (layoutHook defaultConfig) |||  MosaicAlt M.empty ||| simpleFloat ||| Circle

main = do
     nScreens <- countScreens

     xmonad =<< xmobar (defaultConfig
        { modMask    = mod4Mask -- Use Super instead of Alt
	, terminal   = "urxvtc"
        , XMonad.focusedBorderColor = fBorderColor
        , XMonad.normalBorderColor = "black"
	, logHook    = ewmhDesktopsLogHook >> setWMName "LG3D"
	, layoutHook = avoidStruts $ (smartBorders $ myLayoutHook)
        , manageHook = manageDocks <+> manageHook defaultConfig
	, handleEventHook = ewmhDesktopsEventHook
	, startupHook = ewmhDesktopsStartup
	, focusFollowsMouse = True
	, keys = myKeys <+> keys defaultConfig
        -- more changes
	, workspaces = withScreens nScreens (workspaces defaultConfig)
        }
	`additionalKeysP` -- Multimedia keys.
        [ ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
        , ("<XF86AudioRaiseVolume>", spawn "amixer -c2 -q set Speaker 2%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer -c2 -q set Speaker 2%-")
--        , ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 2")
--        , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 2")
        ])

