
Switching_zone = Generate_switching_zone(3, 3);
force = -10:0.01:10;
% Switching_zone = [-7 -3 2 5];
[Ppn, Pnp] = switching_probability(force, Switching_zone, 1e-3);

% figure
hold on
plot(force, Ppn.p, '-r', 'linewidth', 2)
plot(force, Pnp.p, '-b', 'linewidth', 2)
box on
grid on
ylim([-0.1 1.1])



%%

clc

N = 50;

A = -ones(1, N);
% A(2:2:end) = 1;

Amp = 8;
V_step = Amp/250;
T_period = 1;
Switching_zone = Generate_switching_zone(3, 3);
voltage = [0:V_step:Amp Amp:-V_step:-Amp -Amp:V_step:0];
% voltageDWM = [0:V_step:Amp Amp:-V_step:0 0:V_step:Amp ...
%               Amp:-V_step:-Amp -Amp:V_step:0 0:-V_step:-Amp -Amp:V_step:0];
voltage = voltage;
time = linspace(0, T_period , numel(voltage));
time_step = time(2) - time(1);

output = [];
for  i = 1:numel(voltage)
    
    [Ppn(i), Pnp(i)] = switching_probability(voltage(i), Switching_zone, time_step);

    if i == 1
        time_prev = time(i);
    else
        time_prev = time(i-1);
    end
    A = switch_foo(A, Ppn(i), time(i), time_prev);
    A = switch_foo(A, Pnp(i), time(i), time_prev);

    output(i, :) = A;
end

hold on

% figure
% imagesc(output)


% diel_part = 0.2*voltageDVM;

Q_total = 1; % uC/cm^2
% Q = mean(output, 2)*Q_total + diel_part';
Q = mean(output, 2)*Q_total;

% plot(time, voltageDVM)
plot(voltage, Q)

ylim([-1.1 1.1]*Q_total)
xlabel('E, a.u.')
ylabel('P, uC/cm^2')

%%

plot(diff(Q))














