
addpath(genpath('FE_simulator/'));

%%

clc


Amp = 150;
V_step = Amp/250;
T_period = 10; % s


Thickness = 100e-6; % m
Area = (1e-3)^2; % m^2
Q_total = 30; % uC/cm^2

Sample.area = (1e-3)^2; % m^2
Sample.thickness = 100e-6; % m
Sample.Ps = 30; % uC/cm^2
Sample.atoms = 50;
Sample.Ec = 5; % kV/cm

for k = 1:20
    FE(k) = FE_part(Sample);
end

voltage = [0:V_step:Amp Amp:-V_step:-Amp -Amp:V_step:0];

% voltageDWM = [0:V_step:Amp Amp:-V_step:0 0:V_step:Amp ...
%               Amp:-V_step:-Amp -Amp:V_step:0 0:-V_step:-Amp -Amp:V_step:0];
% voltage = voltageDWM;

time = linspace(0, T_period , numel(voltage));
time_step = time(2) - time(1);

Current = [];
for  i = 1:numel(voltage)
    cur = 0;
    for k = 1:numel(FE)
        cur = cur + FE(k).get_p(voltage(i), time_step);
    end
    Current(i) = cur/numel(FE);
end

Q_int = cumsum(Current)*time_step;
P_int = (Q_int*1e6)/(Area*100*100);
Field = (voltage*1e-3)/(Thickness*100);

hold on
plot(Field, P_int, '.')
% plot(Field, I)
xlabel('E, kV/cm')
ylabel('P, uC/cm^2')















