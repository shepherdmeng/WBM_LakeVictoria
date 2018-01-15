% Script to plot seasonnal modelled and observed lake level
close all 
% Calculate seasonal means of modelled and observed lake levels. 

% extract leap day out of month_day % nl = no leap (location = 60)
month_day_nl = zeros(365,2); 
month_day_nl(1:59,:)=month_day(1:59,:); 
month_day_nl(60:length(month_day)-1,:)= month_day(61:length(month_day),:); 

% calculate mean obs lake level per day of each year
for i = 1:length(month_day)
   L_mod_seas(i) = nanmean(L_obs((find(ind_day==i)))); 
end
L_mod_seas(60) = (L_mod_seas(59)+L_mod_seas(61))/2;

% calculate mean obs lake level per day of each year
for i = 1:length(month_day)
   L_obs_seas(i) = nanmean(lakelevel((find(ind_day==i)))); 
end

mean_L_obs = mean(L_obs_seas); 
mean_L_mod = mean(L_mod_seas); 

figure()
ax1=axes('color','none','Ytick',[])
ax2=axes;
plot(L_obs_seas-mean_L_obs, 'linewidth', 2,'color',colorobs)
hold on
plot(L_mod_seas-mean_L_mod,'linewidth', 2,'color',colormod)
plot(xlim, [0 0],'k')
hold off
xlim([1 366])
ylim([-0.25 0.25])
ind_Y = 1134.5:0.1:1135;
legend('Observed lake level','Modelled lake level')
set(legend,'Fontweight', 'Bold', 'Fontsize', 14, 'TextColor', axcolor);
%title('Seasonal cycle of observed and modelled lake level','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
ylabel('Lake level change (m day^-^1 a.s.l.)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
%set(gca,'YTick',ind_Y,'XtickLabel',[])
set(gca,'XTick',ind_firstmonth,'XtickLabel',[])
set(ax1,'Xlim',get(ax2,'Xlim'),'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label );
grid on



 
