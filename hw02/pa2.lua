-- pa2.lua
-- Millard A. Arnold V
-- 2023-02-13
-- 
-- For CS 331 Spring 2023
-- Assignment 2 Functions
-- Used in Assignment 2, Exercise B

local pa2 = {}

function pa2.mapTable(inputFunction, inputTable)
  local key, value
  for key, value in pairs(inputTable) do
    inputTable[key] = inputFunction(value) 
  end
  return inputTable
end

function pa2.concatMax(inputString, maxLength)
  local modifiedString = ""
  while maxLength >= (string.len(modifiedString) + string.len(inputString)) do
    modifiedString = modifiedString .. inputString
  end
  return modifiedString
end

function pa2.collatz(k)
  return function ()
    if k == 0 then return nil end
   
    local lastK = k
    
    if k == 1 then k = 0 end
   
    if k % 2 == 1 then k = 3 * k + 1 
    else k = k / 2 end
    
    return lastK
  end
end

function pa2.backSubs(s)
  return s
end

return pa2