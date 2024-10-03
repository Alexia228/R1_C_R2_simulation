
clear
clc

R = 100e3;
C = 10e-6;


tstep = 0.001;
start = 0;
stop = 10;
t = [start:tstep:stop];
Nt = -(start-stop)/tstep+1;
K = tstep/(R*C);

% Uin = zeros(size(t));
% range = t >= 1;
% Uin(range) = 5;


Uin = sin(2*pi*.5*t);
Uin(Uin>0) = 1;
Uin(Uin<0) = -1;


Uout = zeros(1,Nt);

for i = 1 : Nt-1
    Uout(i+1) = K * (Uin(i) - Uout(i)) + Uout(i);
end

hold on
plot(t, Uin, 'b');
plot(t, Uout, 'r');
