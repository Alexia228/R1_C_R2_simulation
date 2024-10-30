function [voltage_array, time] = voltage_triangle(amp, period)
    step = 0.1;
    start_time = 0;
    stop_time = period;
    time = (start_time : step : stop_time);
    voltage_up = amp/(period / 2)*time;
    voltage_up = voltage_up(1:round(length(time)/2));
    voltage_down = -amp/(period / 2)*time + 2*amp;
    voltage_down = voltage_down(length(voltage_up)+1:length(time));
    voltage_array = [voltage_up voltage_down];


end
