clc
clear

tstep = 0.01;
start = 0;
stop = 10;
t = [start:tstep:stop];
Nt = -(start-stop)/tstep+1;
T = 50;
f = zeros(1,Nt);

i = 600;
range = t >= t(i) & t<= t(i) + T ;
plot(t, range)


clc
Period = 0.5;
state = "off"
for i = 1:numel(t)
disp(['i = ' num2str(i)])

time = t(i);

if i > 100 && state == "off"
    start_time = time;
    state = "on";
end

if time - start_time > Period && state == "on"
    state = "off";
end


end







