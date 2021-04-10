"
Unit tests for SLRCalculator.
"
Class {
	#name : #SLRCalculatorTests,
	#superclass : #TestCase,
	#instVars : [
		'slr',
		'df'
	],
	#category : 'PN-DSML'
}

{ #category : #initialization }
SLRCalculatorTests >> setUp [

	slr := SLRCalculator new.
	df := DataFrame fromRows: #((1 1) (2 3) (4 3) (3 2) (5 5)).
	df columnNames: #(X Y)
]

{ #category : #tests }
SLRCalculatorTests >> testCoefficients [
	| coeff |
	 
	coeff := slr coefficients: df.
	self assert: (coeff at: 1) = (2/5).
	self assert: (coeff at: 2) = (4/5)
]

{ #category : #tests }
SLRCalculatorTests >> testCovariance [
	
	self assert: (slr covariance: df) = 8
]

{ #category : #tests }
SLRCalculatorTests >> testMean [
	
	self assert: (slr mean: (df column: #X)) = 3.
	self assert: (slr mean: (df column: #Y)) = (14/5).
	
]

{ #category : #tests }
SLRCalculatorTests >> testSimpleLinearRegression [
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

]

{ #category : #tests }
SLRCalculatorTests >> testVariance [
	
	self assert: (slr variance: (df column: #X)) = 10.
	self assert: (slr variance: (df column: #Y)) = (44/5).
	
]
