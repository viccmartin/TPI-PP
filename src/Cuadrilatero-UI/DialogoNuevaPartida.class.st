Class {
	#name : #DialogoNuevaPartida,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'dropTamano',
		'campoJugador1',
		'campoJugador2',
		'botonComenzar',
		'botonCancelar'
	],
	#classInstVars : [
		'labelTamano',
		'comboTamano',
		'labelJugador1',
		'campoJugador1',
		'labelJugador2',
		'campoJugador2',
		'botonComenzar',
		'botonCancelar'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
DialogoNuevaPartida class >> defaultSpec [
<spec>
	^ SpecLayout composed
		newRow: [:row | row
						add: #dropTamano];
		yourself

]

{ #category : #example }
DialogoNuevaPartida class >> example [
	<sampleInstance>
	^ self new openWithSpec
]

{ #category : #'instance creation' }
DialogoNuevaPartida class >> on: unaApp [
    | instancia |
    instancia := self basicNew.
    instancia app: unaApp.
    instancia initialize.
    ^ instancia

]

{ #category : #accessing }
DialogoNuevaPartida >> app [
    ^ app

]

{ #category : #accessing }
DialogoNuevaPartida >> app: unaApp [
    app := unaApp

]

{ #category : #accessing }
DialogoNuevaPartida >> dropTamano [
	^dropTamano 
]

{ #category : #operations }
DialogoNuevaPartida >> iniciarPartida [
    | nombreJ1 nombreJ2 tamano |
    
    "Validaciones"
    nombreJ1 := campoJugador1 text trimBoth.
    nombreJ2 := campoJugador2 text trimBoth.
    
    (nombreJ1 isEmpty or: [ nombreJ2 isEmpty ]) ifTrue: [
        UIManager default inform: 'Debe ingresar nombres para ambos jugadores.'.
        ^ self ].
    
    "Obtener tamaño"
    tamano := self obtenerTamanoTablero.
    
    "Delegar a la app coordinadora"
    app iniciarPartidaCon: nombreJ1 y: nombreJ2 tablero: tamano.
    
    "Cerrar este diálogo"
    self window close.
]

{ #category : #initialization }
DialogoNuevaPartida >> initializeWidgets [
	"Creación de los widgets"
    dropTamano := self newDropList.
    dropTamano items: #('12×12 (Rápida)' '18×18 (Media)' '24×12 (Larga)');
        setIndex: 1.

	"labelJugador1 := self newLabel."
    campoJugador1 := self newTextInput.
    campoJugador2 := self newTextInput.

    botonComenzar := self newButton .
    botonComenzar
        label: 'Comenzar';
        action: [ self iniciarPartida ].

    botonCancelar := self newButton .
    botonCancelar
        label: 'Cancelar';
        action: [ self window close ].
]

{ #category : #private }
DialogoNuevaPartida >> obtenerTamanoTablero [
	| seleccion numero |
	seleccion := dropTamano selectedItem.
	numero := (seleccion copyUpTo: $x) asNumber.
	^ numero

]
