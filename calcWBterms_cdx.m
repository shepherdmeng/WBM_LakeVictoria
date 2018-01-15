% --------------------------------------------------------------------
% Script to calculate the WB model terms of CORDEX data (historical and RCPs)
% --------------------------------------------------------------------

% initialise matrices for wb terms of all models
%(ordered following model number)

% lake precipitation
P_wb = NaN(nm,ndays); 

% lake evaporation
E_wb = NaN(nm,ndays); 

% inflow
Qin_wb = NaN(nm,ndays); 

% calculate the CN number
CN = calc_CN(nx,ny); 

% define number of antecedent day precipitation to determine AMC
amc_days = 5; 


% loop over all models
for i = 1:nm
     
    % load in 2 variables for particular model
    load_cdx;
    
    % unit conversion
    E = LHF/Lvap * 3600 * 24 *10^(-3); 
    
    clear LHF
    
    P = P        * 3600 * 24 *10^(-3);
    
    % loop over all days
   for t = 1:ndays
       
        % calculate lake precipitation
%         P_lake(:,:,t) = mask_lake.*P(:,:,t);
        
        % calculate lake evaporation
        E_lake(:,:,t) = mask_lake.*E(:,:,t);
   end     
        % calculate mean precipitation over the lake
%         P_mean(t) = nanmean(nanmean(P_lake(:,:,t))); % average all precip [m]
%         if (isnan(P_mean(t))) P_mean(t) = 0; end
        
        % calculate mean evaporation over the lake
        E_mean(t) = nanmean(nanmean(E_lake(:,:,t))); % average all evap [m]

       % clear P_lake P
        
        % calculate basin precipitation (needed for inflow calculations)
       % P_basin(:,:,t) = mask_basin.*P(:,:,t);

   end
   
   clear E_lake E 

   
   % solve the inflow for the model
   Qin = solveQin_CN(P_basin, CN, amc_days, ndays, A_cell)
   
   clear P_basin 
   
   % save P_mean in matrix for all models
   P_wb(i,:) = P_mean; 
   
   % save E_mean in matrix for all models
   E_wb(i,:) = E_mean; 
   
   % save Qin in matrix for all models
   Qin_wb(i,:) = Qin
   
   clear P_mean E_mean Qin 
   
end

if flag_run == 3 % historical
    
    P_wb_hist = P_wb; 
    E_wb_hist = E_wb; 
    Qin_wb_hist = Qin_wb; 
    
    save P_wb_hist.mat P_wb_hist
    save E_wb_hist.mat E_wb_hist
    save Qin_wb_hist.mat Qin_wb_hist
    
elseif flag_run == 4 % RCP 2.6
    
    P_wb_rcp26 = P_wb; 
    E_wb_rcp26 = E_wb; 
    Qin_wb_rcp26 = Qin_wb; 
    
    save P_wb_rcp26.mat P_wb_rcp26
    save E_wb_rcp26.mat E_wb_rcp26
    save Qin_wb_rcp26.mat Qin_wb_rcp26
    
elseif flag_run == 5 % RCP 4.5
    
    P_wb_rcp45 = P_wb; 
    E_wb_rcp45 = E_wb; 
    Qin_wb_rcp45 = Qin_wb; 
    
    save P_wb_rcp45.mat P_wb_rcp45
    save E_wb_rcp45.mat E_wb_rcp45
    save Qin_wb_rcp45.mat Qin_wb_rcp45
    
elseif flag_run == 6 % RCP 8.5
    
    P_wb_rcp85 = P_wb; 
    E_wb_rcp85 = E_wb; 
    Qin_wb_rcp85 = Qin_wb; 
    
    save P_wb_rcp85.mat P_wb_rcp85
    save E_wb_rcp85.mat E_wb_rcp85
    save Qin_wb_rcp85.mat Qin_wb_rcp85
    
end
