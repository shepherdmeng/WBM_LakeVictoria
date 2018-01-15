% --------------------------------------------------------------------
% Define timebounds for different runs
% based on flags:
%               # 1 : observation run       (1993-2014)
%               # 2 : CORDEX evaluation run (1990-2008)
%               # 3 : CORDEX historical run (1950-2005)
%               # 4 : CORDEX RCP 26 run     (2005-2100)
%               # 5 : CORDEX RCP 45 run     (2005-2100)
%               # 6 : CORDEX RCP 85 run     (2005-2100)
% -------------------------------------------------------------------

if flag_run == 1
   time_begin  = [1993, 1, 1, 0,0,0];
   time_end    = [2014,12,31,23,0,0];
elseif flag_run == 2
    if flag_type == 3 % bias corrected 
        time_begin  = [1993, 1, 1, 0,0,0];
        time_end    = [2008,12,31,23,0,0];
    else
        time_begin  = [1990, 1, 1, 0,0,0];
        time_end    = [2008,12,31,23,0,0];
    end
elseif flag_run == 3
   time_begin  = [1950, 1, 1, 0,0,0];
   time_end    = [2004,12,31,23,0,0];
elseif flag_run == 4 || flag_run == 5 || flag_run == 6
   time_begin  = [2006, 1, 1, 0,0,0];
   time_end    = [2100,12,31,23,0,0]; 
end


% ------------------------------------------------------------------------
% Save timebounds to use in lake level and outflow manipulations
% ------------------------------------------------------------------------

% Observations
time_begin_obs  = [1993, 1, 1, 0,0,0]; % datum van eerste dahiti data beschikb
time_end_obs    = [2014,12,31,23,0,0];

date_vec_obs= datevec(datenum(time_begin_obs ):1:datenum(time_end_obs ));
date_obs = date_vec_obs(:,1:3); 

% Evaluation
time_begin_ev  = [1990, 1, 1, 0,0,0]; 
time_end_ev    = [2008,12,31,23,0,0];

date_vec_ev= datevec(datenum(time_begin_ev ):1:datenum(time_end_ev ));
date_ev = date_vec_ev(:,1:3);

% Bias corrected
time_begin_bc  = [1993, 1, 1, 0,0,0]; % datum van eerste dahiti data beschikb
time_end_bc    = [2008,12,31,23,0,0];

date_vec_bc= datevec(datenum(time_begin_bc ):1:datenum(time_end_bc ));
date_bc= date_vec_bc(:,1:3); 

% Historical
time_begin_hist  = [1950, 1, 1, 0,0,0]; 
time_end_hist   = [2004,12,31,23,0,0];

date_vec_hist= datevec(datenum(time_begin_hist):1:datenum(time_end_hist));
date_hist = date_vec_hist(:,1:3);

% Future
   time_begin_fut  = [2006, 1, 1, 0,0,0];
   time_end_fut    = [2100,12,31,23,0,0];  

date_vec_fut= datevec(datenum(time_begin_fut):1:datenum(time_end_fut));
date_fut = date_vec_fut(:,1:3);

% define one (leap) year
year_begin  = [2016, 1, 1, 0,0,0]; % 2016 is leap year
year_end    = [2016,12,31,23,0,0];
year_vec  = datevec(datenum(year_begin):1:datenum(year_end));
month_day = year_vec(:,2:3);
leap_ind = 60; 

date_vec= datevec(datenum(time_begin):1:datenum(time_end));
