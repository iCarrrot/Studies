% Cukier syntaktyczny
word --> "".
word --> "a", word, "b".
% U�ywanie expand_term: expand_term((word-->"a",word,"b"|""),X).
% Ile program robi nawr�t�w?
% "" - 0
% "aabb" - 1
% "aba" - 3
word2 --> [].
word2 --> [a], word2, [b],!. % deterministyczne
% Z liczeniem
word3(X) --> [a],{!},  word3(Y),{X is Y + 1}, [b].
word3(0) --> [].

% Wywo�ywanie: phrase(word3(X), [a,a,b,b]).
