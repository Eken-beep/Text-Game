module Data where

-- Items definition
type Item  = String
type Items = [Item]

-- Monster def (Name,   Tags,   Hp,  Dmg)
type Monster = (String, String, Int, Int)

-- The main game state definition
data GameState = GameState { playerHp  :: Int
                           , inventory :: Items
                           , place     :: String
                           , monster   :: Monster
                           , playerDmg :: Int }
