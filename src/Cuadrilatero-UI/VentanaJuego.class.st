Class {
	#name : #VentanaJuego,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'partida',
		'panelTablero',
		'labelTurno',
		'botonTirarDados',
		'botonFinalizar',
		'panelPuntuacion',
		'morphTablero',
		'dimensionesActuales',
		'figuraRotada'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
VentanaJuego class >> defaultSpec [
	<spec>
    ^ SpecLayout composed
        newColumn: [ :col |
            col
                newRow: [ :row |
                    row add: #panelTablero. ] ];
        yourself
]

{ #category : #'instance creation' }
VentanaJuego class >> on: unaPartida app: unaApp [
    | instancia |
    instancia := self basicNew.
    instancia partida: unaPartida app: unaApp.
    instancia initialize.
    ^ instancia
]

{ #category : #acccessing }
VentanaJuego >> app [
    ^ app

]

{ #category : #acccessing }
VentanaJuego >> app: unaApp [
    app := unaApp

]

{ #category : #operations }
VentanaJuego >> finalizarPartida [
    | resultado |
    resultado := partida finalizarManualmente.
    app finalizarPartidaCon: resultado.
    self window close.

]

{ #category : #api }
VentanaJuego >> initialExtent [ 
	^1000@700.
]

{ #category : #initialization }
VentanaJuego >> initializeWidgets [ 
    panelTablero := PanelTablero on: partida tablero.
    

]

{ #category : #acccessing }
VentanaJuego >> panelTablero [
 ^panelTablero.
]

{ #category : #acccessing }
VentanaJuego >> partida: unaPartida app: unaApp [
    app := unaApp.
    partida := unaPartida.
    dimensionesActuales := nil.
    figuraRotada := false.

]

{ #category : #api }
VentanaJuego >> title [ 
^'Cuadrilatero - Partida en juego'
]

{ #category : #operations }
VentanaJuego >> verificarFinDeJuego [
	| resultado |
	partida finalizada
		ifFalse: [ ^ self ].
	resultado := partida determinarGanador.
	app finalizarPartidaCon: resultado.
	self window close
]
