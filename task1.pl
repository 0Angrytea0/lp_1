% Длина списка
length_c([], 0).
length_c([_|T], N) :- length_cu(T, N1), N is N1 + 1.


% Проверка принадлежности элемента списку
member_c(X, [X|_]).
member_c(X, [_|T]) :- member_c(X, T).


% Объединение двух списков
append_c([], L, L).
append_c([H|T], L, [H|R]) :-
    append_custom(T, L, R).


% Удаление элемента из списка
remove_c(_, [], []).
remove_c(X, [X|T], R) :-
    remove_c(X, T, R).
remove_c(X, [H|T], [H|R]) :-
    X \= H,
    remove_c(X, T, R).


% Генерация всех перестановок списка
permute_c([], []).
permute_c(List, [X|Perm]) :-
    select_c(X, List, Rest),
    permute_c(Rest, Perm).


% Является ли список подсписком другого списка
sublist_c(Sublist, List) :-
    append_c(_, Rest, List),
    append_c(Sublist, _, Rest).


% Предикаты обработки списков, вариант 5.

% Со стандартными:
remove_n(L,X,N):-append(X,_,L), length(X, N).
task1(V,N,L):- remove_n(V,H,N), append(H,L,V).
% ?- task1([a,b,c,d,e,f],3,L).
% L=[d,e,f]

% Со своими:
del(X, 0,X).
del([_|X],1,X).
del([_|X],N,X) :- N > 1, N1 is N - 1, del(X,N1,X).
% ?- del([a,b,c,e],1,X).
% X = [b, c, e]

% Предикаты обработки числовых списков, вариант 9.

% Со стандартными
count(L, C):- L=[H|_], findall(H, member(H, L), Cs), length(Cs, C).
% ?- count([a,a,c,a],C).
% С = 3

%Со своими:
count(_,[],0).
count(H,[H|M],X):- count(H,M,X1), X is X1+1.
count(H, [_|M],X):- count(H,M,X).
count_t(L,X):- L=[H|_], count(H,L,X).
% ?- count_t([a,b,a,a,a,c],X).
% X = 4
