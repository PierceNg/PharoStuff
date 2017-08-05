initialization
setUp

	slr := SLRCalculator new.
	df := DataFrame fromRows: #((1 1) (2 3) (4 3) (3 2) (5 5)).
	df columnNames: #(X Y)