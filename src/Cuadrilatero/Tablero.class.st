Class {
	#name : #Tablero,
	#superclass : #Object,
	#instVars : [
		'filas',
		'columnas',
		'figuras'
	],
	#category : #Cuadrilatero
}

{ #category : #operations }
Tablero >> colocarFigura: ancho alto: alto en: posicion jugador: jugador [
	"Intenta colocar una figura. Retorna la figura o nil si no es posible"
	| nuevaFigura |
	
	(self puedeColocarFigura: ancho alto: alto en: posicion)
		ifFalse: [ ^nil ].
	nuevaFigura := Figura new ancho: ancho alto: alto posicion: posicion jugador: jugador.
	figuras add: nuevaFigura.
	jugador agregarFigura: nuevaFigura.
	^ nuevaFigura
]

{ #category : #acccessing }
Tablero >> columnas [
	^columnas

]

{ #category : #testing }
Tablero >> figura: figura colisionaCon: ancho alto: alto en: posicion [
	"Detecta si hay colisión entre una figura existente y una nueva"		
	| x1 y1 x2 y2 fx fy fancho falto |
	x1 := posicion x.
	y1 := posicion y.
	x2 := x1 + ancho - 1.
	y2 := y1 + alto - 1.

	fx := figura posicion x.
	fy := figura posicion y.
	fancho := figura ancho.
	falto := figura alto.

	^ (x1 <= (fx + fancho - 1)) and: [
		(x2 >= fx) and: [
			(y1 <= (fy + falto - 1)) and: [
				y2 >= fy
			]
		]
	]

]

{ #category : #acccessing }
Tablero >> figuras [
	^figuras

]

{ #category : #acccessing }
Tablero >> filas [
	^filas

]

{ #category : #initialization }
Tablero >> filas: f columnas:c [
	filas:=f.
	columnas:=c.
	figuras:=OrderedCollection new.

]

{ #category : #testing }
Tablero >> puedeColocarFigura: ancho alto: alto en: posicion [
	"Verifica si una figura cabe sin superposición"
	| x y |
	x := posicion x.
	y := posicion y.

	"Verifica superposición con otras figuras"
	figuras do: [ :figura |
		(self figura: figura colisionaCon: ancho alto: alto en: posicion)
			ifTrue: [ ^false ] ].
	^ true
]

{ #category : #operations }
Tablero >> tieneEspacioPara: ancho y: alto [
	"Verifica si existe al menos una posición válida para una figura"
	0 to: columnas - ancho do: [ :x |
		0 to: filas - alto do: [ :y |
			(self puedeColocarFigura: ancho alto: alto en: x @ y)
				ifTrue: [ ^true ]
		]
	].
	^ false

]
