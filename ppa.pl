:- retractall(currently_in(_)),retractall(is_in(_,_)), retractall(description(_,_)), 
retractall(can_go(_,_,_,_,_)).
:- ansi_format([bold,fg(green)],"Enter 'start.' to start the game.", []).


%---------------Shortcuts-----------------------------------------------
n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).
i :- inventory().
l :- look().
r :- consult('ppa.pl').
h :- help().

%---------------Game Start-------------------------------------------------
	
start :-	h(), assert(currently_in('Blood bakery')), information('Blood bakery').

%------------rooms in the dungeon--------
dungeon('Blood bakery').
dungeon('Muderous barber shop').
dungeon('Human Butcher Room').
dungeon('Burial room').
dungeon('Monster Breeding Room').
dungeon('Rat store').
dungeon('Torture room').
dungeon('Large Bedroom').
dungeon('Fake Treasure Room').
dungeon('Secret Treasure Room').
dungeon('Bar').
dungeon('Stables').
dungeon('Kitchen').
dungeon('Junk Room').
dungeon('Ride to Hell').
dungeon('Armory').
dungeon('Observatory').
dungeon('Town Hall').
dungeon('Potion Room').
dungeon('Library').

%--------Descriptions of the rooms--------
:-
assert(description('Blood bakery', "The smell of this place is of delicious bakery items but the baker seems to have a secret ingredient. It is blood of the people he kills. Run before your blood is poured as a delicacy for others!")),

assert(description('Muderous barber shop', "This place seems cleaner than the rest of the dungeon. It is dark in here. The barber likes challenges. Thats a bad thing for the customers. He uses his knife and scissors both in the dark. Try and escape before you are brutally murdered in the name of a challenge.")),

assert(description('Human Butcher Room',"The stench this place to kill you! There is a eerie atmosphere.This is definitely not like any other butchers shop you have been to. You might step on one of your own. The butcher is a well built man and the only way to escape is to not make any noise.")),

assert(description('Burial room', "Heard of the unimaginable? This is the place where you can expect to find the unexpected. Coming back from the dead is the most common thing here so be careful of the next step you take.")),

assert(description('Monster Breeding Room',"This place is filled with eggs. Comparatively warmer than the rest of the dungeon be careful not to disturb a dragon or you shall be burned to death.You have to be agile as you have to take the shiniest egg in the room with you.")),

assert(description('Rat store',"Dungeon is a weird place. Rats are more common as pets than dogs. These rats are not normal. They are the size of a healthy cat.Also you should be careful these rats are messengers of their masters so dont be in sight if you see one.")),

assert(description('Torture room',"Dark and damp place. The air that brushes you bodies has the cries of the people who tried to escape like you. Thousands like you have been tortured to their last breath.")),

assert(description('Large Bedroom', "Hygiene is a myth in this place. Its a rare sight to see anything that is without a yellow stain. The inhumane conditions where all the people from the dungeons sleep.")),

assert(description('Fake Treasure Room',"Do you think they dont know you were going to come in search of the secret room well here you go! Its a trap. You are in the wrong place!")),

assert(description('Secret Treasure Room', "You finally found it. You can earn a way out of the awful place with a key and a treasure. Find it and get your freedom!")),

assert(description('Bar',"This place seems to be better than the rest of the places in the dungeon. There not a lot of danger here. But if you stay here for long you will never get your way out. Dont waste time here this place can cast a spell on you!")),

assert(description('Stables',"Stinky place and the sound of animals who havent been given food after being used for a race!")),

assert(description('Kitchen',"You could rest a little bit here and get some supper as its a long way to go child!")),

assert(description('Junk Room',"This place is a junk on its own. Now imagine what these people throw as junk! This exactly the place you will discover the answers to this question ;) Stay stafe this could be overwhelming.")),

assert(description('Ride to Hell',"These people know how hard it is to get out of this place. But they wouldnt mind some entertainment while you try to. Remember their entertainment means hell for you! And this place is far worse than hell..")),

assert(description('Armory',"Remember, precaution is better than cure.So arm yourself in this place!")),

assert(description('Observatory',"Extraterestrial beings are the ones helping them. There is a certain eagerness to start an inter galaxy war with the help of the people in the dungeon. This is the place they formulate their plans.")),

assert(description('Town Hall',"This might sound like a place where the public gets to ask questions. Dont be blinded by the name. For every question asked there is a penalty. So do not ask questions!!")),

assert(description('Potion Room',"You stand a chance to cure yourself here and feel like you got a new life. Drink the potion here and you shall gain it!")),

assert(description('Library',"A few of the people who tried to escape swear by this place. There was only one man who had escaped this place. He happens to have found knowledge in the books here.")).

%-------To print the description--------------

describe(R) :-	description(R,X), !, write(X), nl.


%----------connection between rooms-------

