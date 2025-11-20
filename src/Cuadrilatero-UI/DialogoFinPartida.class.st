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
	<spec: #defaultSpec>
	
	^ SpecLayout composed
		newColumn: [ :col | 
			
			"1. Título"
			col newRow: [ :row | 
				row add: #titulo left: 0.25 right: 0.25.  "Deja 25% a cada lado"
			] height: 30.

			"2. SEPARADOR (Fila vacía de 10px)"
			col newRow: [ :r | ] height: 10.   "<-- CORRECCIÓN AQUÍ"

			"3. Texto del Resultado"
			col newRow: [ :row | 
				row add: #labelResultado left: 0.2 right: 0.2.
			]. 

			"4. SEPARADOR (Fila vacía de 10px)"
			col newRow: [ :r | ] height: 10.   "<-- CORRECCIÓN AQUÍ"

			"5. Botones"
			col newRow: [ :row | 
				row add: #botonNuevaPartida.
				row add: #botonSalir. 
			] height: 50.
		];
		yourself

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
    
    self whenWindowChanged: [ :w |
        w ifNotNil: [
            "Fuente normal"
            titulo widget font: (LogicalFont familyName: 'Arial' pointSize: 18).
            
            "Fuente en negrita"
            labelResultado widget font: (
                (LogicalFont familyName: 'Arial' pointSize: 14) 
                emphasis: 1  "1 = bold"
            ).
        ]
    ].
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
