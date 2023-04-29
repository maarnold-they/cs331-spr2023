\ check_forth.fs
\ Millard A. Arnold
\ 2023-04-28
\ 
\ For CS 331 Spring 2023
\ Assignment 7, Exercise 2

: collcount { n -- c }
  0
  begin
  n 1 > while
    n 2 mod 0 = if
      n 2 / to n
    else
      n 3 * 1 + to n
    endif
    1 +
  repeat
;  
