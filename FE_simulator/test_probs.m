
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

