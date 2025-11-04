Class {
	#name : #Dado,
	#superclass : #Object,
	#instVars : [
		'valorActual'
	],
	#category : #Cuadrilatero
}

{ #category : #operations }
Dado >> lanzar [
	valorActual:=(1 to: 6)atRandom.
	^valorActual

]

{ #category : #acccessing }
Dado >> valor [
		^valorActual	"getter"
]
