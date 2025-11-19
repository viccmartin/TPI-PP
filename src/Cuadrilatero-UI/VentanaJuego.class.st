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

{ #category : #operations }
VentanaJuego >> tirarDados [ 
]

{ #category : #api }
VentanaJuego >> title [ 
^'Cuadrilatero - Partida en juego'
]
