Class {
	#name : #Tablero,
	#superclass : #Object,
	#instVars : [
		'filas',
		'columnas',
		'figuras',
		'jugador1',
		'jugador2',
		'celdas'
	],
	#category : #Cuadrilatero
}

{ #category : #acccessing }
Tablero >> celdas [ 
    ^ celdas
]

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

{ #category : #actions }
Tablero >> colocarObstaculoEn: unPunto [ 
    "Marca una celda como obstáculo (coordenadas desde 0)"
    | x y |
    x := unPunto x.
    y := unPunto y.
    
    "Verificar límites (coordenadas desde 0)"
    (x >= 0 and: [ y >= 0 and: [ x < columnas and: [ y < filas ] ] ])
        ifTrue: [ 
            "Array2D usa índices desde 1"
            (celdas at: (y + 1) at: (x + 1)) marcarComoObstaculo ].

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
Tablero >> filas: f columnas: c [ 
    filas := f.
    columnas := c.
    figuras := OrderedCollection new.
    
    "Inicializar matriz de celdas"
    celdas := Array2D rows: filas columns: columnas.
    1 to: filas do: [ :i |
        1 to: columnas do: [ :j |
            celdas at: i at: j put: Celda new ] ].

]

{ #category : #acccessing }
Tablero >> partida [
    ^ Partida
]

{ #category : #testing }
Tablero >> puedeColocarFigura: ancho alto: alto en: posicion [ 
    | x y |
    x := posicion x.
    y := posicion y.
    
    "Verificar límites del tablero"
    (x < 0 or: [ y < 0 ]) ifTrue: [ ^ false ].
    (x + ancho > columnas) ifTrue: [ ^ false ].
    (y + alto > filas) ifTrue: [ ^ false ].
    
    "Verificar que no haya obstáculos en el área de la figura"
    celdas ifNotNil: [
        x to: (x + ancho - 1) do: [ :i |
            y to: (y + alto - 1) do: [ :j |
                "Array2D usa índices desde 1, nuestras coordenadas son desde 0"
                ((celdas at: (j + 1) at: (i + 1)) esObstaculo) 
                    ifTrue: [ ^ false ] ] ] ].
    
    "Verificar superposición con otras figuras"
    ^ figuras noneSatisfy: [ :figura |
        self figura: figura colisionaCon: ancho alto: alto en: posicion ]

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
