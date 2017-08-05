example
example1
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
