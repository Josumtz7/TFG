% This file can be used in case we only want to analyse characteristics of
% all the epoch folders in one loop
clear
close
pwd = 'D:\Erasmus\TFG\Neuralynx\Classe A_TLE_Before'; %Write here the place you have downloaded the epoch folders
%Detection of files and names
folderpwd = folderselection(pwd);
validchann = zeros(length(folderpwd),15);
i_centi = 0; count_valid_record = 0; 

%initialize how many folders we have from each behaviour
nSniff_folder = 15;
nSleep_folder = 4; i_sleep = 1;
%delete 'CSC11_169806023_223259735.ncs' its the only channel which is not
%valid (from epoch sn1)
for genr = 1:length(folderpwd)
    name = folderpwd(genr,1);
    cd(name);
    DetectNcs = dir('*.ncs');
    myfolder = pwd;
    FilenameCell = {DetectNcs.name}';    
    [FilenameCell, DetectNcs] = delete4channel(genr, FilenameCell, DetectNcs);

    for iEmpty = length(FilenameCell)+1:1:15
        DetectNcs(iEmpty).name = [];
    end
    
    [ChannelNum, FinalFilenames] = loaddata(FilenameCell);
    folderNames(genr,1) = regexp(name,'epoch \d*.*','match');
    %Definition of data loading characteristics with predefined values
    %(recommendation of Neuralynx)
    FieldSelectionFlags = [1 1 1 1 1];
    HeaderExtractionFlag = 1;
    ExtractMode = 1;
    ExtractionModeVector = 1;
        
    rst = 1;
    t = 1;
    clear ts
    for i = 1:1:length(FinalFilenames)
        j = 1;
        centi = 0;
        while centi ~= 1 && j < 16
            CorrColumn = strcmp(FinalFilenames(i,1),DetectNcs(j).name);
            if CorrColumn == 1 
                centi = 1;
                Filename = convertStringsToChars(FinalFilenames(i,1)); 
                [Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(Filename, FieldSelectionFlags, HeaderExtractionFlag, ExtractMode, ExtractionModeVector);
                epoch(:,i) = create_epoch_table(Samples, SampleFrequencies);
                validchann(genr,i) = 1;
                [downsepoch] = downsampling(epoch, SampleFrequencies); 
            end
            j = j+1;
        end

        if i_centi == 0
            chann_concat = zeros(length(downsepoch)*length(folderpwd),size(validchann,2));
            i_centi = 1;
        end

        if validchann(genr,i) == 1  %to create a matrix with only valid channels
            ts(:,t) = downsepoch(:,i);  
            t = t+1;
            numvalidchan(genr,i) = i;
            min_concat = 1 + ((genr-1)*length(downsepoch)); 
            max_concat = min_concat + length(downsepoch) - 1;
            chann_concat((min_concat:max_concat),i) = downsepoch(:,i);             
        end
        
        if i == length(FinalFilenames) && rst == 1
            rst = 2;
            i = 1;
        end
        
    Less512 = NonValidSamples(NumberOfValidSamples,i);        
    end
    num_valid_chann = nonzeros(ChannelNum)';
    if genr <= nSniff_folder
        min_sniff = 1 + ((genr-1)*length(downsepoch)); 
        max_sniff = min_sniff + length(downsepoch) - 1;
        [mean_sniffing([min_sniff:max_sniff],:), valid_sn_groups(genr,:)] = first_aggroupation(num_valid_chann, downsepoch);
    else
        min_sleep = 1 + ((i_sleep-1)*length(downsepoch)); 
        max_sleep = min_sleep + length(downsepoch) - 1;
        [mean_sleeping([min_sleep:max_sleep],:), valid_sl_groups(genr,:)] = first_aggroupation(num_valid_chann, downsepoch);
        i_sleep = i_sleep +1;
    end
   
% -------------> in case we want to plot paste here the code of the
% file plotting.m

end
% groups = ones(length(ts),1); 
% [Otot, O_tot_value] = hoi_exhaustive_loop_zerolag_fdr(ts,4,20,1,myfolder,groups);

%%

valid_record = numvalidchan';
num_valid_record = sum(validchann)';
folder_dim = length(folderpwd);

% Concatenation of each channel in a single column
concat_channels = struct('cn1', chann_concat(:,1), 'cn2', chann_concat(:,2), 'cn3', chann_concat(:,3), 'cn4', chann_concat(:,4), 'cn5', chann_concat(:,5), 'cn6', chann_concat(:,6), 'cn7', chann_concat(:,7), 'cn8', chann_concat(:,8), 'cn9', chann_concat(:,9), 'cn10', chann_concat(:,10), 'cn11', chann_concat(:,11), 'cn12', chann_concat(:,12), 'cn13', chann_concat(:,13),'cn14', chann_concat(:,14), 'cn15', chann_concat(:,15));
% Separation of each channel for all the dataset
channel_concat = same_num_channel(downsepoch,chann_concat, folder_dim, num_valid_record);

figure(); heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings');title('Before seizure');


%% Internal functions

function [FilenameCell, DetectNcs] = delete4channel(genr, FilenameCell, DetectNcs)
% This function deletes the channel 4 for the folder epoch which have been wrongly recorded. 
% It has been proved visually by ploting
    if genr < 16
        YNCHan4 = contains(FilenameCell,'CSC4'); 
        PosChan4 = find(YNCHan4,1); 
        for i=PosChan4:length(FilenameCell)-1
            FilenameCell{i} = FilenameCell{i+1};
            
        end
        DetectNcs(PosChan4) = [];
        FilenameCell = FilenameCell((1:i),:);
    end

end

%This function sees if there is any missing value in each channel
function Less512 = NonValidSamples(NumberOfValidSamples,i) 

      NonValid(1,i) = any(NumberOfValidSamples < 512);
      if  NonValid(1,i) == 1 %to check if there are non valid channels
          Less512(i,:) = find(NumberOfValidSamples == 0);
      else
          Less512 = 0;
      end
end


