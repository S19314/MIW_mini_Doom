/** 3.  Elementy dynamiczne  */
:- dynamic whereami/1.
% Мб, убрать?
:- dynamic health_state/1.
healt_state(['I am alive!']).
show_list_healt_state([Head|Tail]) :- write(Head), nl, show_list(Tail).
show_healt_state :- healt_state(X), show_list_healt_state(X).
add_healt_state(Y) :- healt_state(X), append(X, [Y], Z), retractall(healt_state(_)), assert(healt_state(Z)), write(Z).
add_healt_state(Y) :- healt_state(X), delete(X, [Y], Z), retractall(healt_state(_)), assert(healt_state(Z)), write(Z).


/** 5.  Listy (operacje na listach) */
:- dynamic inventory/1.
inventory([]).
% inventory(['Hello world!']).
show_list([Head|Tail]) :- write(Head), nl, show_list(Tail).
show_inventory :- inventory(X), show_list(X).
add_inventory(Y) :- inventory(X), append(X, [Y], Z), retractall(inventory(_)), assert(inventory(Z)), write(Z).
remove_inventory(Y) :- inventory(X), delete(X, Y, Z), retractall(inventory(_)), assert(inventory(Z)), write(Z).

/** 1.1 Fakty DOWN */
room(complex_oak,'comlex OAK'). /** Или через dynamic или через list или как второй агрумент добавить информацию о вещах в комнате. */
room(exit_to_mars, 'Exit to the surface of Mars{END_POINT}').
room(sarcophagus, 'Room with doomguys sarcophagus').
room(raspres_center, 'RaspRes Center').
room(argent_tower, 'Argent Tower').
room(argent_complex, 'Argent Complex').
room(vega_technical_department, 'Vega Technical Department').

/** 1.1 Fakty UP */

/** 1.2. Termy złożone DOWN */
key(red_key, 'hand with Red key card').


transit( exit_to_mars, raspres_center).

transit( raspres_center, exit_to_mars).
transit( raspres_center, complex_oak).
transit( raspres_center, vega_technical_department).
transit( raspres_center, argent_tower).

transit( argent_tower, raspres_center).
transit( argent_tower, vega_technical_department).
transit( argent_tower, argent_complex).

transit( vega_technical_department, raspres_center).
transit( vega_technical_department, argent_complex).
transit( vega_technical_department, argent_tower).
transit( vega_technical_department, complex_oak). 

transit( argent_complex, argent_tower).
transit( argent_complex, complex_oak ).
transit( argent_complex, vega_technical_department).

transit( complex_oak, raspres_center). 
transit( complex_oak, argent_complex).
transit( complex_oak, vega_technical_department).

transit( sarcophagus, complex_oak).
/** 1.2. Termy złożone UP */
/**
transit( B, A) = transit( argent_tower, vega_technical_department).
*/ 

whereami(sarcophagus).
/** 2.  Klauzula DOWN */
info :- whereami(X), room(X,Y), write('Room name: '), write(Y), nl, fail.
/** 2.  Klauzula UP */


/** 2.  Rekurencja DOWN */
road(X,Y) :- write('Show possible ways:\t'), transit(X,Y) ; room(X,Y).
road(X,Y) :- transit(X,Z), road(Z,Y).
/** 2.  Rekurencja UP */

/** 3.  Elementy dynamiczne  add and remove */
go(Y) :- whereami(X), transit(X,Y), retractall(whereami(_)), assert(whereami(Y)), write("You are in "), write(Y), write('.').
% Добавить отображение комнаты.

the_end :- write('Congratulations you finished the game!'), nl, game_title.
%is_not_end :- write('You should find a red key-card or bey near the exit to the Mars surface. ').

info_have_no_key :- write('You should find a red key-card.').
info_not_near_exit(X, Y) :- write('You aren\'t near the '), room(exit_to_mars, X), write(X), write('. You are near '), whereami(Y),write(Y).
go_surface_mars(X, Y) :- whereami(X), X == exit_to_mars -> (member(red_key, inventory) -> the_end ; info_have_no_key) ; info_not_near_exit(X, Y).

% go_surface_mars :- whereami(X), X == exit_to_mars -> member(red_key, inventory(C)) -> the_end ; is_not_end .




/** 4.  Uniﬁkacja, cięcie */
game_title :- write('
88888888ba,                                                  
88      \`\"8b                                                 
88        \`8b                                                
88         88   ,adPPYba,    ,adPPYba,   88,dPYba,,adPYba,   
88         88  a8\"     \"8a  a8\"     \"8a  88P\'   \"88\"    \"8a  
88         8P  8b       d8  8b       d8  88      88      88  
88      .a8P   \"8a,   ,a8\"  \"8a,   ,a8\"  88      88      88  
88888888Y\"\'     \"YbbdP\"\'      \"YbbdP\"\'   88      88      88'), nl, fail.


my_help :- 
	write('For showing game: game_title.
For showing your current location: whereami(X).\nFor showing nearest rooms: road(location_from, Y).
For going to nearest_room: go(nearest_room).\nFor showing doomguy inventory: show_inventory.
When you will be near the Exit to the surface of Marce and if you wish to finish the game: go_surface_mars.
'), fail.
 
