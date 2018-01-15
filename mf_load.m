

% --------------------------------------------------------------------
% function to load 2D model data
% --------------------------------------------------------------------


function [lat lon VAR] = mf_load(file_name, VAR, nc)


% check if file is there
file_exist = exist(file_name,'file');


% 1. if file is there:
if file_exist == 2

    
% load data
lat = rot90(ncread(file_name, 'lat')); % latitude [° N] (axis: Y)
lon = rot90(ncread(file_name, 'lon')); % longitude [° E] (axis: X)
VAR =       ncread(file_name, VAR  ) ; % Total precipitation [mm]


% crop out 'nc' boundary grid points
lat = lat(1+nc:end-nc,1+nc:end-nc);
lon = lon(1+nc:end-nc,1+nc:end-nc);


% check variable dimensions and tread accordingly
[nx ny nz nt] = size(VAR);
if     numel(size(VAR)) == 2
    VAR = rot90(VAR); 
elseif numel(size(VAR)) == 3
    VARr = NaN(ny,nx,nz);
    for i=1:size(VAR,3)
        VARr(:,:,i) = rot90(VAR(:,:,i));
    end
    VAR = VARr;
elseif numel(size(VAR)) == 4
    VAR = permute(VAR,[1 2 4 3]);
    % check dimensions again after permute command
    if     numel(size(VAR)) == 3    % it was a 'fake' fourth dimension (e.g. U10,V10)
        VARr = NaN(ny,nx,nz);
        for i=1:size(VAR,3)
            VARr(:,:,i) = rot90(VAR(:,:,i));
        end
        VAR = VARr;
    elseif numel(size(VAR)) == 4    % it was a real fourth dimension (e.g. QV_hm)
        
        % undo permute (result: vertical: 3th, time: 4th)
        VAR = permute(VAR,[1 2 4 3]);
        VARr = NaN(ny,nx,nz,nt);
        for i=1:size(VAR,3)
            for j=1:size(VAR,4)
                VARr(:,:,i,j) = rot90(VAR(:,:,i,j));
            end
        end
        VAR = VARr;
    end
end


% crop out 'nc' boundary grid points
VAR = VAR(1+nc:end-nc,1+nc:end-nc,:,:);


% 2. if file is not there: send out warning
else
disp(strcat('file ',file_name,' does not exist'));
end


end

