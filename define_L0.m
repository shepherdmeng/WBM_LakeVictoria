%-------------------------------------------------------------------------
% Script to define the beginning of the lake levels for future simulations
% ------------------------------------------------------------------------

load L_hist_lin_bc

L0_all = L_hist(:,length(L_hist)); 

id_rcp26 = [9,16,15,13,17,18,20,21,22,23,24,25];
id_rcp45 = [1,	2,	3,	4,	5,	8,	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,	19,	21,	22];
id_rcp85 = [1,2,3,	4,	5,	9,	10,	11,	12,	13,	14,	15,	16,	17,	18,19,	21,	22,	23];

for i = 1:nm
    if flag_run == 4
    L0_rcp26(i) = L0_all(id_rcp26(i),1);  
    elseif flag_run ==5
    L0_rcp45(i) = L0_all(id_rcp45(i),1);  

    elseif flag_run==6
    L0_rcp85(i) = L0_all(id_rcp85(i),1);  

    end
end