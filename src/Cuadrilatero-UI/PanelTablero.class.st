Class {
	#name : #PanelTablero,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tablero',
		'morphTablero'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
PanelTablero class >> defaultSpec [
	<spec>
    ^ SpecLayout composed
        add: #morphTablero;
        yourself
]

{ #category : #'instance creation' }
PanelTablero class >> on: unTablero [ 
    ^ self basicNew
        tablero: unTablero;
        initialize;
        yourself

]

{ #category : #operations }
PanelTablero >> activarModoColocacion: dimensiones [ 
    morphTablero morph activarModoColocacion: dimensiones
]

{ #category : #operations }
PanelTablero >> desactivarModoColocacion [ 
    morphTablero morph desactivarModoColocacion
]

{ #category : #initialization }
PanelTablero >> initializeWidgets [
    morphTablero := MorphicGenericAdapter new.
    morphTablero morph: (TableroMorph on: tablero).

]

{ #category : #accessing }
PanelTablero >> morphTablero [ 
^morphTablero 
]

{ #category : #operations }
PanelTablero >> redibujar [ 
    morphTablero morph redibujar
]

{ #category : #operations }
PanelTablero >> rotarFigura [ 
    morphTablero morph rotarFigura
]

{ #category : #accessing }
PanelTablero >> tablero [ 
^tablero.
]

{ #category : #accessing }
PanelTablero >> tablero: unTablero [ 
    tablero := unTablero

]

{ #category : #operations }
PanelTablero >> whenClickDo: unBloque [ 
    morphTablero morph whenClickDo: unBloque
]
