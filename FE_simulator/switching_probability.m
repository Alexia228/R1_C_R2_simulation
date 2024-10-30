
function [out_Ppn, out_Pnp] = switching_probability(force, Switching_zone, time_step)
%Ppn - вероятность перехода positive-negative
%Pnp - вероятность перехода negative-positive


Lp1 = Switching_zone(3); % positive left
Lp2 = Switching_zone(4); % positive right

Ln1 = Switching_zone(2); % negative right
Ln2 = Switching_zone(1); % negative left

Ppn = 1/(Ln2-Ln1)*force - Ln1/(Ln2-Ln1);
Pnp = 1/(Lp2-Lp1)*force - Lp1/(Lp2-Lp1);

Scale = 1000; % FIXME: magic constant
Ppn = Ppn*time_step*Scale;
Pnp = Pnp*time_step*Scale;

range = Ppn > 1;
Ppn(range) = 1;

range = Ppn < 0;
Ppn(range) = 0;

range = Pnp > 1;
Pnp(range) = 1;

range = Pnp < 0;
Pnp(range) = 0;

% range = Ppn==0;
% Ppn(range) = 0.005;
% range = Pnp==0;
% Pnp(range) = 0.005;

out_Pnp.p = Pnp;
out_Pnp.from = -1;
out_Pnp.to = 1;

out_Ppn.p = Ppn;
out_Ppn.from = 1;
out_Ppn.to = -1;

end
