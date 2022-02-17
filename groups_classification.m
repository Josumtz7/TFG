function [groups] = groups_classification(num_valid_chann,groups)

% This function will be used to classify the diferent groups accordign to
% the needs detected. The collection of data was obtained in some groups,
% this can be a way of classifying, anyway they can be classified with
% other logics.

    % CSC1 – CSC2: cortex frontal (reference) / cortex frontal (reference)
    % CSC3 – 4: median septum (MS) / MS
    % CSC5: thalamus
    % CSC6: cingular cortex
    % CSC7: supramammillary nucleus (SuM)
    % CSC8 – CSC 11: Hippocampus (Dentate Gyrus (DG), CA1, CA1, CA3) 
    % CSC12: Subiculum
    % CSC13: Ventral hippocampus (vHPC)
    % CSC14- CSC15: Entorhinal cortex (EC) / EC or Perirhinal cortex (PRC)

    % Input: 
    %        - num_valid_chann: matrix with the real valid channels nuber
    %        - groups: a matrix with ones and the size of valid channels
    % Output:
    %        - groups: the input matrix has been changed so that the groups
    %        of the different parts of the brain can be separated for
    %        further analysis
    
    for i = 1:length(num_valid_chann)
        if num_valid_chann(1,i) == 3 || num_valid_chann(1,i) == 4
            groups(i,1) = 2;
        elseif num_valid_chann(1,i) <= 11 && num_valid_chann(1,i) >= 8
            groups(i,1) = 3;
        elseif num_valid_chann(1,i) == 14 || num_valid_chann(1,i) == 15
            groups(i,1) = 4;
        end
    end
end