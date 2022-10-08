module Assets where

-- Different weapons
-- Weapon def (Name,   Tag,    DamageMin, DamageMax)
type Weapon = (String, String, Int,       Int)

-- Starter weapon
bat :: Weapon
bat = ("Wooden bat", "Melee", 1, 5)
