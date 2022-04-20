function agroupation = groups_classification(num_valid_chann,ts)

% This function is used to classify the diferent groups according to
% the needs detected. In this last version different regions of the rats brain 
% have been separated according to the location.
    % Cortex group: 
        % CSC1 – CSC2: cortex frontal (reference) / cortex frontal (reference)
        % CSC3 – 4: median septum (MS) / MS
        % CSC6: cingular cortex
        % CSC14- CSC15: Entorhinal cortex (EC) / EC or Perirhinal cortex (PRC)
    % Thalamus group:
        % CSC5: thalamus
    % Supramammillary nucleus group
        % CSC7: supramammillary nucleus (SuM)
    % Hippocampus group
        % CSC8 – CSC 11: Hippocampus (Dentate Gyrus (DG), CA1, CA1, CA3) 
        % CSC12: Subiculum
        % CSC13: Ventral hippocampus (vHPC)
    

    % Input: 
    %        - num_valid_chann: matrix with the real valid channels number
    %        - ts: matrix with only the valid values of the channels
    % Output:
    %        - agroupation: a struct matrix with the diferent physiological
    %        groups, helps also to identify the correct channels in each
    %        group

    agroupation = struct('cortex', [], 'cortex_num', [],'thalamus', [], 'thalamus_num', [], 'hippocampus', [], 'hippocampus_num', [], 'supram_nucleus',[], 'supram_nucleus_num',[]);
    i_cort = 1; i_thal = 1; i_hippo = 1; i_supram = 1;
    for i = 1:length(num_valid_chann)    
        if num_valid_chann(1,i) <= 4 || num_valid_chann(1,i) == 6 || num_valid_chann(1,i) > 13
            agroupation.cortex(:,i_cort) = ts(:,i); 
            agroupation.cortex_num(1,i_cort) = num_valid_chann(1,i);
            i_cort = i_cort + 1; 
        elseif num_valid_chann(1,i) == 5
            agroupation.thalamus(:,i_thal) = ts(:,i);
            agroupation.thalamus_num(1,i_thal) = num_valid_chann(1,i);
        elseif num_valid_chann(1,i) > 7 && num_valid_chann(1,i) < 14
            agroupation.hippocampus(:,i_hippo) = ts(:,i); 
            agroupation.hippocampus_num(1,i_hippo) = num_valid_chann(1,i);
            i_hippo = i_hippo + 1; 
        else 
            agroupation.supram_nucleus(:,i_supram) = ts(:,i);
            agroupation.supram_nucleus_num(1,i_supram) = num_valid_chann(1,i);
        end
    end
end