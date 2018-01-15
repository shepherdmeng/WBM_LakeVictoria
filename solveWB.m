
% ------------------------------------------------------------------------
% Function to solve the Water Balance
%   INPUT:  - mean precipitation over the lake
%           - mean evaporation over the lake
%           - inflow
%           - outflow
%           - lake surface area
%           - initial lake level
%   OUTPUT: - L lakelevel
% ------------------------------------------------------------------------

function [L,Qout,dL] = solveWB(P_mean, E_mean,Qin,Qout, A_lake, L0, ndays,flag_run,flag_outscen,lakelevel)
       
L(1) = L0;
dL(1)=0;
    for t = 1:ndays-1
        if flag_run>1
            if flag_outscen > 1
                Qout(t) = solveQout(flag_outscen,L(t),P_mean(t),E_mean(t),Qin(t),A_lake);
            end
        end
 %             if flag_run ==3
 %                 Qout(t) = lakelevel(t);
 %             end
            % Use estimated L for the outflow to calculate L(t+1)
            L(t+1) = L(t)+ P_mean(t) - E_mean(t) + (Qin(t)-Qout(t))/(A_lake); 
            dL(t+1) = P_mean(t) - E_mean(t) + (Qin(t)-Qout(t))/(A_lake); 
    end
end


