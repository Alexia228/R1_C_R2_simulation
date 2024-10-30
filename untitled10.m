

force = -10:0.01:10;
[Ppn, Pnp] = switching_probability(force);

figure
hold on
plot(force, Ppn, '-r', 'linewidth', 2)
plot(force, Pnp, '-b', 'linewidth', 2)
box on
grid on
ylim([-0.1 1.1])



%%

clc

N = 1000;

A = -ones(1, N);
% A(2:2:end) = 1;
voltage = [0:0.1:10 10:-0.1:-10 -10:0.1:0];
voltageDVM = [0:0.1:10 10:-0.1:0 0:0.1:10 10:-0.1:-10 -10:0.1:0 0:-0.1:-10 -10:0.1:0];
time = linspace(0, 100 , numel(voltageDVM));

output = [];
for  i = 1:numel(voltageDVM)
    
    [Ppn(i), Pnp(i)] = switching_probability(voltageDVM(i));

    A = switch_foo(A, Ppn(i));
    A = switch_foo(A, Pnp(i));

    output(i, :) = A;
end

hold on

% figure
% imagesc(output)


diel_part = 0.2*voltageDVM;

Q_total = 60/2; % uC/cm^2
Q = mean(output, 2)*Q_total + diel_part';

% plot(time, voltageDVM)
plot(voltageDVM, Q)

ylim([-1.1 1.1]*Q_total)
xlabel('E, a.u.')
ylabel('P, uC/cm^2')

%%

plot(diff(Q))














