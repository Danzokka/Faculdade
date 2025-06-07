function x = SF_exp(c,T)

% c deve ter comprimento ímpar

w0 = 2*pi/T;

t = linspace(-2*T,2*T,10000); % construiremos 4 ciclos de x(t)

x = zeros(1,length(t));

centro = ceil(length(c)/2);

for n=1:length(c)

    x = x + c(n)*exp(j*(n-centro)*w0*t);

end

plot(t,x);
ylabel('x(t)');
xlabel('t');
grid
