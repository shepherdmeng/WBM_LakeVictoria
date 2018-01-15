% --------------------------------------------------------------------
% Function to calculate lake inflow based on CN method
% --------------------------------------------------------------------

function [Qin,Q] = solveQin_CN(P_basin, CN, amc_days, ndays, A_cell)
    fprintf('Calculating Qin ... ');

    % initialise 
    Q = zeros(size(P_basin));  % outflows 
    AM = zeros(size(P_basin)); % antecedent moisture

    % initialise AM for first amc_days
    AM(:,:, 1:amc_days) = 0.0112; % mean condtion
    
    % loop over all cells to calculate runoff
    for t=amc_days:ndays
         for i = 1:size(P_basin,1)
             for j = 1:size(P_basin,2)

               % determine antecedent moisture condition
                if t>amc_days
                    for k = 1:amc_days
                        AM(i,j,t) = AM(i,j,t)+P_basin(i,j,t-k); 
                    end
                end

                % determine CN runoff
                [Q(i,j,t),CN_AMC(i,j,t)] = calc_runoff_CN(P_basin(i,j,t),AM(i,j,t),CN(i,j)); 

              end 
         end

         % calculate total runoff of basin
         Qin(t) = nansum(nansum(Q(:,:,t).*A_cell));

         % calculate runoff in Kagera basin
%          Q_kagera(:,:,t) = Q(:,:,t).*mask_kagera; 
%          Qin_kagera(t) = nansum(nansum(Q_kagera(:,:,t).*A_cell)); 

          % calculate runoff in Yala/Nzoia basin
%          Q_yala(:,:,t) = Q(:,:,t).*mask_yala; 
%          Qin_yala(t) = nansum(nansum(Q_yala(:,:,t).*A_cell)); 


         % calculate routed runoff 
         % [Q_routed(:,:,t), CA(:,:,t)] = calc_routing(Q(:,:,t), ix, ixc, lake_pix, basin_pix);

     end
end
 
 