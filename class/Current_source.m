%% Current source class
% version 0.5.0 (03.10.2024)


% TODO:
% 1) add parallel RC
% 2) add voltage-speed dependence (with const Q)
% 3) add POS and NEG limits
% 4) care about units
% 5) create current source factory

classdef Current_source < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)

        function obj = Current_source(amp, period, v_lim)
            if ~isnumeric(amp)
                error('wrong argument type')
            end
            obj.amp = amp;
            obj.period = period;
            obj.v_lim = v_lim;
            disp('obj "Current_source" is created')
        end


        function value = get_value(obj, voltage, time)
            if obj.output_active
                if time - obj.local_time > obj.period
                    obj.output_active = false;
                    obj.polarity = -1*obj.polarity;
                end
            else
                if obj.trigger_condition(voltage)
                    obj.output_active = true;
                    obj.local_time = time;
                end
            end

            if obj.output_active
                t = time - obj.local_time;
                value = obj.pulse(obj.pulse_type, t);
                value = value*obj.polarity;
            else
                value = 0;
            end
        end



    end

    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        amp double = 0;
        polarity double = 1;
        period double = 5; % s
        v_lim  double =1; % V

        pulse_type string = "gauss"
        local_time double = 0; % s
        output_active logical = false;
    end

    methods (Access = private)

        function value = pulse(obj, pulse_type, t)
            if pulse_type == "const"
                value = obj.amp;

            elseif pulse_type == "gauss"
                a = 0.5*obj.period;
                b = 0.2*obj.period;
                value = obj.amp*exp(-(t-a).^2/b.^2);
            end
        end

        function flag = trigger_condition(obj, voltage)
            flag = obj.polarity*voltage >= obj.v_lim;
        end

    end
end
% -------------------------------------------------------------------------
