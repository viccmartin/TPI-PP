Class {
	#name : #VentanaJuego,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'partida',
		'labelTurno',
		'labelDimensiones',
		'botonTirarDados',
		'botonRotar',
		'dimensionesActuales',
		'tableroMorph'
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
                    row add: #botonRotar ] height: 40 ];
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

{ #category : #specs }
VentanaJuego >> defaultSpec [
    <spec: #default>
    ^ SpecLayout composed
        newRow: [ :row |
            row
                add: #labelTurno;
                add: #botonTirarDados;
                add: #botonRotar;
                add: #botonFinalizar ]
        height: self toolbarHeight;
        newRow: [ :row |
            row add: #labelResultado ]
        height: 25;
        newRow: [ :mainRow |
            mainRow
                add: #tableroMorph;
                add: #panelPuntuacion width: 200 ];
        yourself
]

{ #category : #acccessing }
VentanaJuego >> dimensionesActuales [
	^dimensionesActuales.
]

{ #category : #api }
VentanaJuego >> initialExtent [ 
	^800@500.
]

{ #category : #initialization }
VentanaJuego >> initializeWidgets [ 
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
	
	tableroMorph := TableroMorph on: partida tablero.
	tableroMorph whenClickDo: [:punto| self intentarColocarFiguraEn: punto ]

    

]

{ #category : #operations }
VentanaJuego >> intentarColocarFiguraEn: punto [
 | exito |
    dimensionesActuales ifNil: [
        UIManager default inform: 'Debe tirar los dados primero.'.
        ^ self ].
    exito := partida colocarFigura: dimensionesActuales x 
        alto: dimensionesActuales y 
        en: punto.
    
    exito ifTrue: [
        tableroMorph desactivarModoColocacion.
        tableroMorph redibujar.
        dimensionesActuales := nil.
        botonTirarDados enabled: true.
        botonRotar enabled: false.
        self actualizarTurno.
        self verificarFinDeJuego ]
    ifFalse: [
        UIManager default inform: 'No se puede colocar la figura aquí.' ].
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
VentanaJuego >> partida: unaPartida app: unaApp [
    app := unaApp.
    partida := unaPartida.
dimensionesActuales := nil.

]

{ #category : #acccessing }
VentanaJuego >> tableroMorph [
    "Este método es CRUCIAL para que Spec pueda acceder al morph"
    ^ tableroMorph
]

{ #category : #operations }
VentanaJuego >> tirarDados [
    | resultado |
    dimensionesActuales ifNotNil: [
        UIManager default inform: 'Ya hay dados tirados. Coloque la figura primero.'.
        ^ self ].
    
    resultado := partida tirarDados.
    dimensionesActuales := (resultado at: #ancho) @ (resultado at: #alto).
    
    "Verificar si puede colocar"
    (partida verificarJugadorPuedeColocar: dimensionesActuales x alto: dimensionesActuales y)
        ifFalse: [
            UIManager default inform: 'No hay espacio. Turno perdido.'.
            dimensionesActuales := nil.
            self actualizarTurno.
            self verificarFinDeJuego.
            ^ self ].
    
    "Activar modo colocación"
    tableroMorph activarModoColocacion: dimensionesActuales.
    botonTirarDados enabled: false.
    botonRotar enabled: true.

]

{ #category : #api }
VentanaJuego >> title [ 
^'Cuadrilatero - Partida en juego'
]
