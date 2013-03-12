function pass = test_real(pref)

if ( nargin < 1 )
    pref = funcheb.pref;
end
tol = 10*pref.funcheb.eps;

for ( n = 1:2 )
    if ( n == 1 )
        testclass = funcheb1();
    else 
        testclass = funcheb2();
    end

    % Test a scalar-valued function:
    f = testclass.make(@(x) cos(x) + 1i*sin(x), 0, pref);
    g = testclass.make(@(x) cos(x), 0, pref);
    h = real(f);
    pass(n, 1) = norm(h.values - g.values, inf) < tol;
    
    % Test a multi-valued function:
    f = testclass.make(@(x) [cos(x) + 1i*sin(x), -exp(1i*x)], 0, pref);
    g = testclass.make(@(x) [cos(x), -real(exp(1i*x))], 0, pref);
    h = real(f);
    pass(n, 2) = norm(h.values - g.values, inf) < tol;
    
    % Test a real function:
    f = testclass.make(@(x) 1i*cos(x), pref);
    g = real(f);
    pass(n, 3) = numel(g.values) == 1 && g.values == 0;
    
    
    % Test a multivalued real function:
    f = testclass.make(@(x) 1i*[cos(x), sin(x), exp(x)], pref);
    g = real(f);
    pass(n, 4) = all(size(g.values) == [1, 3]) && all(g.values == 0);
end

end
