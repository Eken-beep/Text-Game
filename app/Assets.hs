module Assets where

import Data

-- Initial gamestate to load
initialState = GameState { playerHp     = 100 
                         , inventory    = [] 
                         , level        = level0 
                         , monster      = Data.Nothing 
                         , playerDmg    = 1 
                         , playerWeapon = bat}

level0 = Level { num        = 1 
               , astetic    = Village
               , difficulty = 1 }
                         
-- Different weapons
-- Starter weapon
bat :: Weapon
bat = ("Wooden bat", "Melee", 1, 5)
