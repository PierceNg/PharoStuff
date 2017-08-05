computing
rmsError: actuals with: predicted
	| sErr pErr |
	
	sErr := 0.
	1 to: actuals size do: [ :idx |
		pErr := (predicted at: idx) - (actuals at: idx).
		sErr := sErr + (pErr ** 2) ].
	^ (sErr / actuals size) sqrt
