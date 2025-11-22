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

{ #category : #testing }
Celda >> estaLibre [ 
    ^ esObstaculo not
]

{ #category : #initialization }
Celda >> initialize [
    super initialize.
    esObstaculo := false.
    ocupadaCon := nil.
]

{ #category : #actions }
Celda >> marcarComoObstaculo [ 
    esObstaculo := true.
    ocupadaCon := nil.

]
