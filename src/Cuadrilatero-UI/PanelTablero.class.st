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
PanelTablero >> activarModoColocacion: ancho alto: alto [ 
    "Delega al TableroMorph"
    morphTablero morph activarModoColocacion: ancho alto: alto


]

{ #category : #operations }
PanelTablero >> actualizar [ 
    "Fuerza actualización visual del tablero"
    morphTablero morph changed


]

{ #category : #operations }
PanelTablero >> callback: unBloque [ 
    "Define el callback que se ejecuta al hacer click"
    morphTablero morph callback: unBloque


]

{ #category : #operations }
PanelTablero >> desactivarModoColocacion [ 
    "Delega al TableroMorph"
    morphTablero morph desactivarModoColocacion


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
PanelTablero >> rotarFigura [ 
    "Delega al TableroMorph"
    morphTablero morph rotarFigura


]

{ #category : #acccessing }
PanelTablero >> tablero [ 
	^tablero.
]

{ #category : #acccessing }
PanelTablero >> tablero: unTablero [
    tablero := unTablero
]
