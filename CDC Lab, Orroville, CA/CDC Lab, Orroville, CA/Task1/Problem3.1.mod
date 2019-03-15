
param cost{1..2}; # cost associated with each drone type
param c{1..2};# 
param a{1..4,1..2}; #
param typ1;# Minimum number of type 1 drones needed	
param typ2;# Minimum number of type 2 drones needed
param d{1..4};# aggregated demand for 4 hours

var x{i in 1..2, j in 1..4} integer>=0;

minimize ScheduleCost : sum{i in 1..2, j in 1..4} cost[i]*x[i,j];

subject to C1: c[1]*x[1,1] + c[2]*x[2,1]>=d[1];
subject to C2: c[1]*(x[1,1]+x[1,2]) + c[2]*(x[2,1]+x[2,2])>=d[2];
subject to C3: c[1]*(x[1,1]+x[1,2]+x[1,3])+c[2]*(x[2,2]+x[2,3])>=d[3]; 
subject to C4: c[1]*(x[1,2]+x[1,3]+x[1,4]) + c[2]*(x[2,3]+x[2,4])>=d[4]; 
subject to C5{ i in 1..1}: sum{j in 1..4} x[i,j]>=typ1;
subject to C6{ i in 2..2}: sum{j in 1..4} x[i,j]>=typ2;
