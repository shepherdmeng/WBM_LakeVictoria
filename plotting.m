% ------------------------------------------------------------------------
% Subroutine to plot different variables
% ------------------------------------------------------------------------

%% initialise

% define flags

flag_save = 0; 
flag_precip = 0; 
flag_evap = 0; 
flag_CN = 0; 
flag_lakelevel = 0;
flag_total_lakelevel = 0; 
flag_outflow = 0; 
flag_WBterms = 0; 

% initialise
axcolor = [0.3 0.3 0.3];
colors = mf_colors;
colors(24:25,:)= rand(2,3); 


% define ticks and ticklabels for one year
months_label = ['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];
months = (1:12).'; 
first_day = ones(length(months),1); 
first_daymonth=[months first_day]; 
[~,ind_firstmonth] = ismember(first_daymonth,month_day,'rows');

mid_day = ones(length(months),1).*15; 
mid_daymonth=[months mid_day]; 
[~,ind_midmonth] = ismember(mid_daymonth,month_day,'rows');


% find the indices of the year array for every day in the whole period
[isday,ind_day] = ismember(date_obs(:,2:3),month_day,'rows'); 

% define periods
% 1950-2014
temp_allyears = date_all(:,1); 
yearlong = time_begin_hist:2:time_end_obs; 
[~, year_loc] = ismember(yearlong,temp_allyears);
labels = {'1950','1952','1954','1956','1958','1960','1962','1964','1966','1968',...
    '1970', '1972','1974', '1976','1978','1980','1982','1984','1986','1988',...
    '1990', '1992','1994','1996','1998','2000', '2002','2004','2006','2008',...
    '2010','2012','2014'};


% 1992-2014
temp_obsyears = date_obs(:,1); 
years = time_begin_obs:time_end_obs; 
[~, year_loc_short] = ismember(years,temp_obsyears);
labels_short = {'1993','1994','1995','1996','1997','1998','1999','2000', ...
'2001','2002','2003','2004','2005','2006','2007','2008','2009','2010',...
'2011','2012','2013','2014'};


% define plotting colors for different terms
E_color = colors(16,:); 
P_color = colors(17,:); 
Qin_color = [5 137 1]/255;
Qout_color = [192  147 0]/255; 
L_color =  [95 14 14]/255;
%L_color =  [30 30 30]/255;

% 2006-2100
temp_futyears = date_fut(:,1); 
yearfut = time_begin_fut-1:5:time_end_fut+1; 
yearfut(1) = time_begin_fut(1); 
[~, year_loc_fut] = ismember(yearfut,temp_futyears);
%year_loc_fut(length(yearfut)) = year_loc_fut(length(yearfut)-1) + (year_loc_fut(3)- year_loc_fut(2)); 
labels_fut = {'2006','2010','2015','2020','2025','2030','2035','2040',...
    '2045','2050','2055','2060','2065','2070','2075','2080','2085',...
    '2090','2095','2100'};


%% plotting


% plot precip 
if flag_precip==1
plot_precip;
end


% plot evap
if flag_evap ==1
plot_evap; 
end


% plot CN
if flag_CN ==1
plot_CN; 
end


% plot lakelevel
plot_lakelevel; 



% plot outflow
if flag_outflow ==1
plot_outflow; 
end


% plot WBterms
if flag_WBterms ==1
plot_WBterms; 
end

