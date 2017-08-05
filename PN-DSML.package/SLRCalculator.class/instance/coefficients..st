computing
coefficients: dataFrame
	| xvalues yvalues xmean ymean b0 b1 |
	
	xvalues := dataFrame columnAt: 1.
	yvalues := dataFrame columnAt: 2.
	xmean := self mean: xvalues.
	ymean := self mean: yvalues.	
	b1 := (self covariance: dataFrame) / (self variance: xvalues).
	b0 := ymean - (b1 * xmean).
	^ Array with: b0 with: b1