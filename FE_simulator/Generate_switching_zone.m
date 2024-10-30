


function Switching_zone = Generate_switching_zone(Ec_p, Ec_n)

Ec_p = rand_range(Ec_p*0.8, Ec_p*1.2);
Ec_n = rand_range(Ec_n*0.8, Ec_n*1.2);

Start_pos = Ec_p*0.8;
Start_neg = -Ec_n*0.8;

Pos_scale = rand_range(2, 20);
Neg_scale = rand_range(2, 20);
End_pos = Start_pos*Pos_scale;
End_neg = Start_neg*Neg_scale;

Switching_zone = [End_neg Start_neg Start_pos End_pos];


end



function r = rand_range(a, b)
if numel(a) ~= numel(b)
    error('!')
else
    N = numel(a);
end

Amp = b-a;
r = rand(1, N).*Amp;
r = r + a;
end






