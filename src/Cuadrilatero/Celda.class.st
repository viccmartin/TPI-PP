Class {
	#name : #Celda,
	#superclass : #Object,
	#instVars : [
		'esObstaculo',
		'ocupadaCon'
	],
	#category : #Cuadrilatero
}

{ #category : #accessing }
Celda >> esObstaculo [
    ^ esObstaculo
]

{ #category : #initialization }
Celda >> initialize [
    super initialize.
    esObstaculo := false.
    ocupadaCon := nil.
]

{ #category : #actions }
Celda >> ponerObstaculo [
    esObstaculo := true.
    ocupadaCon := nil.
]
