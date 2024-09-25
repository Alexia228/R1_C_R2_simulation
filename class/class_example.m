

clc

cs = Current_source.empty;
cs(1) = Current_source(2.6);
cs(2) = Current_source(1.6);

for i = 1:numel(cs)
    cs(i).set_active(true);
    cs(i).get_value
end








