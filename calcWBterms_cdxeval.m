% --------------------------------------------------------------------
% Subroutine to prepare the WB model for CORDEX data
% --------------------------------------------------------------------


% initialise model parameters
L0 = lakelevel(1);


% calculate the CN number
CN = calc_CN(nx,ny); 


% define number of antecedent day precipitation to determine AMC
amc_days = 5; 


% define field names
fields = fieldnames(P_lake_ev); 

% initialise WB terms
Qin_wb_ev = NaN(nRCMs,ndays);
P_wb_ev = NaN(nRCMs,ndays);
E_wb_ev = NaN(nRCMs,ndays);
L_ev = NaN(nRCMs,ndays);

% loop over RCMs
tic
 for i=1:numel(fields)
        
        fprintf('Processing RCM %d ',i); 
        
        % Define variables for RCMs
        P_lake = P_lake_ev.(fields{i}); 
        P_basin = P_basin_ev.(fields{i}); 
        E_lake = E_lake_ev.(fields{i});   
        
       for t = 1:ndays
           % Calculate terms of WB
           P_mean(t) = nanmean(nanmean(P_lake(:,:,t))); % average all precip [m]
           if (isnan(P_mean(t))) P_mean(t) = 0; end
           E_mean(t) = nanmean(nanmean(E_lake(:,:,t))); % average all evap [m]
       end
       % store terms
       P_wb_ev(i,:) = P_mean; 
       E_wb_ev(i,:) = E_mean; 

        % solve the inflow with the CN method
        Qin = solveQin_CN(P_basin, CN, amc_days, ndays, A_cell);        
        
        % store Qin
        Qin_wb_ev(i,:) = Qin; 
        
        % solve the water balance
        [L] = solveWB(P_mean, E_mean, Qin, Qout, A_lake, L0, ndays);        
        
        % store lake level
        L_ev(i,:) = L;
         
        % clear variables
        clear P_lake P_basin E_lake L       
        
 end 
 toc

P_wb_ev
