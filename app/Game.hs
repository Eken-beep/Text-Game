module Game where

import System.IO
import System.Exit
import System.Random
import Data.Char
import Data.List
import Control.Monad
import Level

blankState :: GameState
blankState  = GameState 100 undefined 5 10 0 []

start name = do
    let initialState = blankState{playerName = name}
    village initialState

village :: GameState -> IO ()
village currentState = do
    putStrLn "\nWelcome to the village what do you want to do (unsure of what is possible, type help or h)"
    input <- getLine

    parseAction input currentState

adventure :: GameState -> IO ()
adventure currentState = do 
    putStrLn "Were do you want to head (unsure of where to go, type help or h)" 
    input <- getLine
    parseDirection input currentState

normalise :: String -> String
normalise = map toLower

parseAction :: String -> GameState -> IO ()
parseAction input currentState = case normalise input of
                                 "help"      -> helpAction
                                 "h"         -> helpAction
                                 "quit"      -> exitSuccess
                                 "q"         -> exitSuccess
                                 "adventure" -> adventure currentState
                                 "a"         -> adventure currentState
                                 "shop"      -> shop currentState
                                 "s"         -> shop currentState
                                 "bank"      -> bank currentState
                                 "b"         -> bank currentState
                                 "heal"      -> heal currentState
                                 "he"        -> heal currentState
                                 _           -> Control.Monad.void(putStrLn "Invalid option\n")
                            
parseDirection :: String -> GameState -> IO ()
parseDirection input currentState = case normalise input of
                                    "help"  -> helpDirection
                                    "h"     -> helpDirection
                                    "north" -> moveNorth currentState
                                    "n"     -> moveNorth currentState
                                    "south" -> moveSouth currentState
                                    "s"     -> moveSouth currentState
                                    "west"  -> moveWest currentState
                                    "w"     -> moveWest currentState
                                    "east"  -> moveEast currentState
                                    "e"     -> moveEast currentState
                                    _       -> Control.Monad.void(putStrLn "Invalid option")                                      

bank :: GameState -> IO ()
bank state = putStrLn "You have the following ammount of coins in your account: " >> print (coins state) >> village state

shop :: GameState -> IO ()
shop state = do
    putStrLn "Welcome to the shop here you can buy healing potions for coins, please enter below how many you'd like to buy, they're 10 coins each"
    input <- getLine
    let numberOfItems = read input :: Int
    let item = "healing potion"
    addItems numberOfItems item state

addItems x y state = replicate x y `union` items state

heal :: GameState -> IO()
heal state = do
    if playerHP state > 50 then village state{playerHP = 100}

    else do 
        let newPlayerHP = playerHP state + 50
        village state{playerHP = newPlayerHP} 
                                    
helpAction    = putStrLn "Available things to do in the village:\n(H)elp \n(Q)uit \n(A)dventure \n(S)hop \n(He)al\n"
helpDirection = putStrLn "Available directions to head:\n(N)orth\n(S)outh\n(W)est\n(east)\n"

moveNorth state = putStrLn "You headed north in search of adventure\n" >> fightNorth state
moveSouth state = putStrLn "You headed south in search of adventure\n" >> fightSouth state
moveWest state  = putStrLn "You headed west in search of adventure\n" >> fightWest state
moveEast state  = putStrLn "You headed east in search of adventure\n" >> fightEast state

selectRandomElement :: [a] -> IO a
selectRandomElement [] = error "Cannot select an element from an empty list."
selectRandomElement list = randomIntWithinRange >>=
  \r -> return $ list !! r
  where
  randomIntWithinRange = getStdRandom $ randomR (0, length list - 1)

getName   (x,_,_,_,_) = x
getHP     (_,x,_,_,_) = x
getMinDmg (_,_,x,_,_) = x
getMaxDmg (_,_,_,x,_) = x
getCoins  (_,_,_,_,x) = x

-- encounter :: thing -> thing idk how this thing is supposed to work
encounter screen state monster place placePrefix = do
    let emesg = "You encounter a " ++ getName monster ++ placePrefix ++ place
    putStrLn emesg
    
    putStrLn "You can (F)ight or (R)un"
    input <- getLine
    case map toLower input of
      "r"      -> village state 
      "run"    -> village state
      "f"      -> attack screen state
      "fight"  -> attack screen state
      _        -> print "Invalid option\n" >> encounter screen state monster place placePrefix

death :: GameState -> IO ()
death state = putStrLn "You died and lost your coins" >> village state{coins = 0}

attack :: Screen -> GameState -> IO ()
attack screen state = do
    if playerHP state <= 0 then death state 
    else do
        playerDmg <- getStdRandom $ randomR (playerMinDmg state, playerMaxDmg state)
        putStrLn "\nYou hit the monster and deal the following damage: "
        print playerDmg
        let newMonsterHP = monsterHP screen - playerDmg
        let nextScreen = screen{monsterHP = newMonsterHP}
        putStrLn "This leaves the monster with the following ammount of hp: "
        print newMonsterHP
        defend nextScreen state

defend :: Screen -> GameState -> IO ()
defend screen state = do
    if monsterHP screen <= 0 then do
                             let newCoinCount = coins state + 5
                             let nextState = state{coins = newCoinCount}
                             village nextState
    else do
        monsterDmg <- getStdRandom $ randomR (monsterMinDmg screen, monsterMaxDmg screen)
        putStrLn "\nThe monster hits you and deal the following damage:"
        print monsterDmg
        let newPlayerHP = playerHP state - monsterDmg
        let nextState = state{playerHP = newPlayerHP}
        
        putStrLn "This leaves you with the following ammount of hp: "
        print newPlayerHP
        
        putStrLn "Do you want to (A)ttack or (R)un"
        input <- getLine
        if map toLower input == "r" then putStrLn "\nYou run away like a coward..." >> village state
        else attack screen nextState

fightNorth :: GameState -> IO ()
fightNorth state = do
    place   <- selectRandomElement placesScary
    monster <- selectRandomElement monstersScary

    let placePrefix = " in the "
    let initialScreen = Screen (getName monster) (getHP monster) (getMinDmg monster) (getMaxDmg monster) (getCoins monster) place

    encounter initialScreen state monster place placePrefix
    
    return()

fightSouth :: GameState -> IO ()
fightSouth state = do
    place   <- selectRandomElement placesSea
    monster <- selectRandomElement monstersSea

    let placePrefix = " on the "
    let initialScreen = Screen (getName monster) (getHP monster) (getMinDmg monster) (getMaxDmg monster) (getCoins monster) place

    encounter initialScreen state monster place placePrefix

    return()

fightWest :: GameState -> IO ()
fightWest state = do
    place   <- selectRandomElement placesWoods
    monster <- selectRandomElement monstersWoods

    let initialScreen = Screen (getName monster) (getHP monster) (getMinDmg monster) (getMaxDmg monster) (getCoins monster) place
    let placePrefix = " in the "

    encounter initialScreen state monster place placePrefix

fightEast :: GameState -> IO ()
fightEast state = do
    place    <- selectRandomElement bossArenas
    monster  <- selectRandomElement bosses

    let initialScreen = Screen (getName monster) (getHP monster) (getMinDmg monster) (getMaxDmg monster) (getCoins monster) place
    let placePrefix = " in the "

    encounter initialScreen state monster place placePrefix
