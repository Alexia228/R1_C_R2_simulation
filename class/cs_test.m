
clc
clear

cs_array(1) = Current_source(2, 1, 2);
cs_array(2) = Current_source(1, 0.4, 2);
cs_array(3) = Current_source(0.3, 2, 2);

voltage_amp = 5;
time_period = 20;

[time_array, voltage_array] = waveform_trangle(voltage_amp, time_period);


current_array = zeros(size(time_array));
for i = 1:numel(time_array)
    time = time_array(i);
    voltage = voltage_array(i);
    current_array(i) = sum_current(cs_array, voltage, time);
end


Q = cumsum(current_array)*(time_array(2)-time_array(1));

figure('position', [525 280 665 740])
subplot(2, 1, 1)
hold on
plot(time_array, voltage_array)
plot(time_array, current_array)
box on
grid on
xlabel('t')
ylabel('V and I')

subplot(2, 1, 2)
plot(voltage_array, Q)
box on
grid on
xlabel('V')
ylabel('Q')



function current = sum_current(cs_array, voltage, time)
    current = 0;
    for i = 1:numel(cs_array)
        current = current + cs_array(i).get_value(voltage, time);
    end
end

function [t_array, v_array] = waveform_trangle(v_amp, full_period)
time_step = full_period/1000;

time_1_rise = 0 : time_step : full_period/4;
time_2_fall = full_period/4+time_step : time_step : full_period*3/4;
time_3_rise = full_period*3/4+time_step : time_step : full_period-time_step;

voltage_1_rise = linspace(0, v_amp, numel(time_1_rise));
voltage_2_fall = linspace(v_amp, -v_amp, numel(time_2_fall));
voltage_3_rise = linspace(-v_amp, 0, numel(time_3_rise));

t_array = [time_1_rise time_2_fall time_3_rise];
v_array = [voltage_1_rise voltage_2_fall voltage_3_rise];
end




