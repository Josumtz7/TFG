function [mean_aggroupation, validgroups] = first_aggroupation(num_valid_chann, downsepoch)
 % This function does the first aggroupation to lose the less possible
 % interactions. This is why average between channels of the same region of
 % the brain has been done. This is the classification:

    % Reference group:
        % CSC1 – CSC2: cortex frontal (reference) / cortex frontal (reference)
    % Median septum
        % CSC3 – CSC4: median septum (MS) / MS
    % Thalamus
        % CSC5: thalamus
    % Cingular cortex
        % CSC6: cingular cortex
    % Suprammamillary nucleus
        % CSC7: supramammillary nucleus (SuM)
    % Dorsal hippocampus
        % CSC8 – CSC 11: Dorsal hippocampus (Dentate Gyrus (DG), CA1, CA1, CA3) 
    % Subiculum
        % -	CSC12: Subiculum
    % Ventral hippocampus
        % -	CSC13: Ventral hippocampus (vHPC)
    % Entorhinal cortex
        % -	CSC14- CSC15: Entorhinal cortex (EC) / EC or Perirhinal cortex (PRC) 

    % Input :
        % - num_valid_chann: matrix with the number of only the valid
        %   channels
        % - downsepoch: downsampled matrix

    % Output :
        % - mean_aggroupation: matrix with the 9 subgroups and their mean
        % - validgroups: matrix to know if the average groups are
        %   empty/valid or not


    mean_aggroupation = zeros(length(downsepoch),9);
    i_ref = 1; i_med = 1; i_dor = 1; i_enth = 1; 
    for i = 1:1:length(num_valid_chann)
        if num_valid_chann(1,i) == 1 || num_valid_chann(1,i) == 2 % Reference group
            reference(:,i_ref) = downsepoch(:,num_valid_chann(1,i));
            i_ref = i_ref+1; 
        elseif num_valid_chann(1,i) == 3 || num_valid_chann(1,i) == 4 % Median septum
            median_septum(:,i_med) = downsepoch(:,num_valid_chann(1,i));
            i_med = i_med + 1;
        elseif num_valid_chann(1,i) >= 8 && num_valid_chann(1,i) <= 11 % Dorsal hippocampus
            dorsal_hipp(:,i_dor) = downsepoch(:,num_valid_chann(1,i));
            i_dor = i_dor + 1;         
        elseif num_valid_chann(1,i) == 14 || num_valid_chann(1,i) == 15 % Entorhinal cortex
            enthor_cortex(:,i_enth) = downsepoch(:,num_valid_chann(1,i));
            i_enth = i_enth + 1;  
        end
    end
    
    mean_aggroupation(:,1) = mean(reference,2); % Reference group
    mean_aggroupation(:,2) = mean(median_septum,2); %Median septum
    mean_aggroupation(:,3) = downsepoch(:,5); % Thalamus
    mean_aggroupation(:,4) = downsepoch(:,6); % Cingular cortex
    mean_aggroupation(:,5) = downsepoch(:,7); % Suprammamillary nucleus (SuM)
    mean_aggroupation(:,6) = mean(dorsal_hipp,2); % Dorsal hippocampus
    mean_aggroupation(:,7) = downsepoch(:,12); % Subiculum         
    mean_aggroupation(:,8) = downsepoch(:,13); % Ventral hippocampus
    mean_aggroupation(:,9) = mean(enthor_cortex,2); % Enthorinal cortex
    
    validgroups = ones(1,9);
    for i_mean = 1:1:size(mean_aggroupation,2)
        if mean_aggroupation(1,i_mean) == 0
        validgroups(1,i_mean) = 0;
        end
    end
end