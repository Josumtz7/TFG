%In case you want to work with only one epoch folder use this file, control
%situation
clear
clc
close all
pwd =  'D:\Erasmus\TFG\Neuralynx\Classe A_TLE_Before'; %Write here the place you have downloaded the epoch folders
%Detection of files and names
folderpwd = folderselection(pwd);
validchann = zeros(1,15);
%delete 'CSC11_169806023_223259735.ncs' its the only channel which is not
%valid (from epoch sn1)
DetectNcs = dir('*.ncs');
myfolder = pwd;
FilenameCell = {DetectNcs.name}';

% Delete the Channel 4 which is not correctly recorded as seeing it by
% plotting

YNCHan4 = contains(FilenameCell,'CSC4'); 
PosChan4 = find(YNCHan4,1); 
for i=PosChan4:length(FilenameCell)-1
    FilenameCell{i} = FilenameCell{i+1};
end
DetectNcs(PosChan4) = [];
FilenameCell = FilenameCell((1:i),:);

%To delete the empty cells
for k = length(FilenameCell)+1:1:15
DetectNcs(k).name = [];
end

[ChannelNum, FinalFilenames] = loaddata(FilenameCell);
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
            validchann(1,i) = 1;
            [downsepoch] = downsampling(epoch, SampleFrequencies);
        end
        j = j+1;
    end

    if validchann(1,i) == 1  %to create a matrix with only valid channels
        ts(:,t) = downsepoch(:,i);  
        t = t+1;
    end
    if i == length(FinalFilenames) && rst == 1
        rst = 2;
        i = 1;
    end

    NonValid(1,i) = any(NumberOfValidSamples < 512);

    if  NonValid(1,i) == 1 %to check if there are non valid channels
            Less512(i,:) = find(NumberOfValidSamples == 0);
            % Only in epoch sn1 and after the 4th second, non meaningful
    end
end

% complete downsepoch matrix until a lengtht of 15 (total channels)
for l = size(downsepoch,2)+1:1:length(ChannelNum)
    downsepoch(:,l) = 0;
end
 % -------------> in case we want to plot paste here the code of the
  % file plotting.m and change where it puts genr (put 1 instead)

figure()
heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings');

num_valid_chann = nonzeros(ChannelNum)';
[mean_aggroupation, validgroups] = first_aggroupation(num_valid_chann, downsepoch);
second_aggroupation = groups_classification(validgroups,mean_aggroupation);

%Applying PCA to reduce the size of the final matrix to 4 groups
[regions , explained_cort, explained_hippo] = pca_regions(second_aggroupation);

%To select the most meaningful recording to do the PCA
a = [explained_hippo(1,1),explained_cort(1,1)];
%The selection has been done with the criteria of the average of each
%explained value
b = mean(a); 
 
for i = 1:size(regions,2) 
    title('4 regions');
    xlabel('Samples');
    ylabel('Amplitude (mV)')
    plot(regions(:,i)); 
    hold on; 

end
% maxsize = 4;
% groups = ones(length(mean_aggroupation),1);
% [Otot, O_tot_value] = hoi_exhaustive_loop_zerolag_fdr(mean_aggroupation,maxsize,20,1,myfolder,groups);

%This function changes the channel numbers to the real ones:
% Otot = real_channel(maxsize, Otot, num_valid_chann); 
% figure
% plot(regions,'DisplayName','regions'); xlim([0 length(downsepoch)]);