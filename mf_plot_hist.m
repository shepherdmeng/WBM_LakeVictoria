% ------------------------------------------------------------------------
% Function to plot a histogram
% -----------------------------------------------------------------------

function mf_plot_hist(var,color,mytitle,xlab,xlimits,axcolor,binwidth,alpha)

histogram(var,'FaceColor',color,'Normalization','probability','BinWidth',binwidth,'FaceAlpha',alpha)
title(mytitle,'Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor) 
xlabel(xlab,'Fontsize', 10, 'Fontweight', 'Bold', 'color', axcolor)
ylabel('Normalised frequency','Fontsize', 10, 'Fontweight', 'Bold', 'color', axcolor)
xlim(xlimits)
grid on

end