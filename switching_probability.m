
function [Ppn, Pnp] = switching_probability(force)

Lp1 = 2;
Lp2 = 15;

Ln1 = -2;
Ln2 = -35;

Ppn = 1/(Ln2-Ln1)*force - Ln1/(Ln2-Ln1);
Pnp = 1/(Lp2-Lp1)*force - Lp1/(Lp2-Lp1);

range = Ppn>1;
Ppn(range) = 1;
range = Ppn<0;
Ppn(range) = 0;

range = Pnp>1;
Pnp(range) = 1;
range = Pnp<0;
Pnp(range) = 0;

% range = Ppn==0;
% Ppn(range) = 0.005;
% range = Pnp==0;
% Pnp(range) = 0.005;


end
