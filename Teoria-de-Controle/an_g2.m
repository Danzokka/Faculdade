w0 = 2*pi/4;
a = zeros(1,10);
for n = 1:10
    if n == 0
        a(n) = 0;
    else
        a(n) = ((2*sin(3*w0*n))-sin(w0*n)-sin(2*w0*n))/(3*w0*n);
    end
end

b = zeros(1,10);
index = 1;

for n = 1:10
    b(index) = (cos(2*n*w0)+cos(n*w0)-(2*cos(3*n*w0)))/(3*n*w0);
    index = index + 1;
end
