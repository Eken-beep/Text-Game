module Level where

type Item    = String
type Items   = [Item]
type Place   = String
type Monster = String

data GameState = GameState
     {playerHP     :: Int
     ,playerName   :: String
     ,playerMinDmg :: Int
     ,playerMaxDmg :: Int
     ,coins        :: Int
     ,items        :: Items
     }

data Screen = Screen
     {monsterType   :: Monster
     ,monsterHP     :: Int
     ,monsterMinDmg :: Int
     ,monsterMaxDmg :: Int
     ,monsterCoins  :: Int
     ,place         :: Place
     }

placesScary :: [Place]
placesScary = ["cave", "haunted mansion", "haunted castle"] 

placesSea :: [Place]
placesSea = ["beach", "island", "riverbank"]

placesWoods :: [Place]
placesWoods = ["glade", "marsh", "dense forest"]

monstersScary :: [(Monster,Int,Int,Int,Int)]
monstersScary = [("zombie",20,3,7,8), ("skeleton",15,8,12,8), ("spider",10,8,15,6)]

monstersSea :: [(Monster,Int,Int,Int,Int)]
monstersSea = [("giant squid",50,1,5,14), ("drowned",15,5,10,9), ("sea monster", 30,10,15,12)]

monstersWoods :: [(Monster,Int,Int,Int,Int)]
monstersWoods = [("lion",10,3,7,5), ("bear",15,3,7,7), ("wolf",10,5,15,8)]

bossArenas :: [Place]
bossArenas = ["crystal cave", "egyptian pyramid", "colloseum"]

bosses :: [(Monster,Int,Int,Int,Int)]
bosses = [("dragon",100,10,20,100)]
