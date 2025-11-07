Class {
	#name : #DialogoNuevaPartida,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'campoDropDown',
		'campoJugador1',
		'campoJugador2',
		'labelJugador1',
		'labelJugador2',
		'labelDropDown',
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
        newColumn: [ :col |
            col
                newRow: [ :row | row add: #labelDropDown ] height: 40;
                newRow: [ :row | row add: #campoDropDown ] height: 30;
                newRow: [ :row | row add: #labelJugador1 ] height: 40;
                newRow: [ :row | row add: #campoJugador1 ] height: 30;
                newRow: [ :row | row add: #labelJugador2 ] height: 40;
                newRow: [ :row | row add: #campoJugador2 ] height: 30;
                newRow: [ :row |
                    row add: #botonComenzar.
                    row add: #botonCancelar ] height: 30 ];
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
DialogoNuevaPartida >> botonCancelar [
	^botonCancelar.
]

{ #category : #accessing }
DialogoNuevaPartida >> botonComenzar [
	^botonComenzar .
]

{ #category : #accessing }
DialogoNuevaPartida >> campoDropDown [ 
	^campoDropDown.
]

{ #category : #accessing }
DialogoNuevaPartida >> campoJugador1 [
	^campoJugador1.
]

{ #category : #accessing }
DialogoNuevaPartida >> campoJugador2 [
	^campoJugador2.
]

{ #category : #operations }
DialogoNuevaPartida >> iniciarPartida [ 
    | nombreJ1 nombreJ2 tamanio |
    
    "Validaciones"
    nombreJ1 := campoJugador1 text trimBoth.
    nombreJ2 := campoJugador2 text trimBoth.
    
    (nombreJ1 isEmpty or: [ nombreJ2 isEmpty ]) ifTrue: [
        UIManager default inform: 'Debe ingresar nombres para ambos jugadores.'.
        ^ self ].
    
    nombreJ1 = nombreJ2 ifTrue: [
        UIManager default inform: 'Los jugadores deben tener nombres diferentes.'.
        ^ self ].
    
    "Obtener tamaño"
    tamanio := self obtenerTamanoTablero.
    
    "Delegar a la app coordinadora"
    app iniciarPartidaCon: nombreJ1 y: nombreJ2 tablero: tamanio.
    
    "Cerrar este diálogo"
    self window close.

]

{ #category : #accessing }
DialogoNuevaPartida >> initialExtent [
    "Tamaño inicial de la ventana"
    ^ 600@500

]

{ #category : #initialization }
DialogoNuevaPartida >> initializeWidgets [
    "Inicializa todos los widgets del diálogo"

    campoDropDown  := self newDropList.
    campoDropDown 
        items: self opcionesTamano;
        displayBlock: [ :item | item first ];
        setIndex: 1.
	labelDropDown := self newLabel.
	labelDropDown label: 'Ingrese el tamaño del tablero:'.
    
    campoJugador1 := self newTextInput.
    campoJugador1 text: 'Jugador 1'.
	labelJugador1 := self newLabel.
	labelJugador1 label: 'Ingrese nombre del Jugador 1:'.
    
    campoJugador2 := self newTextInput.
    campoJugador2 text: 'Jugador 2'.
	labelJugador2 := self newLabel.
	labelJugador2 label: 'Ingrese nombre del Jugador 2:'.

    
    botonComenzar := self newButton.
    botonComenzar 
        label: 'Comenzar';
        action: [ self iniciarPartida  ].
    
    botonCancelar := self newButton.
    botonCancelar 
        label: 'Cancelar';
        action: [ self delete ].
    
    self focusOrder
        add: campoJugador1;
        add: campoJugador2;
        add: botonComenzar;
        add: botonCancelar
]

{ #category : #accessing }
DialogoNuevaPartida >> labelDropDown [
	^labelDropDown .
]

{ #category : #accessing }
DialogoNuevaPartida >> labelJugador1 [
	^labelJugador1.
]

{ #category : #accessing }
DialogoNuevaPartida >> labelJugador2 [
	^labelJugador2.
]

{ #category : #private }
DialogoNuevaPartida >> obtenerTamanoTablero [
    | seleccion |
    seleccion := campoDropDown  selectedItem.
    
    (seleccion = '12×12 (Rápida)') ifTrue: [ ^ 12 ].
    (seleccion = '18×18 (Media)') ifTrue: [ ^ 18 ].
    (seleccion = '24×12 (Larga)') ifTrue: [ ^ 24 ].
    
    "Por defecto"
    ^ 12

]

{ #category : #accessing }
DialogoNuevaPartida >> opcionesTamano [
    "Retorna las opciones de tamaño de tablero disponibles"
    ^ { 
        { '12×12 (Rápida)'. 12@12 }.
        { '18×18 (Media)'. 18@18 }.
        { '24×24 (Larga)'. 24@24 }
    }

]

{ #category : #accessing }
DialogoNuevaPartida >> title [
    "Título de la ventana"
    ^ 'Nueva Partida'

]
