import XMonad
import qualified Data.Map as M

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog

import XMonad.Layout.IndependentScreens
import XMonad.Layout.MosaicAlt

import XMonad.Util.EZConfig

dmenuOptions = " -nf '#ffffff' -nb '#000000'"

myDmenu = "dmenu_run" ++ dmenuOptions

myKeys conf@(XConfig {XMonad.modMask = mod4Mask}) = M.fromList $
       [ ((mod4Mask, xK_p), spawn myDmenu) ]

myBar = "xmobar"

myPP = xmobarPP {ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

main = do
     nScreens <- countScreens
     xmonad =<< xmobar (defaultConfig
        { modMask    = mod4Mask -- Use Super instead of Alt
	, terminal   = "Terminal"
	, logHook    = ewmhDesktopsLogHook
	, layoutHook = avoidStruts $ layoutHook defaultConfig
	, handleEventHook = ewmhDesktopsEventHook
	, startupHook = ewmhDesktopsStartup
	, keys = myKeys <+> keys defaultConfig
        -- more changes
	, workspaces = withScreens nScreens (workspaces defaultConfig)
        }
	`additionalKeysP` -- Multimedia keys.
        [ ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
        , ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 2%+")
        , ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 2%-") ])
