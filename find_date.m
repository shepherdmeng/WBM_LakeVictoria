% ------------------------------------------------------------------------
% Function that returns the location of a date in another date dataset
% ------------------------------------------------------------------------

function [ind] = find_date(date_searchfor, date_findin)

    [isdate, date_loc] = ismember(date_findin,date_searchfor,'rows');
    ind = min((find(date_loc>0))); 
end