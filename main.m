
% --------------------------------------------------------------------
% main script Water Balance Lake Victoria
% Inne Vanderkelen
% --------------------------------------------------------------------

% clean up
clc;
clear all;
close all;

tic

% --------------------------------------------------------------------
% initialisation
% --------------------------------------------------------------------


% add matlab scripts directory to path
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\matlab\ncfiles'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\data\CN method'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\data\CORDEX_climamean'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\data\CORDEX_evaluation'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\scripts\CORDEX_vars'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\matlab\shpfiles'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Thesis\matlab_scripts'));
addpath(genpath('C:\Users\Inne\Documents\MATLAB\Add-Ons\Toolboxes'));


% initialise run :  # 1 : observation run       (1993-2014)
%                   # 2 : CORDEX evaluation run (1999-2008)
%                   # 3 : CORDEX historical run (1950-2005)
%                   # 4 : CORDEX RCP 26 run     (2005-2100)
%                   # 5 : CORDEX RCP 45 run     (2005-2100)
%                   # 6 : CORDEX RCP 85 run     (2005-2100)

flag_run =1;

% initialise type run: #1 : full run (calculate all terms from .nc files)
%                      #2 : load saved WB terms
%                      #3 : load bias corrected WB terms
flag_type = 2; 

% initialise wether model runs: #1 : WB model runs
%                               #2 : L and Qout are loaded from files
% !!! Now option 2 only possible for PFT linear transformation !!!  
flag_model = 1; 

% initialise bias correction type: #1 : QUANT (empirical quantiles)
%                                  #2 : PFT linear(parametric transformation
%                                  #3 : PFT power.x0 (parametric transformation)
%                                  #4 : PFT expasympt.x0(parametric transformation
%                                  #5 : PFT scale (parametric transformation
%                                  #6 : SSPLIN (smoothing splines)
%                                  #7 : PFT expasympt(parametric transformation
%                                  #8 : PFT power (parametric transformation)
flag_bc = 1; 

% initialise outflow scenario: #1: constant outflow
%                              #2: constant lake level
%                              #3: according to Agreed Curve
flag_outscen =3; 

% time bounds
def_timebounds; 

% initialise physical constants
inicon

% initialise Lake Victoria boundaries
lat_min_Vict = -3.1;
lat_max_Vict = 0.6;
lon_min_Vict = 31.4;
lon_max_Vict = 35;
bounds_Vict  = [lat_min_Vict; lat_max_Vict; lon_min_Vict; lon_max_Vict];

% define number of grid points to be cropped on each side
nc = 0;

% define size of a grid point (grid resolution)
res_grid = 0.065;        % pixel length [°]
res_m = res_grid*c_earth/360;  % pixel length [m]
A_cell = res_m^2; % pixel area

% initialise model parameters

EraInt = {'ECMWF-ERAINT'};

