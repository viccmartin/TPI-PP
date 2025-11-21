Class {
	#name : #VentanaJuego,
	#superclass : #ComposablePresenter,
	#instVars : [
		'app',
		'tablero',
		'partida',
		'labelTurno',
		'labelDimensiones',
		'botonTirarDados',
		'botonRotar',
		'botonFinalizar',
		'dimensionesActuales',
		'tableroMorph',
		'panelTablero',
		'panelPuntuacion'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
VentanaJuego class >> defaultSpec [
   ^ SpecLayout composed
        newColumn: [ :col |
            "Fila superior: labels de turno y dimensiones"
            col newRow: [ :row |
                row add: #labelTurno.
                row add: #labelDimensiones ] height: 30.
            
            "Fila de botones: tirar dados y rotar"
            col newRow: [ :row |
                row add: #botonTirarDados.
                row add: #botonRotar ] height: 40.
            
            "Fila principal: tablero y panel lateral"
            col newRow: [ :mainRow |
                "Columna izquierda: tablero"
                mainRow add: #panelTablero.
                
                "Columna derecha: puntuación y botón finalizar"
                mainRow newColumn: [ :rightCol |
                    rightCol add: #panelPuntuacion.
                    rightCol newRow: [ :btnRow |
                        btnRow add: #botonFinalizar
                    ] height: 50
                ] width: 300
            ]
        ];
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
    labelDimensiones label: 'Presiona "Tirar Dados" para continuar'.
	 panelPuntuacion actualizar.

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
VentanaJuego >> botonFinalizar [
^botonFinalizar 
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

{ #category : #operations }
VentanaJuego >> finalizarPartida [ 
    | resultado confirmacion |
    
    confirmacion := UIManager default 
        confirm: '¿Estás seguro de que quieres finalizar la partida?'.
    
    confirmacion ifFalse: [ ^ self ].
    
    resultado := partida finalizarManualmente.
    app finalizarPartidaCon: resultado.
    self window close.
]

{ #category : #api }
VentanaJuego >> initialExtent [ 
	^1000@700.
]

{ #category : #initialization }
VentanaJuego >> initializeWidgets [
    
    labelTurno := self newLabel.
    labelTurno label: 'Turno: ', partida turnoActual nombre.
    
    labelDimensiones := self newLabel.
    labelDimensiones label: 'Presiona "Tirar Dados" para comenzar'.
    
    botonTirarDados := self newButton.
    botonTirarDados 
        label: 'Tirar Dados';
        action: [ self tirarDados ].
    
    botonRotar := self newButton.
    botonRotar 
        label: 'Rotar';
        enabled: false;
        action: [ self rotarFigura ].
    
    botonFinalizar := self newButton.
    botonFinalizar 
        label: 'Finalizar Partida';
        action: [ self finalizarPartida ].
    
    panelTablero := PanelTablero on: partida tablero.
    panelTablero whenClickDo: [ :punto | self intentarColocarFiguraEn: punto ].

	panelPuntuacion := PanelPuntuacion on: partida.



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
        panelTablero desactivarModoColocacion.
        panelTablero redibujar.
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
VentanaJuego >> panelPuntuacion [
^panelPuntuacion.
]

{ #category : #acccessing }
VentanaJuego >> panelTablero [
^panelTablero.
]

{ #category : #accessing }
VentanaJuego >> partida [
	^partida
]

{ #category : #accessing }
VentanaJuego >> partida: unaPartida [
	partida:= unaPartida 
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
    
    temp := dimensionesActuales x.
    dimensionesActuales := dimensionesActuales y @ temp.
    
    labelDimensiones label: dimensionesActuales x asString, ' × ', dimensionesActuales y asString.
    
    panelTablero rotarFigura.

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
    
    labelDimensiones label: dimensionesActuales x asString, ' × ', dimensionesActuales y asString.
    
    "Verificar si puede colocar"
    (partida verificarJugadorPuedeColocar: dimensionesActuales x alto: dimensionesActuales y)
        ifFalse: [
            UIManager default inform: 'No hay espacio. Turno perdido.'.
            dimensionesActuales := nil.
				panelPuntuacion actualizar.
            self actualizarTurno.
            self verificarFinDeJuego.
            ^ self ].
    
    "Activar modo colocación"
    panelTablero activarModoColocacion: dimensionesActuales.
    botonTirarDados enabled: false.
    botonRotar enabled: true.
]

{ #category : #api }
VentanaJuego >> title [ 
^'Cuadrilatero - Partida en juego'
]

{ #category : #operations }
VentanaJuego >> verificarFinDeJuego [
    self partida finalizada ifTrue: [
        | resultado dialogo |
        resultado := self partida determinarGanador.
        
        "DEPURACIÓN - Ver qué contiene resultado"
        Transcript show: 'Resultado: '; show: resultado; cr.
        resultado inspect.  "← Esto abrirá un inspector"
        
        dialogo := DialogoFinPartida new.
        dialogo resultado: resultado.
        dialogo openWithSpec.
    ] ifFalse: [ nil ]
]
