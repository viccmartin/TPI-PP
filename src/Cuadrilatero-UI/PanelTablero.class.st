Class {
	#name : #PanelTablero,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tablero',
		'morfTablero'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
PanelTablero class >> defaultSpec [
	<spec>
    ^ SpecLayout composed
        add: #morfTablero;
        yourself
]

{ #category : #'private ' }
PanelTablero >> construirMorfTablero [ 
    | morph filas columnas tamanioCelda |
    filas := tablero filas.
    columnas := tablero columnas.
    tamanioCelda := 30. "pixeles por celda"
    
    morph := Morph new.
    morph color: Color white.
    morph extent: (columnas * tamanioCelda) @ (filas * tamanioCelda).
    
    "Dibujar la grilla"
    self dibujarGrillaEn: morph conCeldaDeTamaño: tamanioCelda.
    
    ^ morph
]

{ #category : #'private ' }
PanelTablero >> dibujarGrillaEn: unMorph conCeldaDeTamaño: tamanioCelda [ 
    | filas columnas |
    filas := tablero filas.
    columnas := tablero columnas.
    
    "Dibujar líneas verticales"
    0 to: columnas do: [ :col |
        | linea |
        linea := LineMorph 
            from: (col * tamanioCelda) @ 0 
            to: (col * tamanioCelda) @ (filas * tamanioCelda) 
            color: Color gray 
            width: 1.
        unMorph addMorph: linea ].
    
    "Dibujar líneas horizontales"
    0 to: filas do: [ :fila |
        | linea |
        linea := LineMorph 
            from: 0 @ (fila * tamanioCelda) 
            to: (columnas * tamanioCelda) @ (fila * tamanioCelda) 
            color: Color gray 
            width: 1.
        unMorph addMorph: linea ].

]

{ #category : #initialization }
PanelTablero >> initializeWidgets [
    morfTablero := MorphicGenericAdapter new.
    morfTablero morph: self construirMorfTablero.

]

{ #category : #acccessing }
PanelTablero >> morfTablero [ 
    ^ morfTablero
 
]

{ #category : #'instance creation' }
PanelTablero >> on: unTablero [
    ^ self basicNew
        tablero: unTablero;
        initialize;
        yourself

]

{ #category : #acccessing }
PanelTablero >> tablero [ 
	^tablero.
]

{ #category : #acccessing }
PanelTablero >> tablero: unTablero [
    tablero := unTablero
]
