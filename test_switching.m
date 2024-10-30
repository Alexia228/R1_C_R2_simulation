
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

% voltage = [0:V_step:Amp Amp:-V_step:-Amp -Amp:V_step:0];

% voltageDWM = [0:V_step:Amp Amp:-V_step:0 0:V_step:Amp ...
%               Amp:-V_step:-Amp -Amp:V_step:0 0:-V_step:-Amp -Amp:V_step:0];
% voltage = voltageDWM;

% time = linspace(0, T_period , numel(voltage));
% time_step = time(2) - time(1);

waveform_up = voltage_triangle(150,10, 1);
waveform_down = voltage_triangle(150,10, -1);

[Field_1, P_int_1] = Experiment(Sample, FE, waveform_up);
[Field_2, P_int_2] = Experiment(Sample, FE, waveform_up);
[Field_3, P_int_3] = Experiment(Sample, FE, waveform_down);
[Field_4, P_int_4] = Experiment(Sample, FE, waveform_down);
Pmax_1 = max(P_int_1);
Pmin_1 = min(P_int_3);
Pmax_2 = max(P_int_2);
Pmin_2 = min(P_int_4);

figure
hold on
% plot(Field_1, P_int_1-Pmax_1/2+5.5, '.')
% plot(Field_2, P_int_2+1.2, '.')
% plot(Field_3, P_int_3-Pmin_1/2, '.')
% plot(Field_4, P_int_4-Pmin_2/2, '.')

P_int_p = P_int_1 - P_int_2;
P_int_n = P_int_3 - P_int_4;

correction_p = (P_int_p(end)-P_int_p(1))/2;
correction_n = (P_int_n(end)-P_int_n(1))/2;

plot(Field_1, P_int_p-correction_p, '.')
plot(Field_3, P_int_n-correction_n, '.')

% plot(Field, I)
xlabel('E, kV/cm')
ylabel('P, uC/cm^2')


function [Field, P_int] = Experiment(Sample, FEset, waveform)

voltage = [waveform.voltage] ;
time = [waveform.time];

time_step = time(2) - time(1);

Current = [];
for  i = 1:numel(voltage)
    cur = 0;
    for k = 1:numel(FEset)
        cur = cur + FEset(k).get_p(voltage(i), time_step);
    end
    Current(i) = cur/numel(FEset);
end

Q_int = cumsum(Current)*time_step;

Area = Sample.area;
Thickness = Sample.thickness;
P_int = (Q_int*1e6)/(Area*100*100);
Field = (voltage*1e-3)/(Thickness*100);

end











