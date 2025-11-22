Class {
	#name : #TableroMorph,
	#superclass : #Morph,
	#instVars : [
		'tablero',
		'tamanioCelda',
		'figuraPreview',
		'posicionPreview',
		'puedeColocar',
		'callback',
		'modoColocacion'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #'instance creation' }
TableroMorph class >> on: unTablero [
    ^ self new
        tablero: unTablero;
        yourself.
]

{ #category : #'game controls' }
TableroMorph >> activarModoColocacion: dimensiones [
    modoColocacion := true.
    figuraPreview := Dictionary new
        at: #ancho put: dimensiones x;
        at: #alto put: dimensiones y;
        yourself.
    posicionPreview := nil.
    self changed.
]

{ #category : #'game controls' }
TableroMorph >> actualizarValidezPosicion [
    | ancho alto |
    figuraPreview ifNil: [ puedeColocar := false. ^ self ].
    posicionPreview ifNil: [ puedeColocar := false. ^ self ].
    
    ancho := figuraPreview at: #ancho.
    alto := figuraPreview at: #alto.
    
    puedeColocar := tablero puedeColocarFigura: ancho alto: alto en: posicionPreview.

]

{ #category : #initialization }
TableroMorph >> calcularExtension [
    tablero ifNil: [ ^ 360 @ 360 ].
    ^ (tablero columnas * tamanioCelda) @ (tablero filas * tamanioCelda)
	statements
]

{ #category : #'game controls' }
TableroMorph >> desactivarModoColocacion [
    modoColocacion := false.
    figuraPreview := nil.
    posicionPreview := nil.
    self changed.
]

{ #category : #drawing }
TableroMorph >> dibujarFigurasEn: aCanvas [ 
    | origen primerJugador |
    origen := self bounds origin.
    
    tablero figuras ifEmpty: [ ^ self ].
    
    "El primer jugador que colocó una figura"
    primerJugador := tablero figuras first jugador.
    
    tablero figuras do: [ :figura |
        | rect posicion |
        
        posicion := figura posicion.
        
        "Azul cyan para el primer jugador, naranja para el segundo"
        color := (figura jugador == primerJugador)
            ifTrue: [ Color cyan alpha: 0.6 ]
            ifFalse: [ Color orange alpha: 0.6 ].
        
        rect := Rectangle
            origin: origen + ((posicion x * tamanioCelda) @ (posicion y * tamanioCelda))
            extent: (figura ancho * tamanioCelda) @ (figura alto * tamanioCelda).
        
        aCanvas fillRectangle: rect color: color.
        aCanvas frameRectangle: rect width: 2 color: color darker ].
]

{ #category : #drawing }
TableroMorph >> dibujarGrillaEn: aCanvas [
    | filas columnas origen |
    filas := tablero filas.
    columnas := tablero columnas.
    origen := self bounds origin.
    
    "Líneas verticales"
    0 to: columnas do: [ :col |
        aCanvas 
            line: origen + ((col * tamanioCelda) @ 0)
            to: origen + ((col * tamanioCelda) @ (filas * tamanioCelda))
            width: 1 
            color: Color gray ].
    
    "Líneas horizontales"
    0 to: filas do: [ :fila |
        aCanvas 
            line: origen + (0 @ (fila * tamanioCelda))
            to: origen + ((columnas * tamanioCelda) @ (fila * tamanioCelda))
            width: 1 
            color: Color gray ].
]

{ #category : #drawing }
TableroMorph >> dibujarObstaculosEn: aCanvas [
    | origen rect |
    origen := self bounds origin.
    
    "Recorrer todas las celdas"
    0 to: tablero columnas - 1 do: [ :x |
        0 to: tablero filas - 1 do: [ :y |
            "Array2D usa índices desde 1"
            ((tablero celdas at: (y + 1) at: (x + 1)) esObstaculo) ifTrue: [
                rect := Rectangle
                    origin: origen + ((x * tamanioCelda) @ (y * tamanioCelda))
                    extent: tamanioCelda @ tamanioCelda.
                
                "Dibujar obstáculo en gris oscuro"
                aCanvas fillRectangle: rect color: (Color gray darker alpha: 0.7).
                ] ] ].

]

{ #category : #drawing }
TableroMorph >> dibujarPreviewEn: aCanvas [
    | rect colorRect ancho alto origen |
    posicionPreview ifNil: [ ^ self ].
    figuraPreview ifNil: [ ^ self ].
    
    origen := self bounds origin.
    ancho := figuraPreview at: #ancho.
    alto := figuraPreview at: #alto.
    
    rect := Rectangle 
        origin: origen + ((posicionPreview x * tamanioCelda) @ (posicionPreview y * tamanioCelda))
        extent: (ancho * tamanioCelda) @ (alto * tamanioCelda).
    
    colorRect := puedeColocar 
        ifTrue: [ Color green alpha: 0.3 ]
        ifFalse: [ Color red alpha: 0.3 ].
    
    aCanvas fillRectangle: rect color: colorRect.
    aCanvas frameRectangle: rect width: 2 
        color: (puedeColocar ifTrue: [ Color green ] ifFalse: [ Color red ]).
]

{ #category : #drawing }
TableroMorph >> drawOn: aCanvas [ 
    super drawOn: aCanvas.
    tablero ifNil: [ ^ self ].
    
    "Dibujar fondo blanco"
    aCanvas fillRectangle: self bounds color: Color white.
    
    "Dibujar obstáculos primero (para que queden debajo)"
    tablero celdas ifNotNil: [ self dibujarObstaculosEn: aCanvas ].
    
    "Dibujar la grilla"
    self dibujarGrillaEn: aCanvas.
    
    "Dibujar las figuras ya colocadas"
    self dibujarFigurasEn: aCanvas.
    
    "Dibujar el preview si está en modo colocación"
    modoColocacion ifTrue: [ self dibujarPreviewEn: aCanvas ].

]

{ #category : #'event handling' }
TableroMorph >> handlesMouseDown: evt [
    ^ true
]

{ #category : #'event handling' }
TableroMorph >> handlesMouseOver: evt [
    ^ true
]

{ #category : #initialization }
TableroMorph >> initialize [
    super initialize.
    figuraPreview := nil.
    posicionPreview := nil.
    puedeColocar := false.
    callback := nil.
    modoColocacion := false.
    self borderWidth: 2.
    self borderColor: Color black.
    self color: Color white.

]

{ #category : #'event handling' }
TableroMorph >> mouseDown: evt [
    modoColocacion ifFalse: [ ^ self ].
    posicionPreview ifNil: [ ^ self ].
    puedeColocar ifFalse: [ ^ self ].
    
    callback ifNotNil: [ callback value: posicionPreview ].
]

{ #category : #'event handling' }
TableroMorph >> mouseMove: evt [
| puntoLocal celdaX celdaY |
    modoColocacion ifFalse: [ ^ self ].
    puntoLocal := evt position - self bounds origin.
    celdaX := puntoLocal x // tamanioCelda.
    celdaY := puntoLocal y // tamanioCelda.
    
    (posicionPreview ~= (celdaX @ celdaY)) ifTrue: [
        posicionPreview := celdaX @ celdaY.
        self actualizarValidezPosicion.
        self changed ].

]

{ #category : #'game controls' }
TableroMorph >> redibujar [
    self changed.
]

{ #category : #'game controls' }
TableroMorph >> rotarFigura [
    | temp |
    figuraPreview ifNil: [ ^ self ].
    
    temp := figuraPreview at: #ancho.
    figuraPreview at: #ancho put: (figuraPreview at: #alto).
    figuraPreview at: #alto put: temp.
    
    self actualizarValidezPosicion.
    self changed.
]

{ #category : #accessing }
TableroMorph >> tablero: unTablero [
    | tamanoFijo |
    tablero := unTablero.
    
    "Tamaño fijo del tablero en píxeles"
    tamanoFijo := 400.
    
    "Calcular tamaño de celda según cantidad de filas/columnas"
    "Usamos el máximo entre filas y columnas para que las celdas sean cuadradas"
    tamanioCelda := tamanoFijo // (tablero filas max: tablero columnas).
    
    "Establecer el extent del tablero"
    self extent: (tablero columnas * tamanioCelda) @ (tablero filas * tamanioCelda).
]

{ #category : #'game controls' }
TableroMorph >> whenClickDo: aBlock [
    callback := aBlock.
]
