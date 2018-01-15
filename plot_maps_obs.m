% -----------------------------------------------------------------------
% Script to plot maps of observed Precipitation, evaporation and inflow
% ------------------------------------------------------------------------
figure()



%% PRECIPITATION
ax1 = subplot(1,3,1);

years = min(date_obs(:,1)):max(date_obs(:,1));
for t = 1:length(years)
    [~, ind_year(t)] = ismember(years(t),date_obs(:,1)); 
end

for t = 1:(length(years)-1)
   for i = 1:nx
        for j = 1:nx
            P_yearsum(i,j,t) = nansum(P(i,j,(ind_year(t):(ind_year(t+1)-1))),3); 
        end
   end
end 

for i = 1:nx
   for j = 1:nx
            P_ysummean(i,j) = nanmean(P_yearsum(i,j,:))*10^3; 
   end
end

% Plotscript

% set colormaps
colormaps.prec = mf_colormap_cpt('es skywalker 01',12); 
caxes.prec = [0      3000];
colormaps.prec(1,:) = [1 1 1];

% plot spatial distribution
mf_plot_lake_subplot(lon_P, lat_P, P_ysummean, caxes.prec, colormaps.prec,res_grid,'Annual precipitation','mm/year',0,ax1,'a)'); 



%% EVAPORATION
ax2 = subplot(1,3,2);
load lat_cut
load lon_cut
load E_lake_cut
% calculate index where a new year starts
years = min(date_obs(:,1)):max(date_obs(:,1));
for t = 1:length(years)
    [~, ind_year(t)] = ismember(years(t),date_obs(:,1)); 
end

for t = 1:(length(years)-1)
   for i = 1:size(lat_cut,1)
        for j = 1:size(lon_cut,2)
            E_yearsum(i,j,t) = nansum(E_lake_cut(i,j,(ind_year(t):(ind_year(t+1)-1))),3); 
        end
   end
end 

for i = 1:size(lat_cut,1)
   for j = 1:size(lon_cut,2)
            E_ysummean(i,j) = nanmean(E_yearsum(i,j,:))*10^3; 
   end
end

% circshift
E_ysummean_shift = circshift(E_ysummean,-1); 

%Plotscript

% set colormaps
colormaps.evap = mf_colormap_cpt('Oranges_09',9); 
colormaps.evap(2:10,:) = colormaps.evap(1:9,:); 
colormaps.evap(1,:) = [1 1 1]; 
caxes.evap = [0      2000 ];


% plot spatial distribution
mf_plot_lake_subplot(lon_cut, lat_cut, E_ysummean_shift, caxes.evap, colormaps.evap,res_grid,'Annual evaporation','mm/year',1,ax2,'b)') 


%% make map of mean yearly runoff
ax3 = subplot(1,3,3);


%Q_percell = Q.*A_cell; 



for t = 1:(length(years)-1)
   for i = 1:nx
        for j = 1:nx
            Q_yearsum(i,j,t) = nansum(Q(i,j,(ind_year(t):(ind_year(t+1)-1))),3); 
        end
   end
end 

for i = 1:nx
   for j = 1:nx
            Q_ysummean(i,j) = nanmean(Q_yearsum(i,j,:)); 
   end
end

% Plotscript

% set colormaps
colormaps.Q_temp = mf_colormap_cpt('Greens 08',8);
colormaps.Q = colormaps.Q_temp(2:8,:); 
colormaps.Q(1,:) = [1 1 1 ];
% white = colormaps.Q(2,:); 
% colormaps.Q(1,:) = white; 
% colormaps.Q(2,:) = [0.9 0.9 0.9]; 
caxes.Q = [5     8.5 ];

% plot spatial distribution
mf_plot_CN(lon_P, lat_P,log10(Q_ysummean*10^3)+5, caxes.Q, colormaps.Q,res_grid,'Annual runoff','mm/year',3,ax3,'c)'); 




