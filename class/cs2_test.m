


cs2 = Current_source2(2);


time_array = 0:0.001:10;
voltage_array = linspace(-1, 3, numel(time_array));

k = 1;
current_array = zeros(size(time_array));
for i = 1:numel(time_array)
    time = time_array(i);
    voltage = voltage_array(i)*k;
    voltage_array(i) = voltage_array(i)*k;
    current_array(i) = cs2.get_value(voltage, time);
    if current_array(i) > 0
        k = 0.3;
    end
end


figure
hold on
plot(time_array, voltage_array)
plot(time_array, current_array)










