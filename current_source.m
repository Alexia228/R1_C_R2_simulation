clear
clc

R = 100e3;
C = 10e-6;
Ulim = 2;


tstep = 0.001;
start = 0;
stop = 10;
t = [start:tstep:stop];
Nt = -(start-stop)/tstep+1;
K = tstep/(R*C);

%Прямоугольный импульс тока
% Io = zeros(size(t));
% for i = 1 : Nt-2
% range(i) = t(i) >= 2 && t(i) <= 3;
% end
% Io(range) = 5;
Io = zeros(1,Nt);

%Импульс напряжения
Uin = 4*sin(t);

Iout = zeros(1,Nt);
Uout = zeros(1,Nt);

circuit_num = 1;

for i = 1 : Nt-1
    time = t(i);
    Iout(i+1) = 1/R * (Uin(i+1)-Uin(i)) + Iout(i) +...
      tstep/(R*C) * (Io(i) - Iout(i));
    Uout(i+1) = tstep/(R*C) * (Uin(i) - Uout(i)) + Uout(i);

    if Uout(i) > Ulim
       local_time = time;
         
    else
        if time - local_time > Time_limit
            Io = zeros(1,Nt);
        end
    end
end

hold on
plot(t, Iout, 'r')
plot(t, Uout)
yline(Ulim)
plot(t, Io)



