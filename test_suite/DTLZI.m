function F = DTLZI(p, n, m)
X = rand(p, n);
F = [X];
for i=1:m
	x = ones(p,1);
	for j=1:i-1
		x = x.*X(:,j);
	if i==m
		x = 0.5*(x.*(1 + gi(X(:,m:n))));
	else
		x = 0.5*(x.*(1-X(:,i))).*(1 + gi(X(:,m:n)));
	end
	F = [F x];
    end
end
end

function sig = gi(X)
	sig = zeros(size(X,1),1);
	k = size(X,2);
	for i = 1:k
		sig = sig + (X(:,i) - 0.5).^2 - cos(20*pi*(X(:,i)) - 0.5);
	end
	sig = 100*(k + sig);
end

DTLZI(100, 10, 5)