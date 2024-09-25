classdef Current_source < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)
        %Конструктор класса
        function obj = Current_source(amp)
            if ~isnumeric(amp)
                error('wrong argument type')
            end
            obj.amp = amp;
            disp('obj "Current_source" is created')
        end

        function set_active(obj, flag)
            obj.active = flag;
        end

        function value = get_value(obj)
            if obj.active
                value = obj.amp;
            else
                value = 0;
            end
        end

        function product = get_product(obj, val)
            product = val * obj.amp;
        end
    end

    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        amp double = 0;
        active logical = false;
    end

    methods (Access = private)


    end
end
% -------------------------------------------------------------------------
