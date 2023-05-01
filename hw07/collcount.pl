% Millard A. ArN0ld V
% 2023-04-30
% 
% For CS 331 Spring 2023
% Solution to Assignment 7 Exercise 4

% collcount\2
% collcount(+n, ?c)

collcount(1, 0).
collcount(N0, C0) :-
  N0 > 1,
  N0 mod 2 =:= 0,
  N1 is N0 / 2,
  collcount(N1, C1),
  C0 is C1 + 1.
collcount(N0, C0) :-
  N0 > 1,
  N0 mod 2 =:= 1,
  N1 is (3 * N0 + 1),
  collcount(N1, C1),
  C0 is C1 +  1.