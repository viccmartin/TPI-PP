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
        newRow: [ :row | row add: #morphTablero ];
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
PanelTablero >> activarModoColocacion: ancho alto: alto [ [
    "Delega al TableroMorph"
    self tableroMorph activarModoColocacion: ancho alto: alto
]

]

{ #category : #operations }
PanelTablero >> actualizar [ [
    "Fuerza actualización visual del tablero"
    self tableroMorph  changed
]

]

{ #category : #operations }
PanelTablero >> callback: unBloque [ [
    "Define el callback que se ejecuta al hacer click"
    self tableroMorph  callback: unBloque
]

]

{ #category : #operations }
PanelTablero >> desactivarModoColocacion [ [
    "Delega al TableroMorph"
    self tableroMorph  desactivarModoColocacion
]

]

{ #category : #initialization }
PanelTablero >> initializeWidgets [
    morphTablero := MorphicGenericAdapter new.
    morphTablero morph: (TableroMorph  tablero: tablero)


]

{ #category : #acccessing }
PanelTablero >> morphTablero [
    ^ morphTablero
 
]

{ #category : #operations }
PanelTablero >> rotarFigura [ [
    "Delega al TableroMorph"
    self tableroMorph  rotarFigura
]

]

{ #category : #acccessing }
PanelTablero >> tablero [ 
	^tablero.
]

{ #category : #acccessing }
PanelTablero >> tablero: unTablero [
    tablero := unTablero
]

{ #category : #acccessing }
PanelTablero >> tableroMorph [ [
    "Acceso al morph interno"
    ^ morphTablero morph
]

]
