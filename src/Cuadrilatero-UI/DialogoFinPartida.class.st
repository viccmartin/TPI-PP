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
<spec>
^ SpecLayout composed
    newColumn: [ :col |

        col newRow: [ :row |
            row add: #titulo.
        ] height: 40.

        col newRow: [ :row |
            row add: #labelResultado.
        ] height: 30.

        col newRow: [ :row |
            row add: #botonNuevaPartida.
            row add: #botonSalir.
        ] height: 50.
    ];
    yourself


]

{ #category : #example }
DialogoFinPartida class >> example [
	<sampleInstance>
	^ self new openWithSpec
]

{ #category : #'instance creation' }
DialogoFinPartida class >> on: unResultado app: unaApp [
    | instancia |
    instancia := self basicNew.
    instancia resultado: unResultado app: unaApp.
    instancia initialize.
    ^ instancia
]

{ #category : #accessing }
DialogoFinPartida >> app [
    ^ app

]

{ #category : #accessing }
DialogoFinPartida >> app: unaApp [
    app := unaApp

]

{ #category : #accessing }
DialogoFinPartida >> botonNuevaPartida [
    ^ botonNuevaPartida

]

{ #category : #accessing }
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
DialogoFinPartida >> initializePresenter [
    super initializePresenter.
    
    "Solo las acciones de botones aquí"
    botonNuevaPartida action: [ self nuevaPartida ].
    botonSalir action: [ self delete ].
]

{ #category : #initialization }
DialogoFinPartida >> initializeWidgets [

	 "----- TÍTULO -----"
    titulo := self newLabel.
    titulo label: 'Resultado Final'.
	 titulo emphasis: 1. "negrita"
	 titulo color: Color white.

    "----- TEXTO DEL RESULTADO -----"
    labelResultado := self newLabel.
	 labelResultado label: ''.
	 labelResultado color: Color black.

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

{ #category : #accessing }
DialogoFinPartida >> labelResultado [
    ^ labelResultado

]

{ #category : #actions }
DialogoFinPartida >> nuevaPartida [
    app reiniciarJuego.
    self window close.

]

{ #category : #accessing }
DialogoFinPartida >> openWithSpec [
    | ventana |
    ventana := super openWithSpec.

    titulo widget
        font: (LogicalFont familyName: 'Arial' pointSize: 20);
        listCentering: #center.

    labelResultado widget
        font: (LogicalFont familyName: 'Arial' pointSize: 14);
        listCentering: #center.

    ^ ventana


]

{ #category : #accessing }
DialogoFinPartida >> resultado [
	^resultado
]

{ #category : #accessing }
DialogoFinPartida >> resultado: unResultado [
    resultado := unResultado.
	labelResultado label: (self generarTextoResultado).
]

{ #category : #accessing }
DialogoFinPartida >> resultado: unResultado app: unaApp [
    app := unaApp.
    resultado := unResultado.

]

{ #category : #actions }
DialogoFinPartida >> salir [
    self window close.
]

{ #category : #accessing }
DialogoFinPartida >> titulo [
    ^ 'Fin de la Partida'

]
