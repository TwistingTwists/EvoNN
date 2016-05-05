%this script generates data variables according to DTLZ6 
p = 500;
nu = 1;
M = 6;
n = 9;
k = n-M+1;

g = @(x,k) (sum((x).^(0.1),2));

data = DTLZ_frame(p,M,n,nu,g);

filename = sprintf('DTLZ6_%s_%s_%s',num2str(p),num2str(n),num2str(M));
save(filename,'data');

%% References
%{
[3]: Ch-06, Evolutionary Multiobjective Optimisation : Theoretical Advances and Applications, Springer, 2005 
%}