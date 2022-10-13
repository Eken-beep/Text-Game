module Assets where

import Data

-- Initial gamestate to load
initialState = GameState { playerName   = " "
                         , playerHp     = 100 
                         , inventory    = [] 
                         , level        = level0 
                         , monster      = Data.Nothing 
                         , playerDmg    = 1 
                         , playerWeapon = bat}

level0 = Level { num        = 1 
               , astetic    = Village
               , difficulty = 1 }
                         
getWeaponStat (a,b,c,d) element
    | element == 1 = a
    | element == 2 = b
    | element == 3 = c
    | element == 4 = d
    | otherwise    = a

-- Different weapons
-- Starter weapon
bat :: Weapon
bat = ("Wooden bat", "Melee", 1, 5)
