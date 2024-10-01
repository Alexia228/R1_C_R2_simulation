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
            if obj.active
                if time - obj.local_time > obj.period && voltage < obj.v_lim
                    obj.active = false;
                    value = 0;
                else
                    value = obj.amp;
                end
            else
                if voltage > obj.v_lim
                    obj.active = true;
                    obj.local_time = time;
                    value = obj.amp;
                else
                    value = 0;
                end
            end
        end

        

    end

    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        amp double = 0;
        period double = 1; % s
        local_time double = 0; % s
        v_lim  double = 1; % V
        active logical = false;
    end

    methods (Access = private)


    end
end
% -------------------------------------------------------------------------
