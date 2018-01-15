% ------------------------------------------------------------------------
% Implement future Outflow Scenario
% flag_outscen = 1: constant outflow
%                 2: constant lake level
%                 3: according to Agreed Curve
% ------------------------------------------------------------------------
function [Qout] =  solveQout(flag_outscen,L,P,E,Qin,A_lake)

   % Constant lake level
   if flag_outscen == 2
    
        Qout_temp = (P-E)*A_lake+Qin; 

        % account for negative outflows
        if Qout_temp > 0
            Qout = Qout_temp; 
        else
            Qout = 0; 
    end
   % According to Agreed Curve
   elseif flag_outscen == 3
    
    % convert lake level to Jinja dam level
    load diff_abs_jinja
    L_dam = L-diff_abs_jinja; 
    
    % Agreed Curve parameters (according to Sene, 2000)
    a = 66.3;
    b = 2.01;
    c = 7.96;

    % calculate outflow (agreed curve: in m³ per second)
    Qout_s = a.*(L_dam-c).^b;
    % convert to m³/day
    Qout = Qout_s.*3600.*24;

    
    end
end