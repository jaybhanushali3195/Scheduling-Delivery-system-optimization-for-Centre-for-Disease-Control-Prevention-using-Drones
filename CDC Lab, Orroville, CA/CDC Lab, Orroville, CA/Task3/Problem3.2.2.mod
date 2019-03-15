var x{i in H, k in H, j in D} binary;	#1 if drone j of type visits arc i, 0 otherwise
var u{i in H}>=0 integer;

set D;			#Order of drones
set H ordered;			# Hospitals
set C ordered:= 2..21;

param n := CARDINALITY{C}; #Number of Cities or Hospitals
set m := 0..(2**n - 1);  #Total number of possible subsets 
set POWER{p in m} := {q in C: (p div 2**(ord(q)-1)) mod 2 = 1}; #Power set

param CAP12{j in D};			#Capacities for drone type 1 and 2

param de{i in H};			#demand of hospital H

param di{i in H, k in H};	#distace of hospital d from hospital f

param d1;					#Total Number of drones 

minimize totaldistance: sum{i in H, k in H, j in D} x[i,k,j] * di[i, k];


subject to  c1{k in H:k<>1}: sum{i in H,j in D:i<>k} x[i, k, j] = 1;
subject to  c2{i in H:i<>1}: sum{k in H,j in D:i<>k} x[i, k, j] = 1;
subject to c3{j in D}: sum{i in H, k in H:i=1 and k<>1} x[i, k, j] = 1;
subject to c4{j in D}:sum{i in H, k in H} x[i, k, j] * de[i] <= CAP12[j];
subject to c5{j in D}: sum{i in H, k in H:k=1 and i<>1} x[i, k, j] = 1;
subject to c6{j in D, f in H}:sum{i in H} x[i, f, j] - sum{k in H} x[f, k, j] = 0;
subject to c7{r in m: r != 0}: sum{j in D, s in POWER[r], t in POWER[r]: s<>t and CARDINALITY{POWER[r]} <= 3} x[s,t,j] <= CARDINALITY {POWER[r]} - 1; 
