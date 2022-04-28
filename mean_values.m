function [mean1,mean2] = mean_values(downsepoch, ChannelNum, validchann)

    % This function will be used to choose and select if necessary the best
    % option to fill in the gaps of the missing values.

    % Input:
    %         - downsepoch: matrix with all the downsampled epoch (3596x15)
    %         - ChannelNum: matrix with the number of the valid channels
    %         - validchann: matrix saying if each channel is valid or not
    % Output: 
    %         - mean1: mean with adjoining channels
    %         - mean2: mean taking into account the groups

    % - CSC1 – CSC2: cortex frontal (reference) / cortex frontal (reference)
    % -	CSC3 – 4: median septum (MS) / MS
    % -	CSC5: thalamus
    % -	CSC6: cingular cortex
    % -	CSC7: supramammillary nucleus (SuM)
    % -	CSC8 – CSC 11: Hippocampus (Dentate Gyrus (DG), CA1, CA1, CA3) 
    % -	CSC12: Subiculum
    % -	CSC13: Ventral hippocampus (vHPC)
    % -	CSC14- CSC15: Entorhinal cortex (EC) / EC or Perirhinal cortex (PRC) 


    mean1 = zeros(length(downsepoch),15);
    mean2 = zeros(length(downsepoch),15);
    
    
    % This first mean strategy has been done with the adjoinning channels
    for i = 1:1:length(ChannelNum)
        if i ~= 1 && i ~= length(ChannelNum) 
            if validchann(1,i) == 0 && validchann(1,i-1) == 1 && validchann(1,i+1) == 1
                lateral_doub = ([downsepoch(:,i-1), downsepoch(:,i+1)]);
                med = mean(lateral_doub,2);
                mean1(:,i) = med;
            elseif validchann(1,i) == 0 && validchann(1,i-1) == 0 && validchann(1,i-2) == 1 && validchann(1,i+1) == 1
                lateral_doub = ([downsepoch(:,i-2), downsepoch(:,i+1)]);
                med = mean(lateral_doub,2);
                mean1(:,i) = med;
            elseif validchann(1,i) == 0 && validchann(1,i-1) == 1 && validchann(1,i+2) == 1 && validchann(1,i+1) == 0
                lateral_doub = ([downsepoch(:,i-1), downsepoch(:,i+2)]);
                med = mean(lateral_doub,2);
                mean1(:,i) = med;
            end
        elseif i == length(ChannelNum)
            lateral_doub = ([downsepoch(:,1), downsepoch(:,i-1)]); 
            med = mean(lateral_doub,2);
            mean1(:,i) = med;  
        end  
        while mean1(1,i) == 0
            mean1(:,i) = downsepoch(:,i);
        end
    end
    
    % This part groups the channels from 8 to 11 as they are part of the
    % hippocampus and have relation between them. Here we should implement
    % another technique, some values are still missing.
    k = 1;
    for i = 1:1:length(ChannelNum)
        if i > 7 && i < 12 && validchann(1,i) ~= 0    
            globmed(:,k) = downsepoch(:,i);
            k = k + 1;       
        end      
    end
    avalue = mean(globmed,2); 
    for i = 1:1:length(ChannelNum)
        if i > 7 && i < 12 && validchann(1,i) == 0    
            mean2(:,i) = avalue;
        elseif mean2(1,i) == 0
            mean2(:,i) = downsepoch(:,i);
        end
    end    
end
% Plotting all the channels to see if there have been well defined

% ts = mean2;
% figure()
%  NonZerosChan = nonzeros(ChannelNum);
%  [M,N] = size(ts);
%  if N < 13
%     for i=1:N
%         subplot(3,4,i);
%         plot(ts(:,i));
%         xlim([0 M]);
%         title(strcat('Channel:', num2str(i)));
%         xlabel('Samples');
%         ylabel('Amplitude')
%     end
%  elseif N >= 13
%      for i=1:N
%          subplot(3,5,i)
%          plot(ts(:,i))
%          xlim([0 M]);
%          title(strcat('Channel:',num2str(i)));
%          xlabel('Samples');
%          ylabel('Amplitude')
%      end
%  end
% figure
% plot(ts(:,(3:5)),'DisplayName','ts'); xlim([0 length(downsepoch)])