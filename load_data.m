% -----------------------------------------------------------------------
% Script to load data
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% Load lake levels 
% -----------------------------------------------------------------------
% DAHITI lake levels (units: [m/day]) 
[date_dh(:,1), date_dh(:, 2), date_dh(:,3), dh_lakelevel,...
    dh_lakelevel_err] = textread('DAHITI_lakelevels.txt'); 

% HYDROMOET lake levels (no constant time series) (units: [m/day])
[date_hm_raw(:,1), date_hm_raw(:, 2), date_hm_raw(:,3), lakelevel_hm_raw,...
    lakelevel_jinja_raw] = textread('Jinja_lakelevels.txt'); 


% -----------------------------------------------------------------------
% Load lake batymetry
% -----------------------------------------------------------------------

% batymetry of all lakes     
[lat_CCLM, lon_CCLM, depth_CCLM] = mf_load('lffd1996010100c.nc', 'DEPTH_LK', nc);

% surface height - DEM available (not needed anymore)
% [~, ~, hsurf] = mf_load('lffd1996010100c.nc', 'HSURF', nc);

% for lake mask - based on shapefile (not needed anymore)
%[ ~, ~, T_S_LAKE_FLa] = mf_load('1996-2008_FLake_out02_timmean.nc', 'T_S_LAKE', nc);


% --------------------------------------------------------------------
% Load shape files
% --------------------------------------------------------------------

% Load shape files
shp_Vict = load('shp_Vict','shp_Vict'); % Lake Victoria
shp_Vict = shp_Vict.shp_Vict;
shp_basin = load('shp_basin'); % Lake Victoria basin
shp_basin = shp_basin.shp_basin;

% load longitude and latitude
load lon_P.mat
load lat_P.mat

% --------------------------------------------------------------------
% Load observed wb terms
% --------------------------------------------------------------------
   
load P_wb_obs
load E_wb_obs
load Qin_wb_obs
    

