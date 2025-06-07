
function x = SF_trig(a, b)
T = 3;

w0 = 2*pi/T;

t = linspace(-2*T,2*T,10000); % construiremos 4 ciclos de x(t)

x = (a(1)/2)*ones(1,length(t));

for n=2:length(a)

    x = x + a(n)*cos(n*w0*t);

end

for n=1:length(b)

    x = x + b(n)*sin(n*w0*t);

end

plot(t,x);
ylabel('x(t)');
xlabel('t');
grid
