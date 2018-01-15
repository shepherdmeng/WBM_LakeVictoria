% --------------------------------------------------------------------
% Subroutine to perform manipulations on observational variables
% --------------------------------------------------------------------


% manipulations on E of GLEAM
% % ------------------------------------------------------------------------
% E_gleam = flipud(E_gleam);
% % crop out right number of days 
% begin_E = length(E_gleam)-ndays; 
% % E_gleam = E_gleam(:,:,begin_E:length(E_gleam)); 
%   
%   for i = 1:size(E_gleam,3)
%     E_basin(:,:,i) = mask_basin.*E_gleam(:,:,i);
%   end
% 
%  % convert to right units (from mm/m²day to m/day)
%  E_basin = E_basin .* 10^(-3); 

% manipulations on P
% ------------------------------------------------------------------------
P = flipud(P); 
begin_p = length(P)-ndays; 
P = P(:,:,begin_p:length(P));
 
% convert to right units (from mm/m²day to m/m²day)

P = P .* 10^(-3);

   for i = 1:size(P,3)
   P_lake(:,:,i) = mask_lake.*P(:,:,i);
   P_basin(:,:,i) = mask_basin.*P(:,:,i);
   end
   
   
% manipulations on LHF of model
% ------------------------------------------------------------------------
% Based on montly mean LHF, determine value for every day

% interpolate on own grid
[Xq,Yq] = meshgrid(1:1:130); 

for i = 1:size(LHF_daymean,3)
  [LHF_intp(:,:,i), lat_intp, lon_intp] = ...
      remap2owngrid(LHF_daymean(:,:,i), lat_CCLM, lon_CCLM); 
end


% extract the days
for i = 1:length(date_obs)
   LHF(:,:,i) = LHF_intp(:,:,ind_day(i)); 
end

% % extract the months
% for i = 1:ndays
%     curr_day = date(i,2:3); 
%     LHF(:,:,i) = LHF_intp(:,:,curr_month);
% end

E = -LHF/Lvap * 3600 * 24; 
E = E*10^(-3);


for i = 1:size(E,3)
 E_lake(:,:,i) = mask_lake_intp.*E(:,:,i);
end

E_lake_cut = E_lake(1:length(lon_LHF_remap),1:length(lat_LHF_remap),:); 
% Manipulate model LHF to plot

% Cut LHF

LHF_cut = LHF_intp(1:101,1:81,:); 
lat_cut = lat_intp(1:101,1:81,:);
lon_cut = lon_intp(1:101,1:81,:);
mask_lake_cut = mask_lake_intp(1:101,1:81,:);

for i = 1:length(date_obs)
   LHF(:,:,i) = LHF_cut(:,:,ind_day(i)); 
end

E= -LHF/Lvap * 3600 * 24; 
E_cut = E*10^(-3);


for i = 1:size(E_cut,3)
 E_lake_cut(:,:,i) = mask_lake_cut.*E_cut(:,:,i);
end

