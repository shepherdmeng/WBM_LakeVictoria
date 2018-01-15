% -----------------------------------------------------------------------
% Script to load observational data
% -----------------------------------------------------------------------

% -----------------------------------------------------------------------
% Load LHF from model data (model Wim)
% -----------------------------------------------------------------------
% units: [J/s]
%[~, ~, LHF_monmean] = mf_load('1996-2008_FLake_out02_ymonmean.nc','ALHFL_S', nc);

[lat_LHF, lon_LHF, LHF_daymean] = mf_load('1996-2008_FLake_out02_LHF_ydaymean.nc','ALHFL_S', nc);


% -----------------------------------------------------------------------
% Load PERSIANN-CDR data
% -----------------------------------------------------------------------

[ lat_P, lon_P, P] = mf_loadPERSIANN('PERSIANN-CDR_v01r01_1992_2014_AGL_remapped_owngrid.nc','precipitation', nc);

     

% -----------------------------------------------------------------------
% Load GLEAM data
% -----------------------------------------------------------------------
% units: [mm/day m²]
% [ lat_E, lon_E, E_gleam] = mf_loadPERSIANN('GLEAM_1992_2014_remapped_owngrid.nc','E', nc); 