% if flag_type == 3
    if flag_run == 2 % evaluation
        RCM(:,1) =  [{'CCLM4-8-17_'}; {'CRCM5_'} ;  {'HIRHAM5_'} ; {'RACMO22T_'} ;{'RCA4_'}; {'REMO2009_'}];
        
    elseif flag_run == 3 % historical
    RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'HIRHAM5_'} ;  {'CRCM5_'}     ; {'CRCM5_'} ;  {'RACMO22T_'}; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}         ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'} ; {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
    GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ; {'EC-EARTH'} ;  {'MPI-ESM-LR'} ; {'CanESM2'};  {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ; {'EC-EARTH'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];

    RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};  {'HIRHAM5 '};  {'CRCM5 '}     ; {'CRCM5 '}  ; {'RACMO22T '}; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}         ; {'REMO2009 '}  ; {'REMO2009 '}  ; {'REMO2009 '} ; {'REMO2009 '} ; {'REMO2009 '}  ; {'REMO2009 '}];

    elseif flag_run == 4 % rcp 2.6
    RCM(:,1) = [ {'RACMO22T_'} ; {'RCA4_'}  ; {'RCA4_'}      ; {'RCA4_'}   ;  {'RCA4_'}     ; {'RCA4_'}     ; {'REMO2009_'}  ; {'REMO2009_'}   ;  {'REMO2009 '}; {'REMO2009_'} ; {'REMO2009_'}  ; {'REMO2009_'}];
    GCM(:,1) = [ {'HadGEM2-ES'}; {'MIROC5'} ; {'HadGEM2-ES'} ; {'EC-EARTH'};  {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'}  ; {'EC-EARTH'}  ; {'CM5A-LR'}   ; {'GFDL-ESM2G'} ;  {'MIROC5'}  ];
    RCM_text(:,1) = [ {'RACMO22T '} ; {'RCA4 '}  ; {'RCA4 '}      ; {'RCA4 '}   ;  {'RCA4 '}     ; {'RCA4 '}     ; {'REMO2009 '}  ; {'REMO2009 '};{'REMO2009 '}; {'REMO2009 '} ; {'REMO2009 '} ; {'REMO2009 '}];

    elseif flag_run == 5 % rcp 45
    RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};  {'HIRHAM5_'} ; {'RACMO22T_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'} ];
    GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;  {'EC-EARTH'} ;  {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ];
    
    RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};  {'HIRHAM5 '} ; {'RACMO22T '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '} ];

    elseif flag_run == 6 %  rcp 85
    RCM(:,1) = [{'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'}; {'CCLM4-8-17_'};   {'HIRHAM5_'} ; {'RACMO22T_'} ;  {'RCA4_'}  ; {'RCA4_'}  ; {'RCA4_'}   ; {'RCA4_'}   ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'} ; {'RCA4_'}     ; {'RCA4_'}     ; {'RCA4_'}        ; {'REMO2009_'}  ; {'REMO2009_'}  ; {'REMO2009_'}  ];
    GCM(:,1) = [{'CNRM-CM5'}   ; {'EC-EARTH'}   ; {'HadGEM2-ES'} ; {'MPI-ESM-LR'} ;   {'EC-EARTH'} ; {'HadGEM2-ES'};  {'CanESM2'}; {'CM5A-MR'}; {'CNRM-CM5'}; {'EC-EARTH'}; {'GFDL-ESM2M'}; {'HadGEM2-ES'}; {'MIROC5'}; {'MPI-ESM-LR'}; {'NorESM1-M'} ; {'CSIRO-Mk3-6-0'}; {'MPI-ESM-LR'} ; {'EC-EARTH'}   ; {'CM5A-LR'}    ];
    RCM_text(:,1) = [{'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '};   {'HIRHAM5 '} ; {'RACMO22T '} ;  {'RCA4 '}  ; {'RCA4 '}  ; {'RCA4 '}   ; {'RCA4 '}   ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '} ; {'RCA4 '}     ; {'RCA4 '}     ; {'RCA4 '}        ; {'REMO2009 '}  ; {'REMO2009 '}  ; {'REMO2009 '}  ];

    
    end
    
    RCM_all(:,1)= [{'CCLM4-8-17'}; {'CRCM5'} ;  {'HIRHAM5'} ; {'RACMO22T'}; {'RCA4'} ; {'REMO2009'}];

% else
%     RCM = [{'CRCM5_'}     ; {'CRCM5_'} ];
%     GCM = [{'MPI-ESM-LR'}   ; {'CanESM2'}]; 
% % end

if flag_run == 1
    nm = 1;    
else
    nm = length(RCM); % number of models
     nRCMs = length(unique(RCM));
end

% --------------------------------------------------------------------
% load general data (Lake Vict boundaries, obs, lake levels, ...)
% --------------------------------------------------------------------

load_data

% --------------------------------------------------------------------
% manipulate general data
% --------------------------------------------------------------------

 manipulations

% --------------------------------------------------------------------
% Load WB terms and calculate the water balance 
% --------------------------------------------------------------------

if flag_type == 1  % calculate all WB terms
    
    if flag_run == 1
        
        load_var_obs; 
        calcWBterms_obs; 
        
    elseif flag_run == 2
        
        nm = 6; 
        load_cdxeval; 
        calcWBterms_cdxeval;

    elseif flag_run == 3  || flag_run == 4 || flag_run == 5 || flag_run == 6 
        
            calc_WBterms_cdx; 
    end

elseif flag_type == 2 % use calculated WB terms
    
    load_WBterms; 

elseif flag_type == 3 % load bias corrected WB terms
    
    load_bcWBterms; 

end 


if flag_model ==1
    WBmodel;    
else
    load_L_Qout;
end
toc

% --------------------------------------------------------------------
% Plot
% --------------------------------------------------------------------

plotting