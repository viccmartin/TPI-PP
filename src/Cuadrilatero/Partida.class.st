Class {
	#name : #Partida,
	#superclass : #Object,
	#instVars : [
		'jugador1',
		'tablero',
		'turnoActual',
		'dado1',
		'dado2',
		'finalizada',
		'jugador2'
	],
	#category : #Cuadrilatero
}

{ #category : #operations }
Partida >> cambiarTurno [
	turnoActual := (turnoActual = jugador1)
		ifTrue: [ jugador2 ]
		ifFalse: [ jugador1 ].

]

{ #category : #operations }
Partida >> colocarFigura: ancho alto: alto en: posicion [
	"Coloca figura del jugador actual. Retorna true si tuvo éxito"
	| figura |
	figura := tablero colocarFigura: ancho alto: alto en: posicion jugador: turnoActual.
	figura ifNil: [ ^ false ].

	self cambiarTurno.
	self verificarFinDePartida.
	^ true

]

{ #category : #operations }
Partida >> determinarGanador [
	"Retorna un Dictionary con el resultado"
	| s1 s2 f1 f2 |
	finalizada ifFalse: [ ^ nil ].

	s1 := jugador1 superficieTotal.
	s2 := jugador2 superficieTotal.
	f1 := jugador1 cantidadFiguras.
	f2 := jugador2 cantidadFiguras.

	^ (s1 > s2 or: [ s1 = s2 and: [ f1 > f2 ] ])
		ifTrue: [ Dictionary new at: #ganador put: jugador1; yourself ]
		ifFalse: [
			(s2 > s1 or: [ s2 = s1 and: [ f2 > f1 ] ])
				ifTrue: [ Dictionary new at: #ganador put: jugador2; yourself ]
				ifFalse: [ Dictionary new at: #empate put: true; yourself ]
		]

]

{ #category : #acccessing }
Partida >> finalizada [
	^ finalizada

]

{ #category : #operations }
Partida >> finalizarManualmente [
	^ Dictionary new
		at: #interrumpida put: true;
		yourself


]

{ #category : #acccessing }
Partida >> jugador1 [
	^ jugador1
]

{ #category : #initialization }
Partida >> jugador1: j1 jugador2: j2 tablero: unTablero [
	jugador1 := j1.
	jugador2 := j2.
	tablero := unTablero.
	turnoActual := jugador1.
	dado1 := Dado new.
	dado2 := Dado new.
	finalizada := false.

]

{ #category : #acccessing }
Partida >> jugador2 [
	^ jugador2
]

{ #category : #acccessing }
Partida >> tablero [
	^ tablero
]

{ #category : #operations }
Partida >> tirarDados [
	"Retorna un Dictionary con las dimensiones"
	^ Dictionary new
		at: #ancho put: dado1 lanzar;
		at: #alto put: dado2 lanzar;
		yourself

]

{ #category : #acccessing }
Partida >> turnoActual [
	^ turnoActual
]

{ #category : #operations }
Partida >> verificarFinDePartida [
	"Verifica si ambos jugadores no pueden jugar más"
	(jugador1 puedeJugar not and: [ jugador2 puedeJugar not ])
		ifTrue: [ finalizada := true ].

]

{ #category : #operations }
Partida >> verificarJugadorPuedeColocar: ancho alto: alto [
	"Verifica si el jugador actual puede colocar la figura"
	| puede puedeRotada |
	puede := tablero tieneEspacioPara: ancho y: alto.
	puedeRotada := tablero tieneEspacioPara: alto y: ancho.

	(puede not and: [ puedeRotada not ]) ifTrue: [
		turnoActual puedeJugar: false.
		self cambiarTurno.
		self verificarFinDePartida
	].

	^ puede or: [ puedeRotada ]

]
