-- PA5.hs
-- Millard A. Arnold 
-- 2023-03-30
-- 
-- Based on skeleton by:
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
filterAB _ _ [] = []
filterAB _ [] _ = []
filterAB op (a:as) (b:bs)
  | op a = b:rest
  | otherwise = rest where
    rest = filterAB op as bs


-- =====================================================================


-- concatEvenOdd
concatEvenOdd :: [String] -> (String, String)
concatEvenOdd list1 = (foldl (++) [] (even list1), foldl (++) [] (odd list1)) where
  odd [] = [] 
  odd (_:xs) = even xs
  even [] = []
  even (x:xs) = x:odd xs

