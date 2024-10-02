classdef Current_source2 < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)
        
        function obj = Current_source2(amp)
            if ~isnumeric(amp)
                error('wrong argument type')
            end
            obj.amp = amp;
            disp('obj "Current_source" is created')
        end


        function value = get_value(obj, voltage, time)
            value = 0;
            if obj.active
                if time - obj.local_time > obj.period && voltage < obj.v_lim
                    obj.active = false;
                else
                    t = time - obj.local_time;
                    value = obj.pulse("gauss", t);
                end
            else
                if voltage > obj.v_lim
                    obj.active = true;
                    obj.local_time = time;
                    t = time - obj.local_time;
                    value = obj.pulse("gauss", t);
                end
            end
        end

        

    end

    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        amp double = 0;
        period double = 5; % s
        local_time double = 0; % s
        v_lim  double =1; % V
        active logical = false;
        pulse_type string = "const"
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
    
            

        


    end
end
% -------------------------------------------------------------------------
