function y = polyval(p, x)
%POLYVAL  Evaluate polynomial with CHEBFUN argument.
%   Y = polyval(P, X) returns the value of a polynomial P evaluated at the
%   CHEBFUNX. P is a column vector of length N + 1 whose elements are the
%   coefficients of the polynomial in descending powers.
%        Y = P(1)*X^N + P(2)*X^(N-1) + ... + P(N)*X + P(N+1)
%
%   If P is a matrix _or_ X is a quasimatrix then a quasimatrix Y is returned.
%   If P is a matrix _and_ X is a quasimatrix then an error is thrown.
%  
% Example:
%   Evaluate the polynomial p(x) = 3x^2 + 2x + 1:
%   
%   p = [3 2 1].;
%   x = chebfun('x');
%   polyval(p, x)

if ( size(p, 2) > 1 && numColumns(x) > 1 )
    error('CHEBFUN:CHEBFUN:polyval:dimmismatch', ...
        'Input P must be a column vector or X must be a scalar-valued CHEBFUN.');
end

% Ensure column CHEBFUN:
isTrans = get(x, 'isTransposed');
if ( isTrans )
    x = x.';
end

% Ensure correct number of columns:
x = repmat(x, 1, size(p, 2));

% Horner's scheme:
y = 0*x + p(1,:);
for j = 2:size(p, 1)
    y = y.*x + p(j,:);
end

% Revert to row CHEBFUN:
if ( isTrans )
    y = y.';
end

end