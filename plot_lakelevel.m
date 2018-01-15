% ------------------------------------------------------------------------
% Plot lakelevel
%-------------------------------------------------------------------------
colorobs = [36 60 74]/255; 
colormod = [255 119 60]/255; 
if flag_lakelevel == 1
    % plot modelled and observed lakelevels over observation period
    % Plotting on DAHITI period (from 1992 onwards)
    ind_min_hm = find_date(date_obs,date_hm); 
%%
    figure()
    plot(lakelevel,'linewidth', 2,'color',colorobs)
    hold on 
    plot(L_obs,'linewidth', 2,'color',colormod)
  %  plot(L_mod,'linewidth', 2)
    %plot(L_ac,'linewidth', 2)

    hold off
    xlim([1 length(date_obs)])
    ylim([1133.3 1136])
    legend('Observed lake level','Modelled lake level')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 14, 'TextColor', axcolor);
    %title('Modelled and observed lake level','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 13, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_short],'xticklabel',labels_short,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
    grid on

    if flag_save ==1
    saveas(gcf,'C:\Users\Inne\Documents\MATLAB\Thesis\plots in progress\lakelevel_modelled.png')
    end
elseif flag_total_lakelevel == 1

    %% plot DAHITI and HYDROMET lakelevel over whole period. 

    %  find position of dahiti in hydromet time series
    [isdate, date_loc_all] = ismember(date_all,date_obs,'rows');
    loc_min_dh = min((find(date_loc_all)));
    loc_dh = loc_min_dh:1:length(date_all);


    figure()
    plot(loc_dh,lakelevel_dh,'linewidth', 2)
    hold on
    plot(lakelevel_hm_raw(find_date(date_all,date_hm):ind_max_hm),'linewidth', 2)
    hold off
    xlim([1 length(date_all)])
    legend('DAHITI lake level','HYDROMET lake level')
    set(legend,'Fontweight', 'Bold', 'Fontsize', 16, 'TextColor', axcolor);
   % title('Lake level data','Fontsize', 35, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 16, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 16, 'Fontweight', 'Bold', 'color', axcolor)
    grid on


%%Plot difference DAHITI and modelled lake level
    figure()
    plot(lakelevel-(L_obs)','linewidth', 2)
    hold on
   plot(get(gca,'xlim'), [0 0], 'color', axcolor); % plot zero line
    hold off
    xlim([1 length(date_obs)])
    ylim([-0.6 0.6])
    set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
    title('Difference between DAHITI and modelled lake level','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
    set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
        'Ycolor', axcolor,'xtick',[year_loc_short],'xticklabel',labels_short,'xticklabelrotation',45); 
    ylabel('Lake level (m a.s.l.)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
    grid on
    
end