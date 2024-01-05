w0 = 2*pi/4;
a = zeros(1,10);
for n = 1:10
    if n == 0
        a(n) = 0;
    else
        a(n) = (sin(4*n*w0)-(sin(2*n*w0)))/(2*n*w0);
    end
end

b = zeros(1,9);
index = 1;

for n = 1:9
    b(index) = (cos(2*n*w0)-cos(4*n*w0))/(2*n*w0);
    index = index + 1;
end
