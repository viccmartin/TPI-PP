Class {
	#name : #DialogoNuevaPartida,
	#superclass : #ComposableModel,
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

{ #category : #private }
DialogoNuevaPartida >> obtenerTamanoTablero [
	| seleccion numero |
	seleccion := dropTamano selectedItem.
	numero := (seleccion copyUpTo: $x) asNumber.
	^ numero

]
