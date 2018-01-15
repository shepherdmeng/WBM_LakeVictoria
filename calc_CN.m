% ------------------------------------------------------------------------
% Subroutine to determine CN values of study area
% ------------------------------------------------------------------------

function [CN] = calc_CN(nx,ny)
% Load soil map
soil_raster = GRIDobj('soils_old.tif');
soils = double(soil_raster.Z); 

% convert soil map in hydrologic soil classes
soil_classification = textread('soil_classification.txt');  
soil_classification(26) = 0; 

% Load land cover map
lc_raster = GRIDobj('landcover.tif');
land_cover = double(lc_raster.Z); 

% Read in table with CN values
CNvalues = textread('CNvalues.txt');

% initialise
CN = zeros(nx,ny);

% Loop over grid cells to determine CN
for i = 1:nx
    for j = 1:ny
         % determine hydrologic soil type
          soil_type(i,j) = soil_classification(soils(i,j)); 
        
        % if water body: no runoff (CN = 0) 
        if (land_cover(i,j) == 8 ||soil_type(i,j)==0) 
            CN(i,j) = 100;            
        else
            % Find corresponding CN value (default AMC = 2)
            CN(i,j) = CNvalues(land_cover(i,j), soil_type(i,j));
        end
        
    end
end

% subbasins = GRIDobj('subbasin_raster.tif');
