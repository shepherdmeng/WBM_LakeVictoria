% -----------------------------------------------------------------------
% Script to plot different components of inflow and CN method 
% ------------------------------------------------------------------------
figure()

%% plot land cover classes

ax1 = subplot(1,3,1);

% set colormaps
colormaps.landcover_in= mf_colormap_cpt('Set2 08',8); 
colormaps.landcover_in = flipud(colormaps.landcover_in); 

 
cropland = colormaps.landcover_in(3,:); 
grassland = colormaps.landcover_in(4,:);
forest = [76 153 0]./255; 
mosaic = colormaps.landcover_in(5,:); 
cities = colormaps.landcover_in(7,:); 
bare = [160 160 160]./255;
shrubland = colormaps.landcover_in(2,:); 

colormaps.landcover(1,:)  = forest;
colormaps.landcover(2,:)  = shrubland;
colormaps.landcover(3,:)  = grassland;
colormaps.landcover(4,:)  = cropland;
colormaps.landcover(5,:)  = mosaic;
colormaps.landcover(6,:)  = bare;
colormaps.landcover(7,:)  = cities;
colormaps.landcover(8,:)  = P_color;
caxes.landcover = [1     8 ];


% plot spatial distribution
mf_plot_CN(lon_P, lat_P,land_cover, caxes.landcover, colormaps.landcover,res_grid,'Land Cover',' ',2,ax1,'a)'); 

% if flag_save==1
% % save
% saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\landcover_map.png')
% end

%% plot hydrologic soil classes
ax2 = subplot(1,3,2);

colormaps.soil = mf_colormap_cpt('Accent 04',4); 
green = colormaps.soil(1,:); 
purple = colormaps.soil(2,:); 
colormaps.soil(1,:) = colormaps.soil(4,:); 
colormaps.soil(4,:) = purple; 
colormaps.soil(2,:)= green; 
colormaps.soil(2:5,:) = colormaps.soil; 
colormaps.soil(1,:) = P_color; 
caxes.soil = [0      5 ];

% plot spatial distribution
mf_plot_CN(lon_P, lat_P,soil_type, caxes.soil,colormaps.soil,res_grid,'Hydrologic soil classes','Classes', 1,ax2,'b)'); 

% if flag_save==1
% saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\Soil_classes.png')
% end



%% plot CN values
ax3 = subplot(1,3,3);

% prepare CN to plot
CN(find(islake==1))=0; 

% set colormaps
colormaps.CN = mf_colormap_cpt('summer',8); 
colormaps.CN(1:7,:) = colormaps.CN(2:8,:);
colormaps.CN(8,:)  = P_color;

caxes.CN = [0      100 ];


% plot spatial distribution
mf_plot_CN(lon_P, lat_P,CN, caxes.CN, flipud(colormaps.CN),res_grid,'Curve Number','CN value',0,ax3,'c)'); 

% save
% if flag_save==1
% saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\CN_map.png')
% end

%% make map of mean yearly runoff
ax4 = subplot(2,2,4);


%Q_percell = Q.*A_cell; 
years = min(date(:,1)):max(date(:,1));
[~, ind_year] = ismember(years,date(:,1)); 


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
mf_plot_CN(lon_P, lat_P,log10(Q_ysummean*10^3)+5, caxes.Q, colormaps.Q,res_grid,'Annual runoff','mm/year',3,ax4,'d)');