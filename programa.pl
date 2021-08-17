% Aquí va el código.

%EL Kioskito de DODAIN

%%%%%%%%%%%%%%%%%%%%%%%%Punto1: calentando motores 

%atiende(persona,Dia,horario(HoraEntrada,HoraSalida))
atiende(dodain, lunes, horario(9,15) ).
atiende(dodain, miercoles, horario(9,15) ).
atiende(dodain, viernes, horario(9,15) ).

atiende(lucas, martes, horario(10, 20) ).

atiende(juanC, sabado, horario(18, 22)).
atiende(juanC, domingo, horario(18, 22)).

atiende(juanFdS, jueves, horario(10, 20)).
atiende(juanFdS, viernes, horario(12, 20)).

atiende(leoC, lunes, horario(14, 18)).
atiende(leoC, miercoles, horario(14, 18)).

atiende(martu, miercoles, horario(23, 24)).

%Mas Clausulas
%Vale
atiende(vale, Dia, horario(Entrada,Salida)):-
    atiende(dodain, Dia, horario(Entrada,Salida)).

atiende(vale, Dia, horario(Entrada,Salida)):-
    atiende(juanC, Dia, horario(Entrada,Salida)).

%nadie
%atiende(nadie, _, Horario):- %no se especifica cuando lo hace 
%    atiende(leoC, _, Horario).

%maiu 
%estaPensando hacer un horario eso no es un hecho, no se tienen en cuenta pensamientos o ideas, se modelan hechos concretos

%Punto 2 
atiendeATalHora(Persona, Dia, Hora):-
    empleado(Persona),
    dia(Dia),
%    hora(Hora),

    atiende(Persona, Dia, horario(E,S)),
    between(E, S, Hora).
    
empleado(Persona):- atiende(Persona, _, _).
dia(Dia):-          atiende(_, Dia, _). 
%dia(Dia):-          member(Dia, [lunes, martes, miercoles, jueves, viernes, sabado, domingo]).


%hora(Hora):-        between(0, 24, Hora).


%Punto 3: foreverAlone

/*
foreverAlone(Persona, Dia, Hora):-
    atiendeATalHora(Persona, Dia, Hora),    %si atiende una persona
    atiende(OtraPersona,_ ,_),              
    Persona \= OtraPersona,
    not(atiendeATalHora(OtraPersona, Dia, Hora)).% no hay otra persona 
*/


foreverAlone(Persona, Dia, Hora):-              % hecho por Moyano
    atiendeATalHora(Persona, Dia,Hora),
    not( hayDos( Dia, Hora) ).

hayDos(Dia, Hora):-
    atiendeATalHora(X, Dia,Hora),
    atiendeATalHora(Y, Dia,Hora),
    X \= Y.


%Punto 4:Posibilidades de Atencion

%quienAtiende(Dia,Empleados):-
%    atiende(Persona, Dia, _),
%    findall(Persona, atiendeATalHora(Persona, Dia, Hora) ,Empleados).
%    %list_to_set(PersonasRepetidas, Empleados).
%
%estanAtendiendo(Dia, Hora, Personas):-
%    atiendeATalHora(Persona1, Dia, Hora).




%Punto 5:

%golosinas(Valor)
%cigarrillos([marca])

%bebidas(a,Cantidad) | bebidas(n,cantidad)), &a= alcoholica y n=no-alcoholica

vendio(dodain, agosto(10), [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
vendio(dodain, agosto(12), [bebidas(a, 8), bebidas(n, 1), golosinas(10)]).
vendio(martu, agosto(12),  [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
vendio(lucas, agosto(11),  [golossinas(600)]).
vendio(lucas, agosto(18),  [bebidas(a, 0), bebidas(n, 2), cigarrillos(derby)]).

suertuda(Persona, PrimerVenta):-
    vendio(Persona, _, _),  
    forall(
        vendio(Persona, _, [PrimerVenta |_]),     %para todo dia en el que vendio
        importante(PrimerVenta)).                           %su primer venta fue importante

importante(golosinas(Valor)):-      Valor > 100.
importante(cigarrillos(Marcas)):-   length(Marcas, Cant),   Cant > 2.
importante(bebidas(a, _)).
importante(bebidas(n, Cant)):-      Cant > 5.
