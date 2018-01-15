% ------------------------------------------------------------------------
% Plot all water balance terms
% ------------------------------------------------------------------------
close all

% Calculate input and output in terms of lake level
Qin_lake = Qin_wb_obs./A_lake; 
Qout_lake= Qout./A_lake;


%% Seasonal series

% calculate yearmean of daily percip
for t = 1:ndays    
    P_dmean(t)= nanmean(nanmean(P_lake(:,:,t))); 
end
% calculate mean precipitation per day of each year
for i = 1:length(month_day)
   P_seas(i) = nanmean(P_dmean((find(ind_day==i)))); 
end

% calculate yearmean of daily evap
for t = 1:ndays    
    E_dmean(t)= nanmean(nanmean(E_lake(:,:,t))); 
end
% calculate mean evaporation per day of each year
for i = 1:length(month_day)
   E_seas(i)= nanmean(E_dmean((find(ind_day==i)))); 
end

% calculate mean inflow per day of each year
for i = 1:length(month_day)
   Qin_lake_seas(i) = nanmean(Qin_lake((find(ind_day==i)))); 
end

% calculate mean outflow per day of each year
for i = 1:length(month_day)
   Qout_lake_seas(i) = nanmean(Qout_lake((find(ind_day==i)))); 
end

% calculate mean difference per day of each year (anomaly resulting lak
for i = 1:length(month_day)
 WB_diff(i) = P_seas(i)-E_seas(i)+Qin_lake_seas(i)-Qout_lake_seas(i);
end

% give negative sign to evaporation and outflow
E_seas = -E_seas; 
Qout_lake_seas = -Qout_lake_seas;


%% Plot seasonal cycle

figure()
ax1=axes('color','none','Ytick',[])
ax2=axes;
plot((P_seas+Qin_lake_seas).*10^3, 'linewidth', 2, 'color', P_color)
hold on
plot((E_seas+Qout_lake_seas).*10^3,'linewidth', 2, 'color', E_color)
plot((Qin_lake_seas).*10^3,'linewidth', 2, 'color', Qin_color)
plot((Qout_lake_seas).*10^3,'linewidth', 2, 'color', Qout_color)
%plot(WB_diff.*10^3,'linewidth', 1.5, 'color', L_color)
plot(get(gca,'xlim'), [0 0], 'color', axcolor); % plot zero line
hold off
xlim([1 366])
ylim([-13 13])
legend('Precipitation', 'Evaporation','Inflow', 'Outflow')
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location','southeast');
%title('Seasonal terms of the water balance','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('lake level equivalent (mm)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca,'XTick',ind_firstmonth,'XtickLabel',[])
set(ax1,'Xlim',get(ax2,'Xlim'),'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label );
grid on

if flag_save ==1
saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\WBtermsseas.png')
end

%% Plot time series


% calculate total precipitation over the lake 
P_dcumsum(1) = nanmean(nanmean(P_lake(:,:,1))); 
for t = 2:ndays    
    P_dsum(t)= nanmean(nanmean(P_lake(:,:,t))); 
    if (isnan(P_dsum(t)))P_dsum(t) = 0; end
    P_dcumsum(t) = P_dcumsum(t-1)+P_dsum(t); 
end

% calculate total evaporation over the lake 
E_dcumsum(1)= nanmean(nanmean(E_lake(:,:,1)));
for t = 2:ndays    
    E_dsum(t)= nanmean(nanmean(E_lake(:,:,t)));
    E_dcumsum(t) = E_dcumsum(t-1)+E_dsum(t); 
end

% calculate total inflow in the lake 
Qin_dcumsum(1)= Qin_lake(1);
for t = 2:ndays    
    Qin_dsum(t)= Qin_lake(t);
    Qin_dcumsum(t) = Qin_dcumsum(t-1)+Qin_dsum(t); 
end

% calculate total evaporation over the lake 
Qout_dcumsum(1)= Qout_lake(1);
for t = 2:ndays    
    Qout_dsum(t)= Qout_lake(t);
    Qout_dcumsum(t) = Qout_dcumsum(t-1)+Qout_dsum(t); 
end

% make evaporation and outflow negative
E_dcumsum = -E_dcumsum; 
Qout_dcumsum = -Qout_dcumsum; 

L_anom = P_dcumsum+E_dcumsum+Qin_dcumsum + Qout_dcumsum; 

% Calculate percentages of total in- or output
% P_pr = (mean(P_seas)/(mean(P_seas)+mean(Qin_lake_seas)))*100
% Qin_pr = (mean(Qin_lake_seas)/(mean(P_seas)+mean(Qin_lake_seas)))*100 
% Qout_pr = (mean(Qout_lake_seas)/(mean(E_seas)+mean(Qout_lake_seas)))*100 
% E_pr = (mean(E_seas)/(mean(E_seas)+mean(Qout_lake_seas)))*100


%% PLOT
figure1 = figure(); 

P_color_ar = [144 184 215]/255; 
E_color_ar = [242 115 60]/255; 
Qout_color_ar =  [253 210 68]/255; 
Qin_color_ar =  [83 199 79]/255; 
L_color_ar =  [110 37 37]/255;
%L_color_ar =  [30 30 30]/255;

area(P_dcumsum, 'linewidth', 1.5, 'EdgeColor', P_color,'FaceColor', P_color_ar)
hold on
area(E_dcumsum,'linewidth', 1.5, 'EdgeColor', E_color,'FaceColor', E_color_ar)
area(Qin_dcumsum,'linewidth', 1.5, 'EdgeColor', Qin_color,'FaceColor', Qin_color_ar)
area(Qout_dcumsum,'linewidth', 1.5, 'EdgeColor', Qout_color,'FaceColor', Qout_color_ar)
plot(L_anom,'linewidth', 1.5, 'Color', L_color)


plot(get(gca,'xlim'), [0 0], 'color', axcolor); % plot zero line
hold off
%legend('Precipitation', 'Evaporation','Inflow', 'Outflow','Lakelevel')
xlim([1 length(date_obs)])
%set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location','northwest');
%title('Cumulative terms of the water balance and resulting lake level','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('lake level equivalent (m)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc_short],'xticklabel',labels_short,'xticklabelrotation',45); 
grid on

createdoublearrow(figure1,P_color,E_color,Qin_color,Qout_color); 
createWBnames(figure1,[0.2 0.2 0.2]); 
createprecentages(figure1,axcolor); 
