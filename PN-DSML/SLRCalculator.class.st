"
I am a simple linear regression calculator.  See #example1 on my class side for example usage, and #example2 that adds graphing using Roassal.

Source material:
http://machinelearningmastery.com/implement-simple-linear-regression-scratch-python/
"
Class {
	#name : #SLRCalculator,
	#superclass : #Object,
	#category : 'PN-DSML'
}

{ #category : #example }
SLRCalculator class >> example1 [
	| s allData splitArray trainingData testData output rmse |

	s := self new. 
	allData := self loadSwedishAutoInsuranceData.
	splitArray := s extractForTesting: allData by: 0.6 shuffled: false.  
	trainingData := splitArray at: 1.
	testData := splitArray at: 2.
	output := s simpleLinearRegression: trainingData with: testData.
	rmse := s rmsError: (testData columnAt: 2) with: (output columnAt: 1).
	^ rmse	
	"RMSE should = 45.230000269615424"

]

{ #category : #example }
SLRCalculator class >> example2 [
	"This is example1 plus graphing using Roassal."
	| allData splitArray trainingData testData s coeff output g dsa dlr legend |

	allData := self loadSwedishAutoInsuranceData.
	s := self new.
	splitArray := s extractForTesting: allData by: 0.6 shuffled: false.  
	trainingData := splitArray at: 1.
	testData := splitArray at: 2.
	coeff := s coefficients: trainingData.
	output := s simpleLinearRegression: trainingData with: testData.

	g := RTGrapher new.

	allData do: [ :row |
		dsa := RTData new.
		dsa dotShape color: Color blue.
		dsa points: { (row at: 1) @ (row at: 2) }.
		dsa x: #x.
		dsa y: #y.
		g add: dsa ].

	dlr := RTData new.
	dlr noDot.
	dlr connectColor: Color red.
	dlr points: (allData column: #X).
	dlr x: #yourself.
	dlr y: [ :v | (coeff at: 1) + (v * (coeff at: 2)) ].
	g add: dlr.

	g axisX noDecimal.
	g axisY.
	g shouldUseNiceLabels: true.
	g build.

	legend := RTLegendBuilder new.
	legend view: g view.
	legend addText: 'X axis = Number of claims.'.
	legend addText: 'Y axis = Total payment in Swedish kroners.'.
	legend textSize: 2. 
	legend gapSize: 1.
	legend build.

	^ g

	"rmse := s rmsError: (testData columnAt: 2) with: (output columnAt: 1).
	^ rmse"	
	"RMSE should = 45.230000269615424"
]

{ #category : #data }
SLRCalculator class >> loadSwedishAutoInsuranceData [
	"Source: https://www.math.muni.cz/~kolacek/docs/frvs/M7222/data/AutoInsurSweden.txt"
	| df |
	
	df := DataFrame fromRows: #(
            ( 108 392.5 )
            ( 19 46.2 )
            ( 13 15.7 )
            ( 124 422.2 )
            ( 40 119.4 )
            ( 57 170.9 )
            ( 23 56.9 )
            ( 14 77.5 )
            ( 45 214 )
            ( 10 65.3 )
            ( 5 20.9 )
            ( 48 248.1 )
            ( 11 23.5 )
            ( 23 39.6 )
            ( 7 48.8 )
            ( 2 6.6 )
            ( 24 134.9 )
            ( 6 50.9 )
            ( 3 4.4 )
            ( 23 113 )
            ( 6 14.8 )
            ( 9 48.7 )
            ( 9 52.1 )
            ( 3 13.2 )
            ( 29 103.9 )
            ( 7 77.5 )
            ( 4 11.8 )
            ( 20 98.1 )
            ( 7 27.9 )
            ( 4 38.1 )
            ( 0 0 )
            ( 25 69.2 )
            ( 6 14.6 )
            ( 5 40.3 )
            ( 22 161.5 )
            ( 11 57.2 )
            ( 61 217.6 )
            ( 12 58.1 )
            ( 4 12.6 )
            ( 16 59.6 )
            ( 13 89.9 )
            ( 60 202.4 )
            ( 41 181.3 )
            ( 37 152.8 )
            ( 55 162.8 )
            ( 41 73.4 )
            ( 11 21.3 )
            ( 27 92.6 )
            ( 8 76.1 )
            ( 3 39.9 )
            ( 17 142.1 )
            ( 13 93 )
            ( 13 31.9 )
            ( 15 32.1 )
            ( 8 55.6 )
            ( 29 133.3 )
            ( 30 194.5 )
            ( 24 137.9 )
            ( 9 87.4 )
            ( 31 209.8 )
            ( 14 95.5 )
            ( 53 244.6 )
            ( 26 187.5 )).	
	df columnNames: #(X Y).
	^ df
]

{ #category : #computing }
SLRCalculator >> coefficients: dataFrame [
	| xvalues yvalues xmean ymean b0 b1 |
	
	xvalues := dataFrame columnAt: 1.
	yvalues := dataFrame columnAt: 2.
	xmean := self mean: xvalues.
	ymean := self mean: yvalues.	
	b1 := (self covariance: dataFrame) / (self variance: xvalues).
	b0 := ymean - (b1 * xmean).
	^ Array with: b0 with: b1
]

{ #category : #computing }
SLRCalculator >> covariance: dataFrame [
	| xvalues yvalues xmean ymean covar |

	xvalues := dataFrame columnAt: 1.
	yvalues := dataFrame columnAt: 2.	
	xmean := self mean: xvalues.
	ymean := self mean: yvalues.	
	covar := 0.
	1 to: xvalues size do: [ :idx |
		covar := covar + (((xvalues at: idx) - xmean) * ((yvalues at: idx) - ymean)) ].
	^ covar 
	
]

{ #category : #utility }
SLRCalculator >> extractForTesting: dataFrame by: ratio [
	^ self extractForTesting: dataFrame by: ratio shuffled: false 
]

{ #category : #utility }
SLRCalculator >> extractForTesting: dataFrame by: ratio shuffled: shuffling [
	| rowDeck cut trainingData testData |
	
	rowDeck := dataFrame rowNames.
	shuffling ifTrue: [ rowDeck := rowDeck shuffled ].
	cut := (rowDeck size * ratio) ceiling.
	trainingData := dataFrame rowsAt: (rowDeck first: cut).
	testData := dataFrame rowsAt: (rowDeck copyFrom: cut + 1 to: rowDeck size).
	^ Array with: trainingData with: testData

]

{ #category : #computing }
SLRCalculator >> mean: values [
	^ values average
]

{ #category : #computing }
SLRCalculator >> rmsError: actuals with: predicted [
	| sErr pErr |
	
	sErr := 0.
	1 to: actuals size do: [ :idx |
		pErr := (predicted at: idx) - (actuals at: idx).
		sErr := sErr + (pErr ** 2) ].
	^ (sErr / actuals size) sqrt

]

{ #category : #computing }
SLRCalculator >> simpleLinearRegression: trainingData with: testData [
	| predictions coeff b0 b1 |
	
	predictions := OrderedCollection new.
	coeff := self coefficients: trainingData.
	b0 := coeff at: 1.
	b1 := coeff at: 2.
	testData do: [ :row |
		predictions add: (b0 + (b1 * (row at: 1))) ].
	^ DataFrame fromColumns: (Array with: predictions asArray)
	
]

{ #category : #computing }
SLRCalculator >> variance: values [
	| mean |
	
	mean := self mean: values.
	^ (values collect: [ :x | (x - mean) ** 2 ])
		inject: 0 into: [ :sum :val | sum + val ]
	
]
