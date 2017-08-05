computing
variance: values
	| mean |
	
	mean := self mean: values.
	^ (values collect: [ :x | (x - mean) ** 2 ])
		inject: 0 into: [ :sum :val | sum + val ]
	