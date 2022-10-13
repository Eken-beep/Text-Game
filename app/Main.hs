module Main where

import System.IO
import Data.Char
import Data.List

import Assets
import Data

main :: IO ()
main = getLine >>= name >>= start

name n = do 
    let greet = "Hello " ++ n ++ " welcome! \n" in putStrLn greet
    let newState = initialState { playerName = n }
    return newState

start state = putStrLn "Initialising level... \n" >>
              putStrLn "\n You can now do things, always, type h for help and to list the available commands" >>
              getLine >>= 
              option state

option state o
    | o == "h"  = putStrLn "\n h help \n f fight \n b boss"
    | o == "f"  = fight state
    | o == "b"  = boss state
    | otherwise = putStrLn "Invalid command h for help"

fight state = undefined
boss state = undefined
