
p = 10;
nu = 1 ;
M = 6;
n = 15;
k = n-M+1;

%g = @(x,k) 100*(k+(sum((((x-0.5).^2) - (cos(20*pi*(x-0.5)))),2)));

g = @(x,k) (sum((x-0.5).^(2),2));

alpha = 100; %usually this order of magnitude
form_x = @(x,alpha) (power(x,alpha));

data = DTLZ_frame(p,M,n,nu,g,form_x,alpha);

filename = sprintf('DTLZ4_%s_%s_%s',p,n,M);
save(filename,'data');
