-- PA5.hs  SKELETON
-- Glenn G. Chappell
-- 2023-03-22
--
-- For CS 331 Spring 2023
-- Solutions to Assignment 5 Exercise B

module PA5 where


-- =====================================================================


-- collatzCounts
collatzCounts :: [Integer]
collatzCounts = map collatzCount [1..] where
  collatzCount k 
    | k == 1 = 0 
    | odd k = 1 + collatzCount ((3 * k) + 1) 
    | otherwise = 1 + collatzCount (div k 2)


-- =====================================================================


-- findList
findList :: Eq a => [a] -> [a] -> Maybe Int
findList list1 list2
  | null indices = Nothing
  | otherwise = Just $ head indices where
    indices = [ x | x <- [0..((length list2) - 1)], (sublist list2 x (length list1)) == list1 ] where
      sublist temp index size = take size $ drop index temp


-- =====================================================================


-- operator ##
(##) :: Eq a => [a] -> [a] -> Int
list1 ## list2 = length matches where
  matches = [index | index <- [0..(minlength - 1)], (list1 !! index) == (list2 !! index)] where
    minlength = min (length list1) (length list2)


-- =====================================================================


-- filterAB
filterAB :: (a -> Bool) -> [a] -> [b] -> [b]
filterAB _ _ bs = bs  -- DUMMY; REWRITE THIS!!!


-- =====================================================================


-- concatEvenOdd
concatEvenOdd :: [String] -> (String, String)
{-
  The assignment requires concatEvenOdd to be written as a fold.
  Like this:

    concatEvenOdd xs = fold* ... xs  where
        ...

  Above, "..." should be replaced by other code. "fold*" must be one of
  the following: foldl, foldr, foldl1, foldr1.
-}
concatEvenOdd _ = ("Yo", "Yoyo")  -- DUMMY; REWRITE THIS!!!