door('Blood bakery', e,'Muderous barber shop').
door('Muderous barber shop', e,'Rat store').
door('Rat store', e,'Large Bedroom').
door('Large Bedroom', e,'Town Hall').
door('Town Hall', s,'Stables').
door('Stables', w,'Kitchen').
door('Kitchen', w,'Bar').
door('Bar',s,'Monster Breeding Room').
door('Monster Breeding Room', w,'Junk Room').
door('Junk Room', w,'Potion Room').
door('Potion Room', s,'Armory').
door('Armory', e,'Library').
door('Library', e,'Torture room').
door('Torture room', e,'Ride to Hell').
door('Ride to Hell', e,'Secret Treasure Room').


%-------items to be put in inventory-------
:-
assert(is_in(prisoner,alive)),
assert(is_in(prisoner,playing)),
assert(is_in('Life Potion','Potion Room')),
assert(is_in('THE KEY','Secret Treasure Room')),
assert(is_in('Treasure','Secret Treasure Room')),
assert(is_in('Gun','Armory')),
assert(is_in('Death Spell','Bar')),
assert(is_in(teleport,'Armory')),
assert(is_in(dragon,'Monster Breeding Room')),
assert(is_in('Three faced hound','Torture room')),
assert(is_in('Apple','Kitchen')),
assert(is_in('Crackers','Kitchen')),
assert(is_in('Old Steak','Kitchen')),
assert(is_in('red key','Armory')),
assert(is_in('blue key','Monster Breeding Room')),
assert(door('Ride to Hell', e,'Secret Treasure Room',locked,blue)),
assert(door('Potion Room',s,'Armory',locked,red)). 

%----------Check if the items in the inventory are edible--------------	

eatable('Apple').
eatable('Crackers').
rotten('Old Steak').

%--------ensures connection both ways----------------

connect(X,s, Y) :- door(X,s, Y).
connect(X,s, Y) :- door(Y,n, X).
connect(X,n, Y) :- door(X,n, Y).
connect(X,n, Y) :- door(Y,s, X).
connect(X,e, Y) :- door(X,e, Y).
connect(X,e, Y) :- door(Y,w, X).
connect(X,w, Y) :- door(X,w, Y).
connect(X,w, Y) :- door(Y,e, X).

%--------After entering Room----------
information(R) :-	describe(R), 
			list_things(R), 
			enemy(R),
			status(), 
			can_go(R).
%--------Printing all possible directions----------

can_go(R) :-		door(R,n,_), write("Doors are to the north."), nl, fail ;
			door(R,s,_), write("Doors are to the south."), nl, fail ;
			door(R,e,_), write("Doors are to the east." ), nl, fail ;
			door(R,w,_), write("Doors are to the west." ), nl,! ;
				can_go(R,_,'Armory',locked,red),					!,
					ansi_format([fg(red)], 'Red doors are to the south' ,[]);
				can_go(R,_,'Armory',unlocked,red),                                      !,
					ansi_format([fg(red)], 'Red doors are to the south', []);
				can_go(R,_,_,locked,blue),						!,
					ansi_format([fg(blue)], 'Blue doors are to the to the east', []);
				can_go(R,_,_,unlocked,blue),						!,
					ansi_format([fg(blue)], 'Blue doors are to the to the east', []);
				true.

%---------Movement-------------------

go(Direction) :-is_in(prisoner,alive), 
		is_in(prisoner,playing), 
		currently_in(Cur), 
		door(Cur,Direction,Dest), !,
		retract(currently_in(_)), assert(currently_in(Dest)), 
		information(Dest). 

go(Direction) :-	is_in(prisoner,alive), is_in(prisoner,playing), currently_in(Cur), can_go(Cur,Direction,Dest,locked,red), is_in('red key',inventory), !, 		
				retract(can_go(_,_,_,locked,red)), retract(is_in('red key',inventory)), assert(door(Cur,Direction,Dest,unlocked,red)),
				retract(currently_in(_)), assert(currently_in(Dest)), ansi_format([fg(yellow)],"You unlocked the door.~n", []),
				information(Dest).
go(Direction) :-	is_in(prisoner,alive), is_in(prisoner,playing), currently_in(Cur), can_go(Cur,Direction,Dest,locked,blue), is_in('blue key',inventory), !, 	
				retract(can_go(_,_,_,locked,blue)), retract(is_in('blue key',inventory)), assert(door(Cur,Direction,Dest,unlocked,blue)),
				retract(currently_in(_)), assert(currently_in(Dest)), ansi_format([fg(yellow)],"You unlocked the door.~n", []),
				information(Dest).

go(Direction) :-	is_in(prisoner,alive), is_in(prisoner,playing), currently_in(Cur), can_go(Cur,Direction,Dest,unlocked,_), !,									
				retract(currently_in(Cur)), assert(currently_in(Dest)), information(Dest).

go(_) :-		is_in(prisoner,alive), is_in(prisoner,playing), !, ansi_format([fg(red)],"There's no path there or the path is locked!",[]).

go(_) :- 		ansi_format([fg(yellow)],"Game over!~nEnter 'r.' to restart the game or 'halt.' to exit.",[]).

%--------Lists things in the room-------
list_things(R) :- (is_in(X,R),  ansi_format([fg(yellow)],
					 'There''s a ~w in this room!', [X]),
					 nl, fail
					); true.
%----------Prints the information about the room---------------
look() :-		currently_in(R), 
				describe(R), 
				list_things(R),
				can_go(R).
