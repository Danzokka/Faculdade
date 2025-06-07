w0 = 2*pi/4;
j = i;
c = zeros(1,21);
index = 1;

for n = -10:10
    if n == 0
        c(index) = 0;
    else
        value = (exp(-j*n*w0*4) - exp(-j*n*w0*2))/(-4*j*n*w0);
        c(index) = value;
    end
    index = index + 1;
end

