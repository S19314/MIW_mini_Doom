/** 3.  Elementy dynamiczne  */
:- dynamic whereami/1.

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
transit(raspres_center, exit_to_mars).
transit(raspres_center, complex_oak).
transit(raspres_center, vega_technical_department).
transit(raspres_center, argent_tower).

transit(argent_tower, raspres_center).
transit(argent_tower, vega_technical_department).
transit(argent_tower, argent_complex).

transit(vega_technical_department, raspres_center).
transit(vega_technical_department, argent_complex).
transit(vega_technical_department, argent_tower).
transit(vega_technical_department, complex_oak).

transit(complex_oak, raspres_center).
transit(complex_oak, argent_complex).
transit(complex_oak, vega_technical_department).

transit(sarcophagus, complex_oak).
/** 1.2. Termy złożone UP */


whereami(sarcophagus).
/** 2.  Klauzula DOWN */
info :- whereami(X), room(X,Y), write('Room name: '), write(Y), nl, fail.
/** 2.  Klauzula UP */


/** 2.  Rekurencja DOWN */
road(X,Y) :- write('Show possible ways:\t'), transit(X,Y) ; room(X,Y).
road(X,Y) :- transit(X,Z), road(Z,Y).
/** 2.  Rekurencja UP */


/** 3.  Elementy dynamiczne  add and remove */

/** 4.  Uniﬁkacja, cięcie */
/** 5.  Listy (operacje na listach) */

go(Y) :- whereami(X), transit(X,Y), retractall(whereami(_)), assert(whereami(Y)).






title_doom :- write('
88888888ba,                                                  
88      \`\"8b                                                 
88        \`8b                                                
88         88   ,adPPYba,    ,adPPYba,   88,dPYba,,adPYba,   
88         88  a8\"     \"8a  a8\"     \"8a  88P\'   \"88\"    \"8a  
88         8P  8b       d8  8b       d8  88      88      88  
88      .a8P   \"8a,   ,a8\"  \"8a,   ,a8\"  88      88      88  
88888888Y\"\'     \"YbbdP\"\'      \"YbbdP\"\'   88      88      88'), nl, fail.

 
