loop = 4;

for i = 1:loop
    hjw = 0.833 / sqrt((i^2 - 2)^2 + (2.083 * i)^2);
    disp(['|H(j', num2str(i), ')| = ', num2str(hjw)]);
end