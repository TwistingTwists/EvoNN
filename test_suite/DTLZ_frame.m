%{
this script generates common frame for DTLZ problems to generate data. [3]
p = # data points wanted
nu = frequency
M = #objective
n = #variables
k = n - M + 1
g = g(X) ; refer chapter mentioned for more details
%}

function F = DTLZ_frame(p,M,n,nu,g,varargin)

% over many runs of this `rand` function it has been observed that x is not uniformly distributed
x = rand(p,n); % each column is a decision variable ; each row is a prey(=data point) in decision space
k = n - M + 1;
X = x(:,k:n); % slicing last k decision variables
assert(k>=0, 'k must be non-negative. Choose n,M wisely. (k = n - M +  1)')

%% to handle the forms of x in various DTLZ functions 4 and 5
if isempty(varargin)
    a = x;
elseif (length(varargin)==1)
    form_x = varargin{1};
    a = form_x(x,g,X);
elseif length(varargin)==2
    form_x = varargin{1};
    alph = varargin{2}; %alph because alpha is a keyword in MATLAB
    a = form_x(x,alph);
end

%%
F = ones(p,M);
for i=1:M-2
   F(:,1:M-i) = F(:,1:M-i).*repmat(cos(a(:,i)*0.5*pi*nu),1,M-i);
end

%adjusting each F
F(:,1) = F(:,1).*cos(a(:,M-1)); %as defined in reference
for i=2:M
    %F(:,i) = F(:,i).*sin(x(:,M-i+1)*0.5*pi*nu);
    F(:,i) = F(:,i).*sin(a(:,M-i+1)*0.5*pi*nu);
end

%Finally, Multiplying (1+g(X,k))
retu = (1+g(X,k));
retu = repmat(retu,1,M);
F = F.*retu;

F = [x, F];
%{
for i=2:M-1
   F = [F a];
   a = a.*cos(x(:,i)*pi*0.5);
end
    F = [F a]; % appending M-1 th.

a = sin(x(:,1)*pi*0.5);
b = cos(x(:,i)*pi*0.5);

F(:,1:M-1).*a;
%}


end



%% References
%{
[3]: Ch-06, Evolutionary Multiobjective Optimisation : Theoretical Advances and Applications, Springer, 2005
%}
