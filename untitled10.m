

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


N = 10000;

A = -ones(1, N);
% A(2:2:end) = 1;
voltage = [0:0.1:10 10:-0.1:-10 -10:0.1:0];


output = [];
for  i = 1:numel(voltage)
    
    [Ppn, Pnp] = switching_probability(voltage(i));


    A = switch_foo(A, 1, Ppn);
    A = switch_foo(A, -1, Pnp);


    output(i, :) = A;
end


figure
imagesc(output)


%%

Q = mean(output, 2);

plot(voltage, Q)
ylim([-1.1 1.1])

%%

plot(diff(Q))














