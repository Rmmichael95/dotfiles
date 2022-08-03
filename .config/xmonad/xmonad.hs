import XMonad

main = do
  xmonad $ def
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    }
myTerminal    = "alacritty"
myModMask     = mod4Mask
myBorderWidth = 3
