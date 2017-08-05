tests
testMean
	
	self assert: (slr mean: (df column: #X)) = 3.
	self assert: (slr mean: (df column: #Y)) = (14/5).
	