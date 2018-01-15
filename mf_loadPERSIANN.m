

% --------------------------------------------------------------------
% function to load 2D model data
% --------------------------------------------------------------------


function [lat lon VAR] = mf_loadPERSIANN(file_name, VAR, nc)


% check if file is there
file_exist = exist(file_name,'file');


% 1. if file is there:
if file_exist == 2

    
% load data
lat = ncread(file_name, 'lat'); % latitude [° N] (axis: Y)
lon = ncread(file_name, 'lon'); % longitude [° E] (axis: X)
VAR =  ncread(file_name, VAR  ) ; % Total precipitation [mm]


% crop out 'nc' boundary grid points
lat = lat(1+nc:end-nc,1+nc:end-nc);
lon = lon(1+nc:end-nc,1+nc:end-nc);

% crop out 'nc' boundary grid points
VAR = VAR(1+nc:end-nc,1+nc:end-nc,:,:);


% 2. if file is not there: send out warning
else
disp(strcat('file ',file_name,' does not exist'));
end


end

