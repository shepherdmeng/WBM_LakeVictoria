% -----------------------------------------------------------------------
% Find coordinates of observation grid 
% -----------------------------------------------------------------------

% Values of own grid (out of cdo script)
dx = 0.065; 
nx = 130-2*nc; 
ny = 130-2*nc; 
x0 = 28; 
y0 = -5.5; 
xf = x0+nx*dx; 
yf = y0+ny*dx; 

lon= zeros(nx,ny); 
lat = zeros(nx,ny); 

lon(:,1) = x0; 
for i = 1:(ny-1)
    lon(:,i+1) = lon(:,i)+dx; 
end

lat(nx,:) = y0; 
for i = 1:(nx-1)
    lat(nx-i,:) = y0+i*dx; 
end

own_grid = NaN(nx,ny); 