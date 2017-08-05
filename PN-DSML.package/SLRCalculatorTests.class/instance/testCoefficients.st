tests
testCoefficients
	| coeff |
	 
	coeff := slr coefficients: df.
	self assert: (coeff at: 1) = (2/5).
	self assert: (coeff at: 2) = (4/5)