Class {
	#name : #DialogoFinPartida,
	#superclass : #ComposableModel,
	#instVars : [
		'app',
		'resultado',
		'labelResultado',
		'botonNuevaPartida',
		'botonSalir'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #'instance creation' }
DialogoFinPartida class >> on: unResultado app: unaApp [
    | instancia |
    instancia := self basicNew.
    instancia resultado: unResultado app: unaApp.
    instancia initialize.
    ^ instancia
]

{ #category : #acccessing }
DialogoFinPartida >> app [
    ^ app

]

{ #category : #acccessing }
DialogoFinPartida >> app: unaApp [
    app := unaApp

]

{ #category : #actions }
DialogoFinPartida >> nuevaPartida [
    app reiniciarJuego.
    self window close.

]

{ #category : #acccessing }
DialogoFinPartida >> resultado: unResultado app: unaApp [
    app := unaApp.
    resultado := unResultado.

]

{ #category : #actions }
DialogoFinPartida >> salir [
    self window close.
]
