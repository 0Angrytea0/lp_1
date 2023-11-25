% Task 2: Relational Data Вариант 2

% The line below imports the data
:- ['four.pl'].


% (1)средний балл для каждого предмета

% Сумма оценок по предмету
% (список оценок, сумма оценок)
sum_grades([],0).
sum_grades([grade(_,Y)|T],N):- sum_grades(T,M), N is Y + M.

% Средний балл для предмета
average_mark(Sub,Mark):-
    subject(Sub,Y),
    sum_grades(Y, Sum),
    length(Y, Len),
    Mark is Sum / Len.

marki:-
    average_mark('Логическое программирование',Mark1),
    write('Средняя оценка по логическому программированию: '), write(Mark1), nl,
    average_mark('Математический анализ',Mark2),
    write('Средняя оценка по математическому анализу: '), write(Mark2), nl,
    average_mark('Функциональное программирование',Mark3),
    write('Средняя оценка по функциональному программированию: '), write(Mark3), nl,
    average_mark('Информатика',Mark4),
    write('Средняя оценка по информатике: '), write(Mark4), nl,
    average_mark('Английский язык',Mark5),
    write('Средняя оценка по английскому языку: '), write(Mark5), nl,
    average_mark('Психология',Mark6),
    write('Средняя оценка по психологии: '), write(Mark6).

/* Тест
?- marki.
Средняя оценка по логическому программированию: 4.107142857142857
Средняя оценка по математическому анализу: 4.035714285714286
Средняя оценка по функциональному программированию: 4.107142857142857
Средняя оценка по информатике: 3.8214285714285716
Средняя оценка по английскому языку: 4
Средняя оценка по психологии: 3.857142857142857
*/

% (2) кол-во несдавших студентов по группам 

% Список всех оценок по всем предметам
all_marks([],L).
all_marks([H|T], List_pass):-
    subject(H,X), 
    all_marks(T, Cur_list), 
    append(X, Cur_list, List_pass).

% Так как один студент может не сдать сразу несколько предметов,
% существует эта функция, чтобы он посчитался за несдавшего только один раз
smart_del(_,[],[]).
smart_del(X,[X|L],L1):-smart_del(X,L,L1).
smart_del(X,[Y|L],[Y|L1]):- X \= Y, smart_del(X,L,L1).

del_same([],[]).
del_same([H|T],[H|T1]):-smart_del(H,T,T2), del_same(T2,T1).

mymember(H, [H|_]).
mymember(H, [_|T]) :- mymember(H, T).

% Считаем несдавших из конкретной группы
count([],L,0).
count([grade(X,Y)|T],L,N):- Y < 3, mymember(X, L), !, count(T,L,N1), N is N1 + 1.
count([_|T],L,N):-count(T,L,N).

do_not_pass_group(Gr,Count):-
    group(Gr, Lgroup),
    findall(Sub, subject(Sub,_), Subs),
    all_marks(Subs, List_pass),
    del_same(List_pass, Cur),
    count(Cur, Lgroup, Count).
/*Тесты
?- do_not_pass_group(103,X).
?- do_not_pass_group(101,X).
*/


% (3)количество не сдавших студентов для каждого из предметов

% студенты-двоечники
grades([grade(_,2)|_]).
grades([_|T]) :- grades(T).

fail_stud :-
    subject('Логическое программирование',L),
    findall(L,grades(L), All1),
    length(All1,C1),
    write('Количество не сдавших логическое программирование: '), write(C1), nl,

    subject('Математический анализ',H),
    findall(H,grades(H), All2),
    length(All2,C2),
    write('Количество не сдавших математический анализ: '), write(C2), nl,

    subject('Функциональное программирование',L3),
    findall(L3,grades(L3), All3),
    length(All3,C3),
    write('Количество не сдавших функциональное программирование: '), write(C3), nl,

    subject('Информатика',L4),
    findall(L4,grades(L4), All4),
    length(All4,C4),
    write('Количество не сдавших информатику: '), write(C4), nl,

    subject('Английский язык',L5),
    findall(L5,grades(L5), All5),
    length(All5,C5),
    write('Количество не сдавших английский язык: '), write(C5), nl,

    subject('Психология',L6),
    findall(L6,grades(L6), All6),
    length(All6,C6),
    write('Количество не сдавших психологию: '), write(C6).

/* Тест
?- fail_stud.
Количество не сдавших логическое программирование: 3
Количество не сдавших математический анализ: 1
Количество не сдавших функциональное программирование: 0
Количество не сдавших информатику: 2
Количество не сдавших английский язык: 2
Количество не сдавших психологию: 2
*/
