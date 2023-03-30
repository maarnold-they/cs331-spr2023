-- findmax.hs
-- Millard A. Arnold 
-- 2023-03-30
--
-- Solution to Assignment 5 Exercise C

module Main where

import System.IO

-- If choice given to continue is not 'y' or 'Y', then it will be treated as 'n'
-- Cannot handle non-integer list input

main = do
    putStrLn "Enter a list of integers, one on each line."
    putStrLn "I will compute the maximum item in the list."
    inputList <- getValuesFromUser

    if inputList == [] then putStrLn "Empty list - no maximum."
    else do 
        let maxVal = maximum inputList
        putStr "The maximum value is: "
        putStrLn $ show maxVal
    
    putStrLn "\nWould you like to compute another maximum? (y/n) "
    hFlush stdout
    choice <- getLine
    if choice == "y" || choice == "Y" then do main
    else
        putStrLn "Bye!"
        return()

getValuesFromUser = do
    putStr "Please input an integer or blank line to finish: "
    hFlush stdout
    input <- getLine
    if input == "" then
        return []
    else do
        let n = read input::Int
        rest <- getValuesFromUser
        return (n:rest)

