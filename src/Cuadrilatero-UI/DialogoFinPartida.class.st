Class {
	#name : #DialogoFinPartida,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'resultado',
		'labelResultado',
		'botonNuevaPartida',
		'botonSalir'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
DialogoFinPartida class >> defaultSpec [
    "Define la disposición de los widgets en el diálogo de fin de partida"
    ^ SpecLayout composed
        newColumn: [ :col | 
            col
                newRow: [ :row | 
                    row add: #labelResultado ].
            col
                newRow: [ :row |
                    row add: #botonNuevaPartida.
                    row add: #botonSalir ] ]

]

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

{ #category : #private }
DialogoFinPartida >> generarTextoResultado [
    "Devuelve el texto a mostrar en el label según el resultado"
    | texto |
    (resultado includesKey: #ganador) ifTrue: [
        texto := 'El ganador es ', (resultado at: #ganador) nombre, 
                 ' con ', ((resultado at: #ganador) superficieTotal) asString, ' unidades de superficie y ',
                 ((resultado at: #ganador) cantidadFiguras) asString, ' figuras.'.
        ^ texto
    ].

    (resultado includesKey: #empate) ifTrue: [ 
        ^ 'La partida terminó en empate.' 
    ].

    (resultado includesKey: #interrumpida) ifTrue: [
        ^ 'La partida fue interrumpida.'
    ].

    ^ 'Resultado desconocido.'

]

{ #category : #initialization }
DialogoFinPartida >> initializeWidgets [
    super initializeWidgets.

    labelResultado := self newLabel.
    labelResultado label: (self generarTextoResultado).

    botonNuevaPartida := self newButton.
    botonNuevaPartida label: 'Iniciar nueva partida'.
    botonNuevaPartida action: [ self nuevaPartida ].

    botonSalir := self newButton.
    botonSalir label: 'Terminar juego'.
    botonSalir action: [ self salir ].

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
