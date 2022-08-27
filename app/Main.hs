module Main where

import System.IO
import Data.Char
import Data.List

import Game
import Level

main :: IO ()
main = do
    putStrLn "\nHello and welcome to the game, \nTo get started please enter your name below:\n"
    name <- getLine 
    let greet = "\nHello " ++ name ++ ", nice to meet you"
    putStrLn greet

    Game.start name
