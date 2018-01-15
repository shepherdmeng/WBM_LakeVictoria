% --------------------------------------------------------------------
% Subroutine to perform manipulations on loaded variables
% --------------------------------------------------------------------

% create date vectors for whole period
date_vec  = datevec(datenum(time_begin ):1:datenum(time_end ));
date = date_vec(:,1:3);
ndays = length(date);

% get lake pixel indices
shp_Vict = struct2cell(shp_Vict);
xv_lake = shp_Vict{3,3};
yv_lake = shp_Vict{4,3};
% find coordinates of grid (not possible through netcdf file)
define_grid; 
islake = inpolygon(lon,lat, xv_lake,yv_lake); 
% create lake mask
mask_lake = zeros(size(islake))+1;
mask_lake(find(islake==0)) = NaN;

% get Lake Victoria BASIN pixel indices 
shp_basin = struct2cell(shp_basin);
xv_basin = shp_basin{3,1};
yv_basin = shp_basin{4,1};

% find coordinates of grid (not possible through netcdf file)
isbasin = inpolygon(lon,lat,xv_basin,yv_basin); 
isbasin(find(islake==1))=0; 
% create basin mask
mask_basin = zeros(size(isbasin))+1;
mask_basin(find(isbasin==0)) = NaN; 
mask_basin(find(islake==1))= NaN; 

mask_lakebasin = zeros(size(isbasin))+1;
mask_lakebasin(find(isbasin==0&islake==0)) = NaN; 
% Calculate lake surface
A_lake = res_m^2*sum(islake(:)); 
%A_lake = 68800*10^6;  %[m²]

% manipulations of LAKE BATHYMETRY
%-------------------------------------------------------------------------

% Interpolate bathymetry to own grid
[depth, lat_intp, lon_intp] = remap2owngrid(depth_CCLM, lat_CCLM, lon_CCLM); 

% Extract lake Victoria (define mask based on interpolated grid)
islake_intp = inpolygon(lon_intp,lat_intp,xv_lake,yv_lake); 
mask_lake_intp = zeros(size(islake_intp))+1;
mask_lake_intp(find(islake_intp==0)) = NaN;

depth = depth.*mask_lake_intp;

% Calculate reference bathymetry (in m above sea)
% (based on mean of DAHITI lake levels and depth from GLBD (out CCLM
% model))
%bathym_ref = lakelevel_ref-depth; 

% Location Owen falls dam on grid and corresponding lake level + depth
dam_ind = [37, 117]; % check again if correct!!
dam_depth =depth(dam_ind);


% manipulate observed lakelevels
% --------------------------------------------------------------------

manip_lakelevel


% manipulate outflow
% ---------------------------------------------------------------------

% manip_outflow

load outflow.mat % timesaving!


if flag_run <=3
    % Extract outflow series needed for model setup (date)
    [isdate_date, date_loc_date] = ismember(date_all,date,'rows'); 
    ind_min_Qout = min((find(date_loc_date>0))); 
    ind_max_Qout = max((find(date_loc_date>0))); 

    Qout = outflow(ind_min_Qout:ind_max_Qout); 
    
    % from 2006 to 2014 following Agreed Curve
        date_2004 = [2004, 1, 1]; 
     ind_2004 = find_date(date_2004,date); 
    date_2005 = [2005, 12, 31]; 
     ind_2005 = find_date(date_2005,date); 
     load Qout_ac
% 
     Qout(ind_2004:ind_2005) = Qout_ac(ind_2006:length(date));
     Qout_tot = sum(Qout_ac(ind_2004:ind_2005))

   Qout_tot = sum(Qout(ind_2004:ind_2005))
% define value in case of constant outflow
elseif flag_outscen == 1 
    Qout = NaN(1,ndays); 
     
    % last known outflow  (2006 outflow) 
    outflow_last = outflow(length(outflow)); 

    % mean level before Kigali dam construction
    date_2000 = [2000 1 1]; 
    date_2006 = [2006 1 1]; 
    date_1954 = [1954 1 1] ; 
    [~,loc_1954] = ismember(date_1954,date_all, 'rows'); 
    [~,loc_2000] = ismember(date_2000,date_all, 'rows'); 
    [~,loc_2006] = ismember(date_2006,date_all, 'rows'); 

    outflow_dam = mean(outflow(loc_1954:loc_2000));
    outflow_00to06 = mean(outflow(loc_2000:loc_2006)); 
    % mean of total outflow
    outflow_totmean = mean(outflow); 
    
    % calculate mean annual outflow 
    time_begin_outflow  = [1950, 1, 1, 0,0,0]; 
    time_end_outflow   = [2014,12,31,23,0,0];
    date_vec_outflow= datevec(datenum(time_begin_outflow):1:datenum(time_end_outflow));
    date_outflow = date_vec_outflow(:,1:3);
    years = 1954:2006;

    for t = 1:length(years)
        [~, ind_year(t)] = ismember(years(t),date_outflow(:,1)); 
    end


    for t = 1:(length(years)-1)
       outflow_yearmean(t) = nanmean(outflow((ind_year(t):(ind_year(t+1)-1))));    
    end 
    
    outflow_min = min(outflow_yearmean)
    outflow_max = max(outflow_yearmean)
    
    year_min = years(find(outflow_yearmean==min(outflow_yearmean)));
    year_max = years(find(outflow_yearmean==max(outflow_yearmean)));

    % choose which constant outflow 
    Qout(1,:) =  outflow_max; 
else
    Qout = 0; % % exact values are calculated in WB model
end

% manipulations on run variables
%-------------------------------------------------------------------------

if flag_run == 1     % Observation run
       
    % manip_obsdata;
      
end