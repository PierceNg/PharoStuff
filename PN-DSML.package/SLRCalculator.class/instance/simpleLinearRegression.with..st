computing
simpleLinearRegression: trainingData with: testData
	| predictions coeff b0 b1 |
	
	predictions := OrderedCollection new.
	coeff := self coefficients: trainingData.
	b0 := coeff at: 1.
	b1 := coeff at: 2.
	testData do: [ :row |
		predictions add: (b0 + (b1 * (row at: 1))) ].
	^ DataFrame fromColumns: (Array with: predictions asArray)
	