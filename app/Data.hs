module Data where

-- Items definition
type Item  = String
type Items = [Item]

-- Weapon def (Name,   Tag,    DamageMin, DamageMax)
type Weapon = (String, String, Int,       Int)

-- Monster def (Name,   Tags,   Hp,  Dmg)
data Monster = Just (String, String, Int, Int) | Nothing deriving (Show)

-- The main game state definition
data GameState = GameState { playerHp     :: Int
                           , inventory    :: Items
                           , level        :: Level
                           , monster      :: Monster
                           , playerDmg    :: Int
                           , playerWeapon :: Weapon 
                           } deriving (Show)

-- The different places you can be at
data Astetics = Village | Plain | Forest | City deriving (Show)
data Level = Level { num        :: Int
                   , astetic    :: Astetics
                   , difficulty :: Int 
                   } deriving (Show)
