tests
testVariance
	
	self assert: (slr variance: (df column: #X)) = 10.
	self assert: (slr variance: (df column: #Y)) = (44/5).
	