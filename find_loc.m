function loc = find_loc(date,date_obs)
[~,loc] = ismember(date,date_obs,'rows');
end