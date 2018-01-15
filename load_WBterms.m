% --------------------------------------------------------------------
% Script to load calculated WB terms for CORDEX data (historical and RCPs
% --------------------------------------------------------------------
  

if flag_run == 2 % evaluation
    
    load P_wb_ev
    load E_wb_ev
    load Qin_wb_ev    
    
elseif flag_run == 3 % historical
    
    load P_wb_hist
    load E_wb_hist
    load Qin_wb_hist

elseif flag_run == 4 % RCP 2.6 
    
    load P_wb_rcp26
    load E_wb_rcp26
    load Qin_wb_rcp26
    
elseif flag_run == 5 % RCP 4.5 
    
    load P_wb_rcp45_CRCM5
    load E_wb_rcp45_CRCM5
    load Qin_wb_rcp45_CRCM5
    
    load P_wb_rcp45
    load E_wb_rcp45
    load Qin_wb_rcp45
    
elseif flag_run == 6 % RCP 8.5
    
    load P_wb_rcp85
    load E_wb_rcp85
    load Qin_wb_rcp85
    
end