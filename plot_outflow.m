% ------------------------------------------------------------------------
% Plot outflow
%-------------------------------------------------------------------------

%% Plot continous outflow data
figure()
plot(outflow*10^(-6),'linewidth', 2)
xlim([1 length(date_all)])
title('Outflow','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor);
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Outflow (10^6 m³)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
grid on


%% Plot all different sources for whole period
figure()
plot(outflow_sut_all*10^(-6),'linewidth', 2)
hold on
plot(outflow_dh*10^(-6),'linewidth', 2)
plot(outflow_graph*10^(-6),'linewidth', 2)
plot(outflow_ESKOM*10^(-6),'linewidth', 2)
plot(outflow_low*10^(-6),'linewidth', 2)
hold off
xlim([1 length(date_all)])
ylim([25 155])
title('Outflow form different data sources','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
legend('Monthly measurements','Calculated with Agreed Curve',...
    'Digitised from graph', 'Daily measurements','Constant at last measurement')
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor, 'Location', 'southeast');
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Outflow (10^6 m³)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
grid on

%% Plot Sutcliffe data and Calculated Agreed Curve outflow
date_spec = [1997 12 31]; 
[~, end_plot] = ismember(date_spec,date_all,'rows'); 
figure()
plot(outflow_sut_all*10^(-6),'linewidth', 2)
hold on
plot(outflow_AC*10^(-6),'linewidth', 1.5)
hold off
xlim([1 end_plot])
title('Measured and calculated outflow','Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
legend('Measured outflow', 'Calculated outflow with Agreed Curve')
set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location', 'southeast');
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'xtick',[year_loc],'xticklabel',labels,'xticklabelrotation',45); 
ylabel('Outflow (10^6 m³)','Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
grid on