%----------To check if the player is wounded----------------------

wounded(R) :- findall(Y, is_in(Y, body), X),
	      length(X, R).
	      

%------------Checks the current status of the person
status() :-		currently_in('Secret Treasure Room'), ansi_format([bold,fg(white),bg(yellow)], 'You have survived!', []), nl,
				ansi_format([bold,fg(yellow)],"Enter 'r.' to restart the game or 'halt.' to exit.", []), !, retract(is_in(prisoner,playing)), fail.
status() :-		wounded(X),X > 1, ansi_format([bold,fg(blue),bg(magenta)], 'You lost! You are seriously wounded!', []),
				retract(is_in(prisoner,alive)), !, nl,
				ansi_format([bold,fg(red)],"Enter 'r.' to restart the game or 'halt.' to exit.", []),fail.
status() :- 	true.

%-------Pick-------------------------------
pick(destination) :-	ansi_format([bold,fg(red)],"This is not allowed!", []).
pick(teleport)	:-		currently_in(X) ,is_in(teleport,X), !, retractall(is_in(destination,_)), retract(is_in(teleport,X)), assert(is_in(teleport,inventory)),
						ansi_format([fg(green)],"You picked up the item! Drop it in your inventory.", []).
pick(X) :-				currently_in(Y), is_in(X,Y), !, retract(is_in(X,_)), assert(is_in(X,inventory)), ansi_format([fg(green)],"You picked up ~w!", [X]).
pick(_) :- 				ansi_format([fg(red)],"Not found!",[]).

%---------Drop------------------------------------

drop(teleport) :-		is_in(teleport,inventory), !, currently_in(Y), retract(is_in(teleport,inventory)), assert(is_in(teleport,Y)),
						assert(is_in(destination,Y)), ansi_format([fg(blue)],"You chose the room to be ~w.", [Y]).
drop(X) :-				is_in(X,inventory), !, currently_in(Y), retract(is_in(X,inventory)), assert(is_in(X,Y)), ansi_format([fg(blue)],"You dropped the item ~w!", [X]).
drop(_) :-				ansi_format([fg(red)],"Not found!",[]).


%----------Inventory-------------------

inventory() :-	(is_in(X,inventory), 
				ansi_format([underline,fg(magenta)], 'You have ~w in your inventory.', [X]),
				nl, fail); true.



%----------List of options for proceeding-----------------
help() :-																		nl,
			ansi_format([fg(yellow)],"Dungeon Escape controls", []),  nl,
			write("start.         ...     Start game."), nl,
			write("n./s./e./w.    ...     Move in a particular direction."),nl,
			write("i.             ...     Shows your inventory."), nl,
			write("l.             ...     Lists the information of the current room."), nl,
			write("pick(object).  ...     Pick the item from the room and put it into the inventory."), nl,
			write("drop(object).  ...     Drop the item from the inventory to the room."), nl,
			write("use(teleport). ...     To use the life potion or teleport"), nl,
			write("eat(item).   ...     To check if you can eat the item you picked up."), nl,
			write("h./help.       ...     Shows these options"), 	nl,
			write("r.             ...     Restart game"), nl,
			nl, nl.

%-------------- use()-----------------------------------------------------

use('Life Potion') :- 	is_in('Life Potion',inventory), !, retract(is_in('Life Potion',inventory)), retractall(is_in(wounded,_)), ansi_format([fg(green)],"You have been given a new life!", []).
use(teleport) :- 		is_in(teleport,inventory), !, ansi_format([fg(red)],"You have to set a destination!",[]).
use(teleport) :-		is_in(destination,X), !, retract(currently_in(_)), assert(currently_in(X)), retractall(is_in(teleport,_)), retractall(is_in(destination,_)),
						ansi_format([bold,fg(magenta)],"*AND YOU ARE HEREE!*~n", []), information(X).
use(X) :-				is_in(X,inventory), !, ansi_format([fg(blue)]," ~w is not allowed..",[X]).
use(X) :-				ansi_format([fg(red)],"You did not get ~w.",[X]).


%-----------Enemies-------------------------------------------------------------

enemy(X) :-	is_in(dragon,X), (is_in('Death Spell',inventory), ! *->
					retract(is_in(dragon,_)), assert(is_in(killed_1,X)),
					ansi_format([fg(green)], 
					'Use the spell you learnt ~nand think of the dragon when you do so.~n',[])
					;
				assert(is_in(wounded,body)),
				ansi_format([fg(blue),bg(magenta)], 'You don''t remember the spell!!', []), nl), fail.

enemy(X) :-	is_in('Three faced hound',X), (is_in('Gun',inventory), ! *->
					retract(is_in('Three faced hound',_)), assert(is_in(killed_2,X)),
					ansi_format([fg(green)], 
					'Use the gun to shoot down the three headed beast!~n',[])
					;
				assert(is_in(wounded,body)),
				ansi_format([fg(blue),bg(magenta)], 'You forgot to take the Gun from the armory!!', []), nl), fail.

enemy(_) :-	true.

%------------------------END--------------------------------------------

	