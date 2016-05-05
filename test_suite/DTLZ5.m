
%to generate the data, simple run this script (press F5) and you'll have
%the data generated in `data` variable.

p = 100;
nu = 1 ;
M = 4;
n = 8;
k = n-M+1;

%g = @(x,k) 100*(k+(sum((((x-0.5).^2) - (cos(20*pi*(x-0.5)))),2)));

g = @(x,k) (sum((x-0.5).^(2),2)); % k is passed for DTLZ3.m

alpha = 100; %usually this order of magnitude
% repmat for p data points processed together in matrix

form_x = @(x,g,X) (repmat((pi/(4.*(1+g(X,k))))',1,n).*(1+2*x.*repmat(g(X,k),1,n)));

data = DTLZ_frame(p,M,n,nu,g,form_x);

filename = sprintf('DTLZ5_%s_%s_%s',p,n,M);
save(filename,'data');


%write a line to save the variable as `DTLZ5.mat`