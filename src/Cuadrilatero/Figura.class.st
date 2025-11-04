Class {
	#name : #Figura,
	#superclass : #Object,
	#instVars : [
		'ancho',
		'alto',
		'posicionX',
		'posicionY',
		'jugador'
	],
	#category : #Cuadrilatero
}

{ #category : #acccessing }
Figura >> alto [
	^ alto
]

{ #category : #acccessing }
Figura >> ancho [
	^ ancho
]

{ #category : #initialization }
Figura >> ancho: a alto: h posicion: unPunto jugador: unJugador [
	ancho := a.
	alto := h.
	posicionX := unPunto x.
	posicionY := unPunto y.
	jugador := unJugador.

]

{ #category : #acccessing }
Figura >> jugador [
	^ jugador
]

{ #category : #operations }
Figura >> ocupaCelda: unPunto [
	"Verifica si esta figura ocupa una celda específica"
	^(unPunto x between: posicionX and: posicionX + ancho - 1)
		and: [unPunto y between: posicionY and: posicionY + alto - 1]

]

{ #category : #acccessing }
Figura >> posicion [
	^ posicionX @ posicionY


]

{ #category : #operations }
Figura >> rotar [
	| temp |
	temp := ancho.
	ancho := alto.
	alto := temp.

]

{ #category : #acccessing }
Figura >> superficie [
	^ ancho * alto
]
