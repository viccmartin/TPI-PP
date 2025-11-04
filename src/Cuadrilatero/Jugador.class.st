Class {
	#name : #Jugador,
	#superclass : #Object,
	#instVars : [
		'superficieTotal',
		'cantidadFiguras',
		'puedeJugar',
		'nombre'
	],
	#category : #Cuadrilatero
}

{ #category : #operations }
Jugador >> agregarFigura: unaFigura [
	superficieTotal := superficieTotal + unaFigura superficie.
	cantidadFiguras := cantidadFiguras + 1.

]

{ #category : #acccessing }
Jugador >> cantidadFiguras [
	^cantidadFiguras
]

{ #category : #initialization }
Jugador >> initialize [
	super initialize.
	superficieTotal := 0.
	cantidadFiguras := 0.
	puedeJugar := true.

]

{ #category : #acccessing }
Jugador >> nombre [
	^nombre
]

{ #category : #acccessing }
Jugador >> nombre: unNombre [
	nombre := unNombre
]

{ #category : #acccessing }
Jugador >> puedeJugar [
	^puedeJugar
]

{ #category : #acccessing }
Jugador >> puedeJugar: unBoolean [
	puedeJugar := unBoolean
]

{ #category : #operations }
Jugador >> puntuacion [
	"Devuelve un Dictionary con las métricas del jugador"
	^Dictionary new
		at: #superficie put: superficieTotal;
		at: #figuras put: cantidadFiguras;
		yourself

]

{ #category : #acccessing }
Jugador >> superficieTotal [
	^superficieTotal
]
