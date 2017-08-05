utility
extractForTesting: dataFrame by: ratio shuffled: shuffling
	| rowDeck cut trainingData testData |
	
	rowDeck := dataFrame rowNames.
	shuffling ifTrue: [ rowDeck := rowDeck shuffled ].
	cut := (rowDeck size * ratio) ceiling.
	trainingData := dataFrame rowsAt: (rowDeck first: cut).
	testData := dataFrame rowsAt: (rowDeck copyFrom: cut + 1 to: rowDeck size).
	^ Array with: trainingData with: testData
