% ------------------------------------------------------------------------
% Subroutine to manipulate the lakelevel data (DAHITI and HYDROMET data)
% Result: 
%           a. HYDROMET
%               - lakelevel_hm (hydromet lakelevels from 1948-1996)
%           b. DAHITI: 
%              - lakelevel_dh     (DAHITI lake levels over obs period
%           c. Complete lakelevel series (lakelevel_all from 1950-2014)
%           d. Extract lakelevels for wanted data period (lakelevel)
% ------------------------------------------------------------------------

% find the indices of the year array for every day in the whole period
[isday,ind_day] = ismember(date(:,2:3),month_day,'rows'); 

% ------------------------------------------------------------------------
% b. DAHITI

% calculate reference lake level from DAHITI (mean lake level)
% lakelevel_ref = mean(dh_lakelevel);

%  make series on whole period of DAHITI lake levels 
% (Nan if no value on the day)
[isdate, date_loc] = ismember(date_dh,date_obs,'rows');
lakelevel_abs = nan(ndays,1);

for i = 1:length(date_dh)
    if date_loc(i)>0
    lakelevel_abs(date_loc(i)) = dh_lakelevel(i);
    lakelevel_err(date_loc(i)) = dh_lakelevel_err(i);
    end
end

%lakelevel_dh_anom = lakelevel_abs-lakelevel_ref; 

% make linear interpolation for DAHITI lake level
x = date_loc(date_loc>0);
Y=dh_lakelevel(date_loc>0); 
xi = 1:1:length(date_obs);
lakelevel_dh= (interp1(x,Y,xi,'spline','extrap')).';
%lakelevel_anom = lakelevel_dh - lakelevel_ref; 



% ------------------------------------------------------------------------
% a. HYDROMET: data from 1948-2014

% define timeperiod hydromet data
time_begin_hm  = [1948, 1, 1, 0,0,0]; 
time_end_hm   = [1996,8,1,23,0,0];
date_vec_hm = datevec(datenum(time_begin_hm ):1:datenum(time_end_hm ));
date_hm = date_vec_hm(:,1:3);

% fill missing gaps in lakelevel_hm
lakelevel_hm_raw(find(lakelevel_hm_raw==0))=NaN;

clear x_ll_hm x_nan y_nan

x_ll_hm = 1:1:length(lakelevel_hm_raw);
x_nan=x_ll_hm(find(~isnan(lakelevel_hm_raw)));
y_nan=lakelevel_hm_raw(find(~isnan(lakelevel_hm_raw)));

lakelevel_hm=(interp1(x_nan,y_nan,x_ll_hm,'linear')).';


% correct for difference
difference= lakelevel_dh(1:(length(lakelevel_hm)-find_date(date_obs,date_hm)+1))-...
    (lakelevel_hm(find_date(date_obs,date_hm):length(lakelevel_hm))); 
mean_diff = nanmean(difference);
lakelevel_hm = lakelevel_hm+mean_diff;
lakelevel_hm_raw = lakelevel_hm_raw+mean_diff;
% ------------------------------------------------------------------------
% c. Complete lake level series 

% merge DAHITI and HYDROMET to complete lake level series (full data span)
% -> possible to extract from this data
date_vec_all= datevec(datenum(time_begin_hist):1:datenum(time_end_obs));
date_all = date_vec_all(:,1:3);

% find max index of hydromet in complete series
[~, date_locmax_hm] = ismember(date_all,date_hm,'rows');
ind_max_hm = max(date_locmax_hm); 

% initialise
lakelevel_all = NaN(length(date_all),1); 

% insert HYDROMET data
lakelevel_all(find_date(date_hm,date_all):ind_max_hm) = ...
    lakelevel_hm; 

% overwrite with DAHITI data
lakelevel_all(find_date(date_obs,date_all):length(date_all))= lakelevel_dh; 

% ------------------------------------------------------------------------
% d. Extract lakelevels for wanted data period
lakelevel=get_lakelevel(date,date_all,lakelevel_all); 
lakelevel_ref = mean(lakelevel); 
