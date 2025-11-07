Class {
	#name : #TableroMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'tablero',
		'tamanioCelda',
		'figuraPreview',
		'posicionPreview',
		'puedeColocar',
		'callback'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #'instance creation' }
TableroMorph class >> tablero: unTablero [ [
    ^ self new
        tablero: unTablero;
        yourself
]

]

{ #category : #operations }
TableroMorph >> activarModoColocacion: ancho alto: alto [ [
    "Activa el modo de colocación de figura"
    figuraPreview := Dictionary new
        at: #ancho put: ancho;
        at: #alto put: alto;
        yourself.
    posicionPreview := nil.
    puedeColocar := false.
]

]

{ #category : #'private ' }
TableroMorph >> actualizarValidezPosicion [ [
    "Verifica si la figura se puede colocar en la posición actual"
    | ancho alto |
    posicionPreview ifNil: [ ^ self ].
    figuraPreview ifNil: [ ^ self ].
    
    ancho := figuraPreview at: #ancho.
    alto := figuraPreview at: #alto.
    
    puedeColocar := tablero puedeColocarFigura: ancho alto: alto en: posicionPreview.
]

]

{ #category : #acccessing }
TableroMorph >> callback: unBloque [ [
    "Bloque que se ejecutará cuando se haga click en una posición válida"
    callback := unBloque
]

]

{ #category : #operations }
TableroMorph >> desactivarModoColocacion [ [
    "Desactiva el modo de colocación"
    figuraPreview := nil.
    posicionPreview := nil.
    puedeColocar := false.
    self changed.
]

]

{ #category : #drawing }
TableroMorph >> dibujarFigura: figura en: aCanvas [ [
    | rect colorRect |
    rect := Rectangle 
        origin: (figura posicion x * tamanioCelda) @ (figura posicion y * tamanioCelda)
        extent: (figura ancho * tamanioCelda) @ (figura alto * tamanioCelda).
    
    "Color diferente según el jugador (puedes ajustar esto)"
    colorRect := Color blue alpha: 0.3.
    
    aCanvas fillRectangle: rect color: colorRect.
    aCanvas frameRectangle: rect width: 2 color: Color blue.
]

]

{ #category : #drawing }
TableroMorph >> dibujarFigurasEn: aCanvas [ [
    "Dibuja todas las figuras ya colocadas en el tablero"
    tablero figuras do: [ :figura |
        self dibujarFigura: figura en: aCanvas
    ].
]

]

{ #category : #drawing }
TableroMorph >> dibujarGrillaEn: aCanvas [ [
    | filas columnas |
    filas := tablero filas.
    columnas := tablero columnas.
    
    "Líneas verticales"
    0 to: columnas do: [ :col |
        aCanvas 
            line: (col * tamanioCelda) @ 0 
            to: (col * tamanioCelda) @ (filas * tamanioCelda) 
            width: 1 
            color: Color gray ].
    
    "Líneas horizontales"
    0 to: filas do: [ :fila |
        aCanvas 
            line: 0 @ (fila * tamanioCelda) 
            to: (columnas * tamanioCelda) @ (fila * tamanioCelda) 
            width: 1 
            color: Color gray ].
]

]

{ #category : #drawing }
TableroMorph >> dibujarPreviewEn: aCanvas [ [
    "Dibuja el preview de la figura que se está por colocar"
    | rect  colorRect ancho alto |
    posicionPreview ifNil: [ ^ self ].
    
    ancho := figuraPreview at: #ancho.
    alto := figuraPreview at: #alto.
    
    rect := Rectangle 
        origin: (posicionPreview x * tamanioCelda) @ (posicionPreview y * tamanioCelda)
        extent: (ancho * tamanioCelda) @ (alto * tamanioCelda).
    
    "Color verde si se puede colocar, rojo si no"
    colorRect := puedeColocar 
        ifTrue: [ Color green alpha: 0.3 ]
        ifFalse: [ Color red alpha: 0.3 ].
    
    aCanvas fillRectangle: rect color: colorRect.
    aCanvas frameRectangle: rect width: 2 color: (puedeColocar ifTrue: [ Color green ] ifFalse: [ Color red ]).
]

]

{ #category : #drawing }
TableroMorph >> drawOn: aCanvas [ [
    super drawOn: aCanvas.
    
    "Dibujar la grilla"
    self dibujarGrillaEn: aCanvas.
    
    "Dibujar las figuras ya colocadas"
    self dibujarFigurasEn: aCanvas.
    
    "Dibujar el preview de la figura si existe"
    figuraPreview ifNotNil: [ 
        self dibujarPreviewEn: aCanvas 
    ].
]

]

{ #category : #'event handling' }
TableroMorph >> handlesMouseDown: evt [ [
    ^ true
]

]

{ #category : #'event handling' }
TableroMorph >> handlesMouseOver: evt [ [
    ^ true
]

]

{ #category : #initialization }
TableroMorph >> initialize [ 
	super initialize.
    tamanioCelda := 30.
    figuraPreview := nil.
    posicionPreview := nil.
    puedeColocar := false.
    callback := nil.
    self borderWidth: 2.
    self borderColor: Color black.
    self color: Color white.

]

{ #category : #'event handling' }
TableroMorph >> mouseDown: evt [ [
    "Se ejecuta cuando se hace click en el tablero"
    figuraPreview ifNil: [ ^ self ].
    puedeColocar ifFalse: [ ^ self ].
    
    "Ejecutar el callback si está definido"
    callback ifNotNil: [ 
        callback value: posicionPreview 
    ].
]

]

{ #category : #'event handling' }
TableroMorph >> mouseMove: evt [ [
    "Se ejecuta cuando el mouse se mueve sobre el tablero"
    figuraPreview ifNil: [ ^ self ].
    
    posicionPreview := self posicionCeldaDesde: evt position.
    self actualizarValidezPosicion.
    self changed. "Fuerza redibujar"
]

]

{ #category : #'private ' }
TableroMorph >> posicionCeldaDesde: unPunto [ [
    "Convierte coordenadas de pixel a coordenadas de celda"
    | puntoLocal x y |
    puntoLocal := unPunto - self position.
    x := (puntoLocal x / tamanioCelda) floor.
    y := (puntoLocal y / tamanioCelda) floor.
    ^ x @ y
]

]

{ #category : #operations }
TableroMorph >> rotarFigura [ [
    | ancho alto |
    "Rota la figura preview"
    figuraPreview ifNil: [ ^ self ].
    
    ancho := figuraPreview at: #ancho.
    alto := figuraPreview at: #alto.
    
    figuraPreview at: #ancho put: alto.
    figuraPreview at: #alto put: ancho.
    
    self actualizarValidezPosicion.
    self changed.
]

]

{ #category : #acccessing }
TableroMorph >> tablero [ [
    ^ tablero
]

]

{ #category : #initialization }
TableroMorph >> tablero: unTablero [ [
    tablero := unTablero.
    self extent: (tablero columnas * tamanioCelda) @ (tablero filas * tamanioCelda).
]

]

{ #category : #acccessing }
TableroMorph >> tamanioCelda [ [
    ^ tamanioCelda
]

]
