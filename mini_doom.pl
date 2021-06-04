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

item(bfg_gun, 'BFG-9000').
item(armor, 'Armor').
item(red_key, 'hand with Red key card').

item_in_room(argent_complex, red_key).
item_in_room(argent_tower, armor).
item_in_room(vega_technical_department, bfg_gun).

check() :- whereami(X), item_in_room(X, Y), item(Y,Z), write(Z).
% check() :- whereami(X), item_in_room(X, Y), write(Y). % item(Y,Z), write(Z).
put_item_inv() :- whereami(X), item_in_room(X,Y), add_inventory(Y). % inv -> inventory


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


 show_demon :- write('
 +-----------------------------------------------------------------------------+
| |       |\\                                           -~ /     \\  /          |
|~~__     | \\                                         | \\/       /\\          /|
|    --   |  \\                                        | / \\    /    \\     /   |
|      |~_|   \\                                   \\___|/    \\/         /      |
|--__  |   -- |\\________________________________/~~\\~~|    /  \\     /     \\   |
|   |~~--__  |~_|____|____|____|____|____|____|/ /  \\/|\\ /      \\/          \\/|
|   |      |~--_|__|____|____|____|____|____|_/ /|    |/ \\    /   \\       /   |
|___|______|__|_||____|____|____|____|____|__[]/_|----|    \\/       \\  /      |
|  \\mmmm :   | _|___|____|____|____|____|____|___|  /\\|   /  \\      /  \\      |
|      B :_--~~ |_|____|____|____|____|____|____|  |  |\\/      \\ /        \\   |
|  __--P :  |  /                                /  /  | \\     /  \\          /\\|
|~~  |   :  | /                                 ~~~   |  \\  /      \\      /   |
|    |      |/                        .-.             |  /\\          \\  /     |
|    |      /                        |   |            |/   \\          /\\      |
|    |     /                        |     |            -_   \\       /    \\    |
+-----------------------------------------------------------------------------+
|          |  /|  |   |  2  3  4  | /~~~~~\\ |       /|    |_| ....  ......... |
|          |  ~|~ | % |           | | ~J~ | |       ~|~ % |_| ....  ......... |
|   AMMO   |  HEALTH  |  5  6  7  |  \\===/  |    ARMOR    |#| ....  ......... |
+-----------------------------------------------------------------------------+
' ).

show_death :- write('     _            _   _     
    | |          | | | |    
  __| | ___  __ _| |_| |__  
 / _\` |/ _ \\/ _\` | __| \'_ \\ 
| (_| |  __/ (_| | |_| | | |
 \\__,_|\\___|\\__,_|\\__|_| |_|').

show_killed_demon() :- write('Demon was killed!!!!!').
who_win_fight() :- show_demon, (member(bfg_gun, inventory) ; member(armor, inventory)) -> show_killed_demon() ; show_death, halt .

% who_win_fight() :- show_demon, (member(bfg_gun, invetory) + member(armor, inventory)) -> show_killed_demon() ; show_death, halt .

% Где-то тут ошибка.

/** 3.  Elementy dynamiczne  add and remove */
go(Y) :- whereami(X), transit(X,Y), retractall(whereami(_)), assert(whereami(Y)), write("You are in "), write(Y), write('.'), 
whereami(Z), Z == raspres_center -> who_win_fight() ; write('').

% Добавить отображение комнаты.
the_end :- write('Congratulations you finished the game!'), nl, game_title, halt.

info_have_no_key :- write('You should find a red key-card.').
info_not_near_exit() :- write('You aren\'t near the '), room(exit_to_mars, X), write(X), write('. You are near '), whereami(Y), write(Y), write('.').

go_surface_mars() :- whereami(X), X == exit_to_mars -> (member(red_key, inventory) -> the_end ; info_have_no_key) ; info_not_near_exit().




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
	write('1. For showing name of game : game_title.
2. For showing your current location: whereami(X).\n3.For showing nearest rooms: road(location_from, Y).
4. For going to nearest_room: go(nearest_room).\n5.For showing doomguy inventory: show_inventory.
6. When you will be near the Exit to the surface of Marce and if you wish to finish the game: go_surface_mars().
7. Looking for new items in room: check().\n8. For putting item from room to your inventory: put_item_inv().
'), fail.
 
