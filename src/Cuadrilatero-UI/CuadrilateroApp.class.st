Class {
	#name : #CuadrilateroApp,
	#superclass : #Object,
	#instVars : [
		'partidaActual'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #launching }
CuadrilateroApp class >> abrir [
	"metodo para iniciar la aplicacion"
	^self new iniciar						
]

{ #category : #operations }
CuadrilateroApp >> finalizarPartidaCon: resultado [
	"llamado por VentanaJuego cuando termina"
	|dialogo|
	dialogo:= DialogoFinPartida on: resultado app: self.
	dialogo openDialogWithSpec.	

]

{ #category : #actions }
CuadrilateroApp >> generarObstaculosEn: unTablero [ 
    | cantidad posiciones |

    "Cantidad de obstáculos = 10% del tablero"
    cantidad := (unTablero filas * unTablero columnas * 0.10) rounded.

    posiciones := Set new.

    "Generar posiciones aleatorias únicas (coordenadas desde 0)"
    [ posiciones size < cantidad ] whileTrue: [
        posiciones add: (
            (0 to: unTablero columnas - 1) atRandom @
            (0 to: unTablero filas - 1) atRandom
        )
    ].

    "Colocar obstáculos"
    posiciones do: [ :pos |
        unTablero colocarObstaculoEn: pos ].


]

{ #category : #operations }
CuadrilateroApp >> iniciar [
	"punto de entrada de la aplicacion"
	self mostrarDialogoNuevaPartida.

]

{ #category : #operations }
CuadrilateroApp >> iniciarPartidaCon: nombre1 y: nombre2 tablero: tamano obstaculos: conObstaculos [ 
    "Llamado por DialogoNuevaPartida cuando se confirma"
    | j1 j2 tablero |
    j1 := Jugador new nombre: nombre1.
    j2 := Jugador new nombre: nombre2.

    tablero := Tablero new.
    tablero filas: tamano columnas: tamano.
    
    "Generar obstáculos si el checkbox está activado"
    conObstaculos ifTrue: [
        self generarObstaculosEn: tablero ].

    partidaActual := Partida new.
    partidaActual jugador1: j1 jugador2: j2 tablero: tablero.

    self mostrarVentanaJuego.


]

{ #category : #initialization }
CuadrilateroApp >> initialize [
	super initialize.
	partidaActual:= nil.

]

{ #category : #operations }
CuadrilateroApp >> mostrarDialogoNuevaPartida [
	|dialogo|
	dialogo:= DialogoNuevaPartida on: self.
	dialogo openDialogWithSpec.

]

{ #category : #operations }
CuadrilateroApp >> mostrarVentanaJuego [
	|ventana|
	ventana:= VentanaJuego on: partidaActual app: self.
	ventana openWithSpec.

]

{ #category : #accessing }
CuadrilateroApp >> partidaActual [
	^partidaActual

]

{ #category : #accessing }
CuadrilateroApp >> partidaActual: unaPartida [
	partidaActual:= unaPartida

]

{ #category : #operations }
CuadrilateroApp >> reiniciarJuego [
	"Inicia una nueva partida desde cero"
	partidaActual := nil.
	self mostrarDialogoNuevaPartida.

]
