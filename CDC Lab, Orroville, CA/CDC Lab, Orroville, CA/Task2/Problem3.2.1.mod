#Exact formulation 1
param n; #number of cities or hospital including the lab
param T; #number of drones of each type
param a{k in 1..T}; #capacity for each drone type
param d{j in 1..n}; #vaccine demand from each city or hospital
param cost{i in 1..n,j in 1..n}; #distance between cities to cities and lab to cities 

var x{i in 1..n,j in 1..n,k in 1..T}binary; # represents path of drone type k from city i to city j
var r{i in 1..n}; #flow variable


minimize Distance: sum{i in 1..n, j in 1..n,k in 1..T} cost[i,j]*x[i,j,k]; 

subject to c1{j in 2..n}: sum{i in 1..n,k in 1..T} x[i,j,k] = 1; #each hospital is visited once and by only one drone
subject to c2{k in 1..T,p in 2..n}: sum{i in 1..n:i<>p} x[i,p,k] - sum{j in 1..n:p<>j} x[p,j,k] = 0; #a drone that enters a city will leave the city
subject to c3{i in 1..n}: r[1] = 0; #the cdc lab should not be inlcuded as it has no demand, it is the supplier
subject to c4{i in 1..n, j in 2..n}: r[j]-r[i] >= (d[j]+a[T])*sum{k in 1..T}x[i,j,k] - a[T];
subject to c5{ j in 2..n}: r[j] <= sum{i in 1..n,k in 1..T} a[k]*x[i,j,k];
subject to c6: sum{j in 2..n} x[1,j,1] = 8; # Number of type 1 drones 
subject to c7: sum{j in 2..n} x[1,j,2] = 6; # Number of type 2 drones
