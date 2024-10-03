% ON if Uout > Ulim
% OFF if Uout > Ulim && time from ON > to

clc
clear

R1 = 100e3;
R2 = 10e3;
C = 10e-6;

tstep = 0.001;
start = 0;
stop = 10-tstep;
t = (start:tstep:stop);
Nt = -(start-stop)/tstep+1;

Ulim = 8;
%Наклон треугольного импульса
k = 4;
to = 300;

%Счётчики циклов
first = 0;
second = 0;

Time_limit = 0.4;

%Кривое создание треугольного импульса
Uin = t(1 : Nt/2)*k;
Uin(Nt/2 : Nt) = t(Nt/2 : Nt)*(-k) + 40;
Uout = zeros(1,Nt);

k1 = 0;
k2 = 0;


circ_num_out  =[]; 
circuit_num = 1;   % Номер схемы

local_time = 0;

for i = 1 : Nt-1
    time = t(i)

    switch circuit_num
        case 1
            Uout(i+1) = tstep/(R1*C) * (Uin(i) - Uout(i)) + Uout(i);

        case 2
            Uout(i+1) = tstep/(R1*C) * (Uin(i) - Uout(i)) - tstep/(R2*C)*Uout(i) + ...
                + Uout(i);
    end

    if Uout(i) > Ulim
        local_time = time;
        circuit_num = 2;
    else
        if time - local_time > Time_limit
            circuit_num = 1;
        end
    end

    circ_num_out(i) = circuit_num;
end

circ_num_out(end+1) = circ_num_out(end);

figure
hold on
plot(t,Uin, 'b')
yline (Ulim)
plot(t, Uout, 'r');
plot(t, circ_num_out, 'k');






















