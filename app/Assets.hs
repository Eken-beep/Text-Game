module Assets where

import Data

-- Initial gamestate to load
initialState = GameState 100 [] level0
level0 = Level 1 Village 1
                         
-- Different weapons
-- Starter weapon
bat :: Weapon
bat = ("Wooden bat", "Melee", 1, 5)
