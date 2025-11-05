Class {
	#name : #VentanaJuego,
	#superclass : #ComposableModel,
	#instVars : [
		'app',
		'partida',
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

{ #category : #acccessing }
VentanaJuego >> partida: unaPartida app: unaApp [
    app := unaApp.
    partida := unaPartida.
    dimensionesActuales := nil.
    figuraRotada := false.

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
