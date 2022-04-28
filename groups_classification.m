function aggroupation = groups_classification(validgroups, mean_aggroupation)

% This function is used to classify definetly the four diferent groups according to
% the needs detected. After having done the average between the first classification 
% groups in the first_aggroupation.m % In this last version different regions of the rats brain 
% have been separated according to the location.
    % Cortex group: 
        % Group 1: CSC1 – CSC2: cortex frontal (reference) / cortex frontal (reference)
        % Group 2: CSC3 – 4: median septum (MS) / MS
        % Group 4: CSC6: cingular cortex
        % Group 9: CSC14- CSC15: Entorhinal cortex (EC) / EC or Perirhinal cortex (PRC)
    % Thalamus group:
        % Group 4: CSC5: thalamus
    % Supramammillary nucleus group
        % Group 5: CSC7: supramammillary nucleus (SuM)
    % Hippocampus group
        % Group 6: CSC8 – CSC 11: Hippocampus (Dentate Gyrus (DG), CA1, CA1, CA3) 
        % Group 7: CSC12: Subiculum
        % Group 8: CSC13: Ventral hippocampus (vHPC)
    

    % Input: 
    %        - validgroups: matrix with the valid groups n
    %        - mean_aggroupation: matrix after the first aggroupation with
    %        mean values of each group
    % Output:
    %        - aggroupation: a struct matrix with the diferent physiological
    %        groups, helps also to identify the correct channels in each
    %        group

    aggroupation = struct('cortex', [], 'cortex_num', [],'thalamus', [], 'thalamus_num', [], 'hippocampus', [], 'hippocampus_num', [], 'supram_nucleus',[], 'supram_nucleus_num',[]);
    i_cort = 1; i_thal = 1; i_hippo = 1; i_supram = 1;

    for i = 1:1:length(validgroups)  
        if validgroups(1,i) ~= 0 && (i == 1 || i == 2 || i == 4 || i == 9) 
            aggroupation.cortex(:,i_cort) = mean_aggroupation(:,i); 
            aggroupation.cortex_num(1,i_cort) = i;
            i_cort = i_cort + 1; 
        elseif i == 3
            aggroupation.thalamus(:,i_thal) = mean_aggroupation(:,i);
            aggroupation.thalamus_num(1,i_thal) = i;
        elseif validgroups(1,i) ~= 0 && (i == 6 || i == 7 || i == 8)  
            aggroupation.hippocampus(:,i_hippo) = mean_aggroupation(:,i); 
            aggroupation.hippocampus_num(1,i_hippo) = i;
            i_hippo = i_hippo + 1; 
        elseif i == 5 
            aggroupation.supram_nucleus(:,i_supram) = mean_aggroupation(:,i);
            aggroupation.supram_nucleus_num(1,i_supram) = i;
        end
    end

end