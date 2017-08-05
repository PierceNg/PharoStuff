example
example2
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