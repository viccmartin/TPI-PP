Class {
	#name : #DialogoFinPartida,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'resultado',
		'labelResultado',
		'botonNuevaPartida',
		'botonSalir',
		'titulo'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
DialogoFinPartida class >> defaultSpec [
	^ SpecLayout composed
		newColumn: {

			"----- TÍTULO -----"
			(SpecLayout newRow: [ :row |
				row add: #titulo.
			]).

			"----- SEPARADOR -----"
			(SpecLayout newRow: [ :row | ]) height: 10.

			"----- TEXTO DEL RESULTADO -----"
			(SpecLayout newRow: [ :row |
				row add: #labelResultado.
			]).

			"----- SEPARADOR -----"
			(SpecLayout newRow: [ :row | ]) height: 10.

			"----- BOTONES -----"
			(SpecLayout newRow: [ :row |
				row add: #botonNuevaPartida.
				row add: #botonSalir.
			]) height: 50.

		};
		size: 420@250;
		yourself.

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

{ #category : #acccessing }
DialogoFinPartida >> botonNuevaPartida [
    ^ botonNuevaPartida

]

{ #category : #acccessing }
DialogoFinPartida >> botonSalir [
    ^ botonSalir


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

	 "----- TÍTULO -----"
    titulo := self newLabel.
    titulo label: 'Fin de la Partida'.
    titulo hAlign: #center.
    titulo vAlign: #center.
    titulo font: (LogicalFont familyName: 'Arial' pointSize: 20).

    "----- TEXTO DEL RESULTADO -----"
    labelResultado := self newLabel.
    labelResultado label: (self generarTextoResultado).
    labelResultado hAlign: #center.
    labelResultado vAlign: #center.
    labelResultado autoFit: true.
    labelResultado font: (LogicalFont familyName: 'Arial' pointSize: 14).

    "----- BOTÓN NUEVA PARTIDA -----"
    botonNuevaPartida := self newButton.
    botonNuevaPartida label: 'Iniciar nueva partida'.
    botonNuevaPartida action: [ self nuevaPartida ].
    botonNuevaPartida extent: 180@35.

    "----- BOTÓN SALIR -----"
    botonSalir := self newButton.
    botonSalir label: 'Terminar juego'.
    botonSalir action: [ self salir ].
    botonSalir extent: 150@35.



]

{ #category : #public }
DialogoFinPartida >> ir [
	self openWithSpec.
]

{ #category : #acccessing }
DialogoFinPartida >> labelResultado [
    ^ labelResultado

]

{ #category : #actions }
DialogoFinPartida >> nuevaPartida [
    app reiniciarJuego.
    self window close.

]

{ #category : #acccessing }
DialogoFinPartida >> resultado [
	^resultado
]

{ #category : #accessing }
DialogoFinPartida >> resultado: unResultado [
    resultado := unResultado.

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

{ #category : #acccessing }
DialogoFinPartida >> titulo [
    ^ titulo

]
