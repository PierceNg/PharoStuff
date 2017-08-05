data
loadSwedishAutoInsuranceData
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