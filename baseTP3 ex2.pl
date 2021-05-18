fibonacci(1,1).
fibonacci(0,1).
fibonacci(X, Y) :- X>=2,Z is X - 1, M is X - 2,fibonacci(Z, A),fibonacci(M, B),Y is A + B.
