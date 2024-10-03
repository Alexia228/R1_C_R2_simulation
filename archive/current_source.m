clear
clc

R = 100e2;
C = 10e-6;
Ulim = 1;
Period = 1;

%Амплитуда Io
Amplitude = 1.5


tstep = 0.001;
start = 0;
stop = 10;
t = [start:tstep:stop];
Nt = -(start-stop)/tstep+1;
K = tstep/(R*C);


Io = zeros(1,Nt);

%Импульс напряжения
Uin = 4*sin(2*t);

Iout = zeros(1,Nt);
Uout = zeros(1,Nt);
range = zeros(1,Nt);

circuit_num = 1;

for i = 1 : Nt-1
    Iout(i+1) = 1/R * (Uin(i+1)-Uin(i)) + Iout(i) +...
      tstep/(R*C) * (Io(i) - Iout(i));
    Uout(i+1) = tstep/(R*C) * (Uin(i) - Uout(i)) + Uout(i);
    
    %Условно такой класс:   
    Io = cs.get_value(Uout, time);


end

hold on
plot(t, Iout, 'r')
plot(t, Uout, 'b')
yline(Ulim)




