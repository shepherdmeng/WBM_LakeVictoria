% ------------------------------------------------------------------------
% Function to extract lakelevels following a defines period by vector date
% (3 rows: year, month, day)
% ------------------------------------------------------------------------

function lakelevel_out = get_lakelevel(date, date_all, lakelevel_in)
    
    ind_min = find_date(date,date_all); 

    [~, date_locmax] = ismember(date,date_all,'rows');
    ind_max= max(date_locmax);

    lakelevel_out = lakelevel_in(ind_min:ind_max); 


end