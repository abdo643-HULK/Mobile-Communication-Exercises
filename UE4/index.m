fun = @(f) 1/1+1j*2*pi*f*R*C;
p = integral(abs(fun)^2,-Inf,Inf)