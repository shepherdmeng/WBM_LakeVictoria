% ------------------------------------------------------------------------
% Script to manipulate the different outflowdata
%   a. 1950-2000: use Agreed Curve relation
%   b. 2000-2005: graph
%   c. 2004-2006: ESKOM data
%   d. 2006-2014: ...? 
% 
% ------------------------------------------------------------------------

%% a. Agreed curve relation for whole data period 1950-2014
lakelevel_jinja = lakelevel_jinja_raw(find_date(date_all,date_hm):length(lakelevel_jinja_raw)); 
lakelevel_jinja(find(lakelevel_jinja_cut==0))=NaN;
x_ll_dam = 1:1:length(lakelevel_jinja_cut);

% x_nan_dam=x_ll_dam(find(~isnan(lakelevel_jinja_cut)));
% y_nan_dam=lakelevel_jinja_cut(find(~isnan(lakelevel_jinja_cut)));
% 
% lakelevel_jinja=interp1(x_nan_dam,y_nan_dam,x_ll_dam,'linear'); 

lakelevel_dam = NaN(length(date_all),1); 

ind_min = find_date(date_hist,date_all); 
[isdate, date_loc] = ismember(date_all,date_hm,'rows');
ind_max = max((find(date_loc>0))); 
lakelevel_dam = lakelevel_jinja(ind_min:ind_max);

% Calculate Qout [m³/day] according to the Agreed Curve
% (method used by Smith et al. (2014))

% define parameters (according to Sene, 2000)
a = 66.3;
b = 2.01;
c = 7.96;

% calculate outflow (agreed curve: in m³ per second)
outflow_AC = a.*(lakelevel_dam-c).^b; 
% convert to m³/day
outflow_AC = outflow_AC*3600*24;

%% Read in outflow data from Sutcliffe (units: 10^6 m³)

[year_sut, m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12 ] = textread('outflow_jinja_monthly.txt'); 
outflow_sut_months = [m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12]; 
% convert to m³
outflow_sut_months = outflow_sut_months.*10^6;

% convert data of Sutcliffe to model data period
year_month_all = date_all(:,1:2); 
outflow_sut_all = NaN(length(date_all),1);

for i = 1:length(year_month_all)
    [isdays, ind_ndays] = ismember(year_month_all,year_month_all(i,:),'rows'); 
    ndays_month(i) = sum(isdays~=0);
    
    if date_all(i,1)<=max(year_sut)
        ind_year = find(year_sut == date_all(i,1)); 
        ind_month = date_all(i,2); 
        outflow_sut_all(i) = outflow_sut_months(ind_year, ind_month)./ndays_month(i); 
    else
        ind_max_sut = i; 
        date_max_sut = date_all(ind_max_sut,:); 
    break
    end
end


%% b. graph 2000-2005

% Period 2: 2000-2005
[x_0005, y_0005] = textread('outflow_00-05.txt'); 

% convert to m³/day
y_0005 = y_0005*(3600*24); 

% define time period for graph
time_begin_graph = [2000, 1, 1, 0,0,0]; 
date_vec_graph= datevec(datenum(time_begin_graph ):1:datenum(time_end_hist));
date_graph = date_vec_graph(:,1:3);

difx_0005 = find(diff(x_0005)<= 0);
x_0005(difx_0005) = x_0005(difx_0005)+1E-10;
x_0005_days = 1:1:length(date_graph); 
outflow_0005 = interp1(x_0005,y_0005,x_0005_days,'spline'); 

% set x values of 2000-2005 period to right day number (day_all)
outflow_0005_all = NaN(length(date_all),1); 
ind_0005 = find_date(date_graph,date_all); 
outflow_0005_all(ind_0005:length(date_hist)) = outflow_0005; 


%%  ESKOM data 1/9/2004-5/3/2006

% define ESKOM time period
time_begin_ESKOM = [2004, 9, 1, 0,0,0]; 
time_end_ESKOM = [2006, 3, 5, 23,0,0]; 
date_vec_ESKOM= datevec(datenum(time_begin_ESKOM ):1:datenum(time_end_ESKOM));
date_ESKOM = date_vec_ESKOM(:,1:3);

% Read in ESKOM data (units: 10^6 m³)
[AC_ESKOM, outflow_ESKOM] = textread('outflow_04-06.txt'); 

% convert to m³
AC_ESKOM = AC_ESKOM*10^6; 
outflow_ESKOM = outflow_ESKOM*10^6; 

outflow_ESKOM_smoothed = smooth(outflow_ESKOM,30); 
% calculate monthly means of ESKOM data and give value per day. 
months_ESKOM =([ 9 10 11 12 1 2 3 4 5 6 7 8 9 10 11 12 1 2 3]).'; 
years_ESKOM = ([2004 2004 2004 2004 2005 2005 2005 2005 2005 2005 2005 2005 ...
2005 2005 2005 2005 2006 2006 2006]).'; 
months_years_ESKOM = [years_ESKOM months_ESKOM]; 

months_years_ESKOM_or = date_ESKOM(:,1:2); 
for i = 1:length(months_years_ESKOM)
    [~, loc_ESKOM] = ismember(months_years_ESKOM_or,months_years_ESKOM(i,:),'rows');
monmean_ESKOM(i) = nanmean(outflow_ESKOM(find(loc_ESKOM==1))); 
end

for i = 1:length(date_ESKOM)
    [~, loc_ESKOM_short] = ismember(months_years_ESKOM,months_years_ESKOM_or(i,:),'rows');

outflow_ESKOM_daymean(i) = monmean_ESKOM(find(loc_ESKOM_short==1)); 
end

% ESKOM outflow for the whole period
ind_ESKOMmin = find_date(date_ESKOM,date_all); 
ind_ESKOMmax = ind_ESKOMmin+length(date_ESKOM)-1; 
outflow_ESKOM_all = NaN(length(date_all),1); 
outflow_ESKOM_all(ind_ESKOMmin:ind_ESKOMmax )=...
    outflow_ESKOM_smoothed; 


% find position of ESKOM in historical period
outflow_ESKOM_0005 = NaN(length(date_graph),1); 
outflow_ESKOM_0005(ind_ESKOMmin:length(date_hist))=outflow_ESKOM_smoothed(1:find_date(time_end_hist(:,1:3),date_ESKOM)); 


%% % Agreed curve for DAHITI data (too fill data gap) 
datum = 1122.887; % from data
diff_abs_jinja = datum+mean_diff; 
save diff_abs_jinja.mat diff_abs_jinja
lakelevel_dh_jinja = lakelevel_dh -datum - mean_diff; 

% calculate outflow (agreed curve: in m³ per second)
outflow_AC_dh = a.*(lakelevel_dh_jinja-c).^b; 
% convert to m³/day
outflow_AC_dh = outflow_AC_dh*3600*24;

[isdate, date_loc1] = ismember(date_obs,date_hm,'rows');
ind_min_dh = max((find(date_loc1>0))); 
 [~,date_loc_sut] = ismember(date_max_sut,date_obs,'rows');
 ind_max_sut_obs = max(date_loc_sut); 
 
[isdate, date_loc2] = ismember(date_all,date_hm,'rows'); 
ind_min2_dh = max((find(date_loc2>0))); 
% ind_max_sut for outflow data Sutcliffe

[isdate3, date_loc3] = ismember(date_obs,date_graph,'rows'); 
ind_min3_dh = min((find(date_loc3>0))); 

% front part cut off (from 1992 to 1996)
outflow_AC_dh_cut = outflow_AC_dh(ind_min_dh:ind_min3_dh); 
outflow_AC_dh_cut_sut = outflow_AC_dh(ind_max_sut_obs:ind_min3_dh); 


outflow_AC_dh_all = NaN(length(date_all),1); 
outflow_AC_dh_all(ind_max_sut:ind_0005) = outflow_AC_dh_cut_sut; 

% Corresponding last point in Sutcliffe outflow and AC DAHITI outflow
[~, loc_first] = ismember(date_all(ind_max_sut-1,:),date_obs,'rows');

% series of outflow from 1950-2000


%% Make large series on outflow

% data Sutcliffe
outflow = outflow_sut_all; 

% AC dahiti
%outflow(ind_min2_dh:ind_min2_dh+length(outflow_AC_dh_cut)-1) = outflow_AC_dh_cut; 
outflow(ind_max_sut:ind_min2_dh+length(outflow_AC_dh_cut)-1) = outflow_AC_dh_cut_sut;
outflow_dh= NaN(length(date_all),1);
%outflow_dh(ind_min2_dh:ind_0005)=outflow_AC_dh_cut; 
outflow_dh(ind_max_sut:ind_0005)=outflow_AC_dh_cut_sut;
outflow_dh(ind_max_sut-1) = outflow_AC_dh(loc_first);  
outflow_dh(ind_max_sut-2) = outflow_AC_dh(loc_first-2);
outflow_dh(ind_max_sut-2) = outflow_AC_dh(loc_first-2);  
outflow_dh(ind_max_sut-3) = outflow_AC_dh(loc_first-3);  
outflow_dh(ind_max_sut-4) = outflow_AC_dh(loc_first-4);  
outflow_dh(ind_max_sut-5) = outflow_AC_dh(loc_first-5);  


% graph
outflow(ind_0005:length(date_hist)) = outflow_0005; 
outflow_graph = NaN(length(date_all),1); 
outflow_graph(ind_0005:ind_ESKOMmin) = outflow_0005_all(ind_0005:ind_ESKOMmin); 

% ESKOM
outflow(ind_ESKOMmin:ind_ESKOMmax )=...
    outflow_ESKOM_smoothed;
outflow_ESKOM = NaN(length(date_all),1); 
outflow_ESKOM(ind_ESKOMmin:ind_ESKOMmax)= outflow_ESKOM_smoothed;

% Last period: 2006-2014: mean of 2000 to 2006
mean_outflow_0006 = mean(outflow(ind_0005:ind_ESKOMmax)); 

outflow(ind_ESKOMmax:length(date_all)) = outflow(ind_ESKOMmax); 

% outflow(ind_ESKOMmax:length(date_all)) = mean_outflow_0006; 

outflow_low = NaN(length(date_all),1);  
outflow_low(ind_ESKOMmax:length(date_all)) = outflow(ind_ESKOMmax);
outflow_mean = NaN(length(date_all),1);  
outflow_mean(ind_ESKOMmax:length(date_all)) = mean_outflow_0006;

% save outflow time series
save outflow.mat outflow


% save outflow series