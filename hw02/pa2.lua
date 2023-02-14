-- pa2.lua
-- Millard A. Arnold V
-- 2023-02-13
-- 
-- For CS 331 Spring 2023
-- Assignment 2 Functions
-- Used in Assignment 2, Exercise B

local pa2 = {}

function pa2.mapTable(f, t)
  for k, v in pairs(t) 
    do t[k] = f(v) 
  end
  return t
end

function pa2.concatMax(s, i)
  return s
end

function pa2.collatz(k)
  return k
end

function pa2.backSubs(s)
  return s
end

return pa2