pelicula(pelicula1, actor1).
pelicula(pelicula1, kevinBacon).
pelicula(pelicula2, actor2).
pelicula(pelicula2, actor1).
pelicula(pelicula3, actor1).
pelicula(pelicula3, actor3).
pelicula(pelicula3, actor4).
pelicula(pelicula3, actor5).
pelicula(pelicula4, actor3).
pelicula(pelicula5, actor3).
pelicula(pelicula6, actor5).
pelicula(pelicula7, actor6).
pelicula(pelicula8, actor6).
pelicula(pelicula9, actor6).
pelicula(pelicula9, actor4).

%%%%% Punto 1
%%% Versión sin preocuparse por loops o múltiples números por actor
actuaronJuntos(Actor, OtroActor) :-
    pelicula(Pelicula, Actor),
    pelicula(Pelicula, OtroActor),
    Actor \= OtroActor.

numeroBacon(kevinBacon, 0).
numeroBacon(Actor, Numero) :-
    actuaronJuntos(Actor, OtroActor),
    numeroBacon(OtroActor, NumeroDelOtro),
    Numero is 1 + NumeroDelOtro.

%%% Versión eliminando loops
% Sólo para arrancar la recursividad
numeroBaconSinLoops(Actor, Numero) :-
    numeroBacon2(Actor, Numero, []).

% Versión alternativa de numeroBacon que va guardando los ya chequeados
verificarNoChequeado(Actor, Chequeados, NuevaListaDeChequeados):-
    not(member(Actor, Chequeados)),
    append(Chequeados, [Actor], NuevaListaDeChequeados).

numeroBacon2(kevinBacon, 0, _).
numeroBacon2(Actor, Numero, Chequeados) :-
            actuaronJuntos(Actor, OtroActor),
            verificarNoChequeado(Actor, Chequeados, NuevaListaDeChequeados),
            numeroBacon2(OtroActor, NumeroDelOtro, NuevaListaDeChequeados),
            Numero is 1 + NumeroDelOtro.

%%% Versión eliminando loops pero también quedándose sólo con el menor número bacon posible.

numeroBaconSinRepetidosUnico(Actor, Numero) :-
    numeroBacon2(Actor, Numero, []),
    forall(numeroBacon2(Actor, OtroPosibleNumero, []), Numero =< OtroPosibleNumero).


%%%%% Punto 2
actorConMenosQue(Numero, Actor):-
    numeroBaconSinRepetidosUnico(Actor, NumeroDeBacon), 
    NumeroDeBacon < Numero.
numeroMenorQue(Numero, Actores) :-
  findall(Actor, actorConMenosQue(Numero, Actor), Actores).

%%%%% Punto 3
confirmarTeoria :- forall(numeroBaconSinRepetidosUnico(_, NumeroDeBacon), (NumeroDeBacon < 6)).
