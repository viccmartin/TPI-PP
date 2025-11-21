Class {
	#name : #PanelPuntuacion,
	#superclass : #ComposablePresenter,
	#instVars : [
		'partida',
		'labelPuntuacion',
		'labelTituloJ1',
		'labelNombreJ1',
		'labelSuperficieJ1',
		'labelFigurasJ1',
		'labelTituloJ2',
		'labelNombreJ2',
		'labelSuperficieJ2',
		'labelFigurasJ2',
		'separador',
		'jugador1Panel',
		'jugador2Panel'
	],
	#category : #'Cuadrilatero-UI'
}

{ #category : #specs }
PanelPuntuacion class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :col |
			col newRow: [ :row | row add: #labelPuntuacion ] height: 40.
			"Título Jugador 1"
			col newRow: [ :row | row add: #labelTituloJ1 ] height: 30.
			col newRow: [ :row | row add: #labelNombreJ1 ] height: 25.
			col newRow: [ :row | row add: #labelSuperficieJ1 ] height: 25.
			col newRow: [ :row | row add: #labelFigurasJ1 ] height: 25.
			
			"Separador"
			col newRow: [ :r | ] height: 20.
			
			"Título Jugador 2"
			col newRow: [ :row | row add: #labelTituloJ2 ] height: 30.
			col newRow: [ :row | row add: #labelNombreJ2 ] height: 25.
			col newRow: [ :row | row add: #labelSuperficieJ2 ] height: 25.
			col newRow: [ :row | row add: #labelFigurasJ2 ] height: 25.
			
			col newRow: [ :r | ] height: 20.
		];
		yourself
]

{ #category : #'instance creation' }
PanelPuntuacion class >> on: unaPartida [
	^ self basicNew
		partida: unaPartida;
		initialize;
		yourself
]

{ #category : #operations }
PanelPuntuacion >> actualizar [
	| j1 j2 |
	j1 := partida jugador1.
	j2 := partida jugador2.
	
	labelNombreJ1 label: j1 nombre.
	labelSuperficieJ1 label: 'Superficie: ', j1 superficieTotal asString.
	labelFigurasJ1 label: 'Figuras: ', j1 cantidadFiguras asString.
	
	labelNombreJ2 label: j2 nombre.
	labelSuperficieJ2 label: 'Superficie: ', j2 superficieTotal asString.
	labelFigurasJ2 label: 'Figuras: ', j2 cantidadFiguras asString.
]

{ #category : #specs }
PanelPuntuacion >> defaultSpec [
    <spec>
    ^ SpecColumnLayout new
        spacing: 20;
        add: (self newLabel
                label: 'PUNTUACIÓN';
                hAlign: #center;
                font: (LogicalFont familyName: 'Arial' pointSize: 16));
        add: (SpecColumnLayout new
                spacing: 25;

                "Bloque Jugador 1"
                add: (SpecColumnLayout new
                        spacing: 8;
                        add: (labelTituloJ1 hAlign: #center);
                        add: labelNombreJ1;
                        add: labelSuperficieJ1;
                        add: labelFigurasJ1;
                        yourself);

                "Separador"
                add: (self newLabel
                        label: '-----------------------------';
                        hAlign: #center);

                "Bloque Jugador 2"
                add: (SpecColumnLayout new
                        spacing: 8;
                        add: (labelTituloJ2 hAlign: #center);
                        add: labelNombreJ2;
                        add: labelSuperficieJ2;
                        add: labelFigurasJ2;
                        yourself);

                yourself);
        yourself.

]

{ #category : #initialization }
PanelPuntuacion >> initializeWidgets [
	"Inicializa todos los labels del panel"
	
	labelPuntuacion := self newLabel.
	labelPuntuacion label: 'PUNTUACION'.
	
	"Jugador 1"
	labelTituloJ1 := self newLabel.
	labelTituloJ1 label: 'JUGADOR 1'.
	
	labelNombreJ1 := self newLabel.
	labelNombreJ1 label: 'Jugador 1'.
	
	labelSuperficieJ1 := self newLabel.
	labelSuperficieJ1 label: 'Superficie: 0 u²'.
	
	labelFigurasJ1 := self newLabel.
	labelFigurasJ1 label: 'Figuras: 0'.
	

	"Jugador 2"
	labelTituloJ2 := self newLabel.
	labelTituloJ2 label: 'JUGADOR 2'.
	
	labelNombreJ2 := self newLabel.
	labelNombreJ2 label: 'Jugador 2'.
	
	labelSuperficieJ2 := self newLabel.
	labelSuperficieJ2 label: 'Superficie: 0'.
	
	labelFigurasJ2 := self newLabel.
	labelFigurasJ2 label: 'Figuras: 0'.
	

	
	"Actualizar con datos reales"
	self actualizar.
]

{ #category : #accessing }
PanelPuntuacion >> labelFigurasJ1 [
	^ labelFigurasJ1

]

{ #category : #accessing }
PanelPuntuacion >> labelFigurasJ2 [ 
	^ labelFigurasJ2

]

{ #category : #accessing }
PanelPuntuacion >> labelNombreJ1 [ 
	^ labelNombreJ1

]

{ #category : #accessing }
PanelPuntuacion >> labelNombreJ2 [ 
	^ labelNombreJ2

]

{ #category : #accessing }
PanelPuntuacion >> labelPuntuacion [
	^labelPuntuacion.
]

{ #category : #accessing }
PanelPuntuacion >> labelSuperficieJ1 [ 
	^ labelSuperficieJ1

]

{ #category : #accessing }
PanelPuntuacion >> labelSuperficieJ2 [ 
	^ labelSuperficieJ2

]

{ #category : #accessing }
PanelPuntuacion >> labelTituloJ1 [
	^ labelTituloJ1

]

{ #category : #accessing }
PanelPuntuacion >> labelTituloJ2 [
	^ labelTituloJ2

]

{ #category : #accessing }
PanelPuntuacion >> partida [ 
^partida.
]

{ #category : #accessing }
PanelPuntuacion >> partida: unaPartida [
	partida := unaPartida

]
