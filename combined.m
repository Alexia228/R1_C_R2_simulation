% ON if Uout > Ulim
% OFF if Uout > Ulim && time from ON > to

clc
clear

R1 = 100e3;
R2 = 100e3;
C = 10e-6;

tstep = 0.01;
start = 0;
stop = 10;
t = (start:tstep:stop);
Nt = -(start-stop)/tstep+1;

Ulim = 8;
%Наклон треугольного импульса
k = 4;
to = 300;

%Счётчики циклов
first = 0;
second = 0;

%Кривое создание треугольного импульса
Uin = t(1 : Nt/2)*k;
Uin(Nt/2 : Nt) = t(Nt/2 : Nt)*(-k) + 40;
Uout = zeros(1,Nt);

for i = 1 : Nt-1
    if Uout(i) < Ulim 
        Uout(i+1) = tstep/(R1*C) * (Uin(i) - Uout(i)) + Uout(i);
        first = first + 1;
        
    elseif Uout(i) > Ulim 
        for j = i-1 : 300 %Неясно, какая нужна правая граница
            Uout(j+1) = tstep/(R1*C) * (Uin(j) - Uout(j)) - tstep/(R2*C)*Uout(j) + ... 
            + Uout(j);   
        end
        second = second + 1;
    end
end

hold on
plot(t,Uin, 'b')
yline (Ulim)
plot(t, Uout, 'r');






















