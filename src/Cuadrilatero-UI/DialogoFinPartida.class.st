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
            
            "Espacio superior"
            col newRow: [ :r | ] height: 10.
            
            "Título"
            col newRow: [ :row |
                row add: #titulo.
            ] height: 30.
            
            "Espacio entre título y resultado"
            col newRow: [ :r | ] height: 10.
            
            "Resultado"
            col newRow: [ :row |
                row add: #labelResultado.
            ] height: 30.
            
            "Espacio antes de los botones"
            col newRow: [ :r | ] height: 30.
            
            "Botones"
            col newRow: [ :row |
                row add: #botonNuevaPartida.
                row add: #botonSalir.
            ] height: 40.
            
            "Espacio inferior"
            col newRow: [ :r | ] height: 10.
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
    | texto jugador |

    Transcript show: 'generarTextoResultado llamado'; cr.
    Transcript show: 'resultado es: '; show: resultado; cr.

    resultado ifNil: [ ^ 'Resultado no disponible' ].

    resultado class = Dictionary ifFalse: [
   		Transcript show: 'Resultado no es Dictionary'; cr.
   ^ 'Resultado inválido'
].


    (resultado includesKey: #interrumpida) ifTrue: [
        Transcript show: 'Fue interrumpida'; cr.
        ^ 'La partida fue interrumpida.'
    ].

    (resultado includesKey: #empate) ifTrue: [
        Transcript show: 'Es empate'; cr.
        ^ 'La partida terminó en empate.'
    ].

    (resultado includesKey: #ganador) ifTrue: [
        Transcript show: 'Tiene ganador'; cr.
        jugador := resultado at: #ganador ifAbsent: [ ^ 'Resultado inválido' ].

        texto := 'El ganador es ', jugador nombre,
                 ' con ', jugador superficieTotal asString,
                 ' unidades de superficie y ',
                 jugador cantidadFiguras asString, ' figuras.'.
        ^ texto
    ].

    Transcript show: 'Resultado desconocido'; cr.
    ^ 'Resultado desconocido.'

]

{ #category : #initialization }
DialogoFinPartida >> initializePresenter [
    super initializePresenter.
    
    "Solo las acciones de botones aquí"
	 labelResultado label: self generarTextoResultado.
    botonNuevaPartida action: [ self nuevaPartida ].
    botonSalir action: [ self delete ].
]

{ #category : #initialization }
DialogoFinPartida >> initializeWidgets [

	 "----- TÍTULO -----"
    titulo := self newLabel.
    titulo label: 'Resultados finales'.
	 titulo color: Color black.

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

    labelResultado label: resultado.  "<<< ESTA ES LA LÍNEA IMPORTANTE"

    ventana := super openWithSpec.

    ventana extent: 500@300.
    ventana center: World center.

    titulo widget
        font: (LogicalFont familyName: 'Arial' pointSize: 22);
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

{ #category : #api }
DialogoFinPartida >> title [
    "Título de la ventana"
    ^ 'Fin de Partida'
]

{ #category : #accessing }
DialogoFinPartida >> titulo [
    ^ titulo

]
