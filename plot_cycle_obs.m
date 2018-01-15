% -----------------------------------------------------------------------
% Script to plot annual cycles of observed Precipitation, evaporation and inflow
% ------------------------------------------------------------------------
% initialise
axcolor = [0.3 0.3 0.3];
colors = mf_colors;

% define ticks and ticklabels
months_label = ['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];
months_label_short = ['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'];
months = (1:12).'; 
mid_day = ones(length(months),1);%.*15; 
mid_daymonth=[months mid_day]; 

[~,ind_midmonth] = ismember(mid_daymonth,month_day,'rows');

figure1 = figure(); 
%% Precipitation
subplot(1,3,1)

% calculate yearmean of daily percip
for t = 1:length(date_obs)  
    P_dmean(t)= nanmean(nanmean(P_lake(:,:,t))); 
end

% calculate mean precipitation per day of each year
for i = 1:length(month_day)
   P_dmeanmean(i) = nanmean(P_dmean((find(ind_day==i)))); 
end

plot(P_dmeanmean*10^3, 'linewidth', 2, 'color', P_color)
xlim([1 366])
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
%title('Daily mean lake precipitation','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('Precipitation  [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca,'XTick',ind_firstmonth,'XtickLabel',[],'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label_short )

grid on


%% Evaporation
subplot(1,3,2)

% calculate yearmean of daily evap
for t = 1:length(date_obs) 
    E_dmean(t)= nanmean(nanmean(E_lake(:,:,t))); 
end


% calculate mean evaporation per day of each year
for i = 1:length(month_day)
   E_dmeanmean(i) = nanmean(E_dmean((find(ind_day==i)))); 
end

plot(E_dmeanmean*10^3, 'linewidth', 2, 'color', E_color)
xlim([1 366])
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
%title('Daily mean lake evaporation','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('Evaporation  [mm/day]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca,'XTick',ind_firstmonth,'XtickLabel',[],'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label_short )
grid on


%% Inflow 
subplot(1,3,3)

for i = 1:length(month_day)
   Qin_mean(i) = nanmean(Qin_wb_obs((find(ind_day==i)))); 
end

plot(Qin_mean*10^(-6), 'linewidth', 2, 'color', Qin_color)
xlim([1 366])
ylim([ 0 250])
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
%title('Daily mean inflow','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('Inflow  [10^6 m³]','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca,'XTick',ind_firstmonth,'XtickLabel',[],'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label_short );
grid on

%% 
createpanelnr(figure1,axcolor)