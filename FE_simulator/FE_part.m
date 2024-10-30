%% Current source class
% version 0.5.0 (03.10.2024)


% TODO:
% 1) add parallel RC
% 2) add voltage-speed dependence (with const Q)
% 3) add POS and NEG limits
% 4) care about units
% 5) create current source factory

classdef FE_part < handle
    %--------------------------------PUBLIC--------------------------------
    methods (Access = public)

        function obj = FE_part(Sample)
            NN = Sample.atoms;
            obj.P_total = Sample.Ps; % uC/cm^2
            obj.Thickness = Sample.thickness; % m
            obj.Area = Sample.area; % m^2
            Ec = Sample.Ec;

            obj.Array = -1*ones(1, NN);
            obj.Switching_zone = Generate_switching_zone(Ec, Ec);
            obj.diel_p = rand(1)*0.3 + 0.3; % FIXME
            obj.Res = rand(1)*10e9 + 20e9; % Ohm
        end

        function I = get_p(obj, voltage, time_step)
            Field = (voltage*0.001)/(obj.Thickness*100); % kV/cm
            obj.update(Field, time_step);
            P_diel = obj.diel_p * Field;
            P_fe = mean(obj.Array, 2)*obj.P_total;

            P = P_fe + P_diel;
            if isnan(obj.P_old)
                delta_P = 0;
            else
                delta_P = P - obj.P_old;
            end
            obj.P_old = P;

            delta_P = (delta_P/1e6)*100*100; % C/m^2

            Q = delta_P*obj.Area; % C
            I_fe = Q/time_step; % A = C/s
            I_leak = voltage/obj.Res;
            I = I_fe + I_leak;
    
            I_const = 0.1e-9;
            noise = 2*(rand(1)-0.5) * 10e-9;
            I = I + noise + I_const;
        end

    end

    %-------------------------------PRIVATE--------------------------------
    properties (Access = private)
        Array;

        Thickness;
        Area;
        
        Switching_zone;
        P_total;
        Res;
        diel_p; 

        P_old = NaN;
    end

    methods (Access = private)

        function update(obj, filed, time_step)
            switching_zone = obj.Switching_zone;
            [Ppn, Pnp] = switching_probability(filed, switching_zone, time_step);
            obj.Array = switch_foo(obj.Array, Ppn);
            obj.Array = switch_foo(obj.Array, Pnp);
        end

    end
end
% -------------------------------------------------------------------------
