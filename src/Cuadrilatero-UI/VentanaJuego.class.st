Class {
	#name : #VentanaJuego,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'partida',
		'panelTablero',
		'labelTurno',
		'labelDimensiones',
		'botonTirarDados',
		'botonRotar',
		'dimensionesActuales'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
VentanaJuego class >> defaultSpec [
    ^ SpecLayout composed
        newColumn: [ :col |
            col
                newRow: [ :row |
                    row add: #labelTurno.
                    row add: #labelDimensiones ] height: 30;
                newRow: [ :row |
                    row add: #botonTirarDados.
                    row add: #botonRotar ] height: 40;
                newRow: [ :row | row add: #panelTablero ] ];
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

{ #category : #operations }
VentanaJuego >> actualizarTurno [ 
    labelTurno label: 'Turno: ', partida turnoActual nombre.
    labelDimensiones label: 'Tira los dados para obtener dimensiones'.

]

{ #category : #acccessing }
VentanaJuego >> app [
    ^ app

]

{ #category : #acccessing }
VentanaJuego >> app: unaApp [
    app := unaApp

]

{ #category : #acccessing }
VentanaJuego >> botonRotar [
^botonRotar 
]

{ #category : #acccessing }
VentanaJuego >> botonTirarDados [
^botonTirarDados 
]

{ #category : #operations }
VentanaJuego >> colocarFiguraEn: posicion [ 
    | ancho alto exito |
    dimensionesActuales ifNil: [ ^ self ].
    
    ancho := dimensionesActuales at: #ancho.
    alto := dimensionesActuales at: #alto.
    
    exito := partida colocarFigura: ancho alto: alto en: posicion.
    
    exito ifTrue: [
        panelTablero desactivarModoColocacion.
        panelTablero actualizar.
        self actualizarTurno.
        botonTirarDados enabled: true.
        botonRotar enabled: false.
        dimensionesActuales := nil.
        
        self verificarFinDeJuego.
    ] ifFalse: [
        UIManager default inform: 'No se puede colocar la figura ahí.'.
    ].

]

{ #category : #acccessing }
VentanaJuego >> dimensionesActuales [
	^dimensionesActuales.
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
	^800@500.
]

{ #category : #initialization }
VentanaJuego >> initializeWidgets [ 
    panelTablero := PanelTablero on: partida tablero.

	labelTurno := self newLabel.
    labelTurno label: 'Turno: ', partida turnoActual nombre.
    
    labelDimensiones := self newLabel.
    labelDimensiones label: 'Tira los dados para obtener dimensiones'.
    
    botonTirarDados := self newButton.
    botonTirarDados 
        label: 'Tirar Dados';
        action: [ self tirarDados ].
    
    botonRotar := self newButton.
    botonRotar 
        label: 'Rotar';
        enabled: false;
        action: [ self rotarFigura ].

    

]

{ #category : #acccessing }
VentanaJuego >> labelDimensiones [
^labelDimensiones.
]

{ #category : #acccessing }
VentanaJuego >> labelTurno [
^labelTurno
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

]

{ #category : #operations }
VentanaJuego >> rotarFigura [ 
	 | temp |
    dimensionesActuales ifNil: [ ^ self ].
    
    "Intercambiar ancho y alto"
    temp := dimensionesActuales at: #ancho.
    dimensionesActuales at: #ancho put: (dimensionesActuales at: #alto).
    dimensionesActuales at: #alto put: temp.
    
    "Actualizar label"
    labelDimensiones label: (dimensionesActuales at: #ancho) asString, ' × ', (dimensionesActuales at: #alto) asString.
    
    "Rotar en el tablero"
    panelTablero rotarFigura.
]

{ #category : #operations }
VentanaJuego >> tirarDados [ 
	| ancho alto |
    dimensionesActuales := partida tirarDados.
    ancho := dimensionesActuales at: #ancho.
    alto := dimensionesActuales at: #alto.
    
    labelDimensiones label: ancho asString, ' × ', alto asString.
    
    "Verificar si el jugador puede colocar la figura"
    (partida verificarJugadorPuedeColocar: ancho alto: alto) ifFalse: [
        UIManager default inform: partida turnoActual nombre, ' no puede colocar esta figura. Turno perdido.'.
        self actualizarTurno.
        dimensionesActuales := nil.
        ^ self
    ].
    
    "Activar modo colocación en el tablero"
    panelTablero activarModoColocacion: ancho alto: alto.
    panelTablero callback: [ :posicion | self colocarFiguraEn: posicion ].
    
    botonTirarDados enabled: false.
    botonRotar enabled: true.

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
