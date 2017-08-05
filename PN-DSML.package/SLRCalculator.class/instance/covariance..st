computing
covariance: dataFrame
	| xvalues yvalues xmean ymean covar |

	xvalues := dataFrame columnAt: 1.
	yvalues := dataFrame columnAt: 2.	
	xmean := self mean: xvalues.
	ymean := self mean: yvalues.	
	covar := 0.
	1 to: xvalues size do: [ :idx |
		covar := covar + (((xvalues at: idx) - xmean) * ((yvalues at: idx) - ymean)) ].
	^ covar 
	