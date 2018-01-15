% --------------------------------------------------------------------
% Function to calculate pixel runoff based on CN method 
% 
% Input: 
% - P precipitation over basin cell (m)
% - ind_pix: the pixel index (format: [x y])
% Output: 
% - Q: runoff per pixel (mm/m²)
% 
% WORKFLOW
%  1. Determine CN number of pixel based on AMC
%  2. Calculate S (maximum soil retention parameter)
%  3. Calculate Q (runoff)
% --------------------------------------------------------------------



function [Q,CN]= calc_runoff_CN(P, AM, CN)

    % convert P from m to mm
      P = P*10^3; 

    % Rough estimation: constant value for whole catchment: 
    % land cover: cultivated area, soil class D
    % CN = 91; 
    
    % special case: water
  
    % determine AMC based on table (Descheemaeker, 2008)
    % Apply antecendent moisture condition on curve number
             if AM<0.0125 % AMC = 1
                 CN = CN/(2.281-0.01281*CN);
             elseif AM>0.0275 % AMC = 3
                 CN = CN/(0.427+0.00573*CN); 
             end
             
 
        % 2. Calculate S (maximum soil water retention parameter)
        S = 25400/CN-254;
        
        % 3. Calculate Q (outflow)
        if (P> 0.2*S) % must be exceeded to create runoff (ook op pixel level?) 
            Q = ((P-0.2*S)^2/(P+0.8*S))*10^(-3);
        else
           Q = 0; 
        end
    
end