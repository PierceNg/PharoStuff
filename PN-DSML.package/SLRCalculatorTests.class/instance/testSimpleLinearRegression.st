tests
testSimpleLinearRegression
	| testData output rmse |
	 
	testData := DataFrame fromContents: df contents
		rowNames: (1 to: df numberOfRows) asArray 
		columnNames: df columnNames.
	output := (slr simpleLinearRegression: df with: testData) columnAt: 1.
	self assert: (output at: 1) = (6/5).
	self assert: (output at: 2) = 2.
	self assert: (output at: 3) = (18/5).
	self assert: (output at: 4) = (14/5).
	self assert: (output at: 5) = (22/5).
	
	rmse := slr rmsError: (df columnAt: 2) with: output.
	self assert: rmse = 0.6928203230275509 
