
% --------------------------------------------------------------------
% function to plot data on Lake Victoria
% Input: 
%   - lon, lat
%   - var
%   - caxis_dom
%   - colormap_dom
%   - res
% flag_evap (=1: plot evaporation colorbar without lowest value)
% ax: subplot object (defined as an ax itself)
% --------------------------------------------------------------------


function [] = mf_plot_lake(lon,lat,var,caxis_dom,colormap_dom,res,title,cbcaption,flag_evap,ax,panel)

lat_min_dom = -5; 
lat_max_dom = 1.7;
lon_min_dom = 29;
lon_max_dom = 36.3;

% design figure
%figure; 

set(gcf, 'color', 'w');
set(gca,'color','w');

% initialise grid and projection
m_proj('Mercator','long',[lon_min_dom lon_max_dom],'lat',[lat_min_dom lat_max_dom]);  % generate lambert projection
m_grid('box','on','tickdir','in','color',[0, 0, 0], ...
    'Fontweight', 'Bold','FontSize',11, 'linewidth',1.5,'ytick', [0 -2 -4],'xtick',[30 32 34 36]); hold on; % draw grid with normal box


% plot data
g = m_pcolor(lon - res/2,lat + res/2,var);  % with shading flat will draw a panel between the (i,j),(i+1,j),(i+1,j+1),(i,j+1) coordinates of the lon/lat matrices with a color corresponding to the data value at (i,j).
set(g, 'edgecolor', 'none');   % remove black grid around pixels 
set(gca, 'Fontsize', 14, 'Fontweight', 'Bold');  % set axes properties
caxis(caxis_dom); % set colorscale axes
colormap(ax,colormap_dom); % mf_freezeColors;    



% plot colorbar
cbh = colorbar(ax,'Fontsize', 14, 'Fontweight', 'Bold'); hold on;     
%cbfreeze(colormap); mf_freezeColors;
%m_ruler([0.56 1],0.09,4,'tickdir','out','FontSize',8); 
hold on;

if flag_evap == 1
    set(cbh, 'ylim', [400 2000]);
    set(cbh,'ytick',[400:400:2000]); 

end

% plot lake border
%m_usercoast('fc_dom','color','k'); hold on;  
% m_gshhs('fc','color','k'); hold on; m_gshhs('fc','save','fc_dom'); 

Lake = m_shaperead('vic_shape');  % load lake borders
for k=1:length(Lake.ncst), 
  m_line(Lake.ncst{k}(:,1),Lake.ncst{k}(:,2), 'color', 'k'); hold on;                                       % plot country borders
end;

Basin = m_shaperead('Watsub');
for k=1:length(Basin.ncst), 
  m_line(Basin.ncst{k}(:,1),Basin.ncst{k}(:,2), 'color', 'k'); hold on;                                       % plot country borders
end;


m_ruler([0.64 0.90],0.09,'FontSize',8);


% add text
m_text(lon_min_dom+3.75, lat_max_dom+0.1, title,'ver','bottom','hor','center', 'Fontweight', 'Bold', 'Fontsize', 14); hold on;
m_text(lon_max_dom+3.2,-1.5,cbcaption,'ver','bottom','hor','center', 'Fontweight', 'Bold', 'Fontsize', 12,'rotation',-90);
m_text(lon_min_dom+0.35, lat_max_dom-0.6, panel,'ver','bottom','hor','center', 'Fontsize', 12); hold on;

hold off
end


