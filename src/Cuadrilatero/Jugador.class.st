"
Jugador: La clase Jugador representa un participante del juego.
"
Class {
	#name : #Jugador,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'superficieTotal'
	],
	#category : #Cuadrilatero
}

{ #category : #accessing }
Jugador >> nombre [
	^nombre "getter: devuelve el nombre del jugador"
]

{ #category : #accessing }
Jugador >> nombre: unNombre [
    nombre := unNombre   "setter: le asigna un nombre al jugador"

]
