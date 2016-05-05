%{ 
this script generates common frame for DTLZ problems to generate data. [3]
p = # data points wanted
nu = frequency
M = #objective 
n = #variables
k = n - M + 1
g = g(X) ; refer chapter mentioned for more details
%}

p = 100;
nu = 1;
M = 6;
n = 8;
k = n-M+1;

g = @(x,k) 100*(k+(sum((((x-0.5).^2) - (cos(20*pi*(x-0.5)))),2)));

data = DTLZ_frame(p,M,n,nu,g);
filename = sprintf('DTLZ3_%s_%s_%s',p,n,M);
save(filename,'data');


%% References
%{
[3]: Ch-06, Evolutionary Multiobjective Optimisation : Theoretical Advances and Applications, Springer, 2005 
%}