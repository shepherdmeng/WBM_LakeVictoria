% ------------------------------------------------------------------------
% Function to remap the original CCLM² grid to self defined Lake Victoria 
% model grid (details see find_coordinates script) for 2D data. 
% ------------------------------------------------------------------------

% MOET NOG AAN GEWERKT WORDEN!!

function [newgrid, lat_intp, lon_intp] = remap2owngrid(oldgrid, lat_CCLM, lon_CCLM)

    % Define own grid
    [Xq,Yq] = meshgrid(1:1:130);
   
    x_cut = 20:120; 
    y_cut = 80:160; 
    
    x = 43:120; 
    
    % cut old grid
    oldgrid_cut= oldgrid(x_cut, y_cut); 
    lat_cut = lat_CCLM(x_cut,y_cut); 
    lon_cut = lon_CCLM(x_cut,y_cut);
    
    
    % interpolate on own grid
    newgrid = interp2(oldgrid_cut,Xq,Yq);
    lat_intp = interp2(lat_cut,Xq,Yq); 
    lon_intp = interp2(lon_cut,Xq,Yq); 

end