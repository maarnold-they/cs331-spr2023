-- lexit.lua
-- Millard A. Arnold V
-- 2023-02-21
--
-- For CS 331 Spring 2023
-- Assignment 3 lexer for 'Maleo'
-- Used in Assignment 3 Exercise B

local lexit = {}

lexit.KEY = 1
lexit.ID = 2
lexit.NUMLIT = 3
lexit.STRLIT = 4
lexit.OP = 5
lexit.PUNCT = 6
lexit.MAL = 7

lexit.catnames = {
  "Keyword",
  "Identifier",
  "NumericLiteral",
  "StringLiteral",
  "Operator",
  "Punctuation",
  "Malformed"
}

local function isLetter(c)
  if c:len() == 1 and ((c >= "A" and c <= "Z") or (c >= "a" and c <= "z")) then
    return true
  end
  return false
end

local function isDigit(c)
  if c:len() == 1 and (c >= "0" and c <= "9") then
    return true
  end
  return false
end

local function isWhitespace(c)
  if c:len() == 1 and (c == " " or c == "\t" or c == "\v" or c == "\n" or c == "\r" or c == "\f") then
    return true
  end
  return false
end

local function isPrintableASCII(c)
  if c:len() == 1 and c >= " " and c <= "~" then
    return true
  else
    return false
  end
end

local function isIllegal(c)
  if isWhitespace(c) or isPrintableASCII(c) then
    return false
  else
    return true
  end
end

-- Lexer

function lexit.lex(program)
  -- data members
  
  local pos
  local state
  local ch
  local lexstr
  local category
  local handlers
  
  -- States
  
  local DONE = 0
  local START = 1
  local LETTER = 2
  local DIGIT = 3
  local EXPONENT = 4
  local QUOTE = 5
  local EQUAL = 6
  local BANG = 7
  local LESSTHAN = 8
  local GREATERTHAN = 9
  local PLUS = 10
  local MINUS = 11
  local STAR = 12
  local FSLASH = 13
  local MODULO = 14
  local RBRACKET = 15
  local LBRACKET = 16
  local COMMENT = 17
  
  local function currChar()
    return program:sub(pos,pos)
  end
  
  local function nextChar()
    return program:sub(pos+1,pos+1)
  end
  
  local function next2Char()
    return program:sub(pos+2,pos+2)
  end
  
  local function drop1()
    pos = pos + 1
  end
  
  local function add1()
    lexstr = lexstr .. currChar()
    drop1()
  end
  
  local function skipToNextLexeme()
    if state == COMMENT then
      while currChar() ~= '\n' and currChar() ~= '' do
        drop1()
      end
      return
    end
    while true do
      while isWhitespace(currChar()) do
        drop1()
      end
      if not ((currChar() == '-' and nextChar() == '-') or (currChar() == '#' and nextChar() == '!')) then
        break
      end
      drop1()
      drop1()
      while true do
        if currChar() == "\n" then
          drop1()
          break
        elseif currChar() == "" then
          return
        end
        drop1()
      end
    end
  end
  
  --State handlers
  local function handle_DONE()
    error("'DONE' state should not be handled\n")
  end
  
  local function handle_START()
    if isIllegal(ch) then
      add1()
      state = DONE
      category = lexit.MAL
    elseif isLetter(ch) or ch == "_" then
      add1()
      state = LETTER
    elseif isDigit(ch) then
      add1()
      state = DIGIT
    elseif ch == '"' or ch == "'" then
      add1()
      state = QUOTE
    elseif ch == '=' then
      add1()
      state = EQUAL
    elseif ch == '!' then
      add1()
      state = BANG
    elseif ch == '<' then
      add1()
      state = LESSTHAN
    elseif ch == '>' then
      add1()
      state = GREATERTHAN
    elseif ch == '+' then
      add1()
      state = PLUS
    elseif ch == '-' then
      if nextChar() == '-' then
        add1()
        add1()
        state = COMMENT
      else
        add1()
        state = MINUS
      end
    elseif ch == '*' then
      add1()
      state = STAR
    elseif ch == '/' then
      add1()
      state = FSLASH
    elseif ch == '%' then
      add1()
      state = MODULO
    elseif ch == '[' then
      add1()
      state = LBRACKET
    elseif ch == ']' then
      add1()
      state = RBRACKET
    elseif ch == '#' and nextChar() == '!' then
      add1()
      state = COMMENT
    elseif isWhitespace(ch) then
      drop1()
    else
      add1()
      state = DONE
      category = lexit.PUNCT
    end
  end
  
  local function handle_LETTER()
    if isLetter(ch) or ch == '_' or isDigit(ch) then
      add1()
    else
      state = DONE
      if lexstr == "and" or lexstr == "char" or lexstr == "cr" or lexstr == "do"  or
      lexstr == "else" or lexstr == "elseif" or lexstr == "end" or lexstr == "false" or
      lexstr == "function" or lexstr == "if" or lexstr == "not" or lexstr == "or" or 
      lexstr == "rand" or lexstr == "read" or lexstr == "return" or lexstr == "then" or
      lexstr == "true" or lexstr == "while" or lexstr == "write" then
        category = lexit.KEY
      else
        category = lexit.ID
      end
    end
  end
  
  local function handle_DIGIT()
    if isDigit(ch) then
      add1()
    elseif (ch == "e" or ch == "E") and 
    (isDigit(nextChar()) or (nextChar() == '+' and isDigit(next2Char()))) then
      add1()
      state = EXPONENT
    else
      state = DONE
      category = lexit.NUMLIT
    end
  end
  
  local function handle_EXPONENT()
    if isDigit(ch) or (ch == "+" and isDigit(nextChar())) then
      add1()
    else
      state = DONE
      category = lexit.NUMLIT
    end
  end
  
  local function handle_QUOTE()
    local qc = lexstr:sub(1,1)
    while currChar() ~= qc do
      if currChar() == '\n' or currChar() == '' then
        category = lexit.MAL
        state = DONE
        return
      end
      add1()
    end
    add1()
    state = DONE
    category = lexit.STRLIT
  end
  
  local function handle_EQUAL()
    if currChar() == '=' then
      add1()
    end
    state = DONE
    category = lexit.OP
  end
  
  local function handle_BANG()
    if currChar() == '=' then
      add1()
      state = DONE
      category = lexit.OP
    else
      state = DONE
      category = lexit.PUNCT
    end
  end
  
  local function handle_LESSTHAN()
    if currChar() == '=' then
      add1()
    end
    state = DONE
    category = lexit.OP
  end
  
  local function handle_GREATERTHAN()
    if currChar() == '=' then
      add1()
    end
    state = DONE
    category = lexit.OP
  end
  
  local function handle_PLUS()
    state = DONE
    category = lexit.OP
  end
  
  local function handle_MINUS()
    if currChar() == '-' then
      add1()
    else
      state = DONE
      category = lexit.OP
    end
  end
  
  local function handle_STAR()
    state = DONE
    category = lexit.OP
  end
  
  local function handle_FSLASH()
    state = DONE
    category = lexit.OP
  end
  
  local function handle_MODULO()
    state = DONE
    category = lexit.OP
  end
  
  local function handle_RBRACKET()
    state = DONE
    category = lexit.OP
  end
  
  local function handle_LBRACKET()
    state = DONE
    category = lexit.OP
  end
  

  local function handle_COMMENT()
    skipToNextLexeme()
  end

  
  handlers = {
    [DONE] = handle_DONE,
    [START] = handle_START,
    [LETTER] = handle_LETTER,
    [DIGIT] = handle_DIGIT,
    [EXPONENT] = handle_EXPONENT,
    [QUOTE] = handle_QUOTE,
    [EQUAL] = handle_EQUAL,
    [BANG] = handle_BANG,
    [LESSTHAN] = handle_LESSTHAN,
    [GREATERTHAN] = handle_GREATERTHAN,
    [PLUS] = handle_PLUS,
    [MINUS] = handle_MINUS,
    [STAR] = handle_STAR,
    [FSLASH] = handle_FSLASH,
    [MODULO] = handle_MODULO,
    [RBRACKET] = handle_RBRACKET,
    [LBRACKET] = handle_LBRACKET,
    [COMMENT] = handle_COMMENT,
    }
  
  local function getLexeme(dummy1, dummy2)
    if pos > program:len() then
      return nil, nil
    end
    lexstr = ""
    state = START
    while state ~= DONE do
      ch = currChar()
      handlers[state]()
    end
    
    skipToNextLexeme()
    return lexstr, category
  end
  
  pos = 1
  skipToNextLexeme()
  return getLexeme, nil, nil
  
end

return lexit