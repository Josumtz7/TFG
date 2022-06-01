%In case you want to work with only one epoch folder of the 7 days after 
%seizure

clear
clc
close all
pwd = 'D:\Erasmus\TFG\Neuralynx\Classe C_TLE 7j\1h avt test'; %Write here the place you have downloaded the epoch folders

%Detection of files and names
folderpwd = folderselection_4j(pwd);
validchann = zeros(1,15);
DetectNcs = dir('*.ncs');
myfolder = pwd;
FilenameCell = {DetectNcs.name}';

%To delete the empty cells
for k = length(FilenameCell)+1:1:15
DetectNcs(k).name = [];
end

%Function to load data
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
    end
end

% complete downsepoch matrix until a lengtht of 15 (total channels)
for l = size(downsepoch,2)+1:1:length(ChannelNum)
    downsepoch(:,l) = 0;
end
% figure()
% heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings');

num_valid_chann = nonzeros(ChannelNum)';
[mean_aggroupation, validgroups] = first_aggroupation(num_valid_chann, downsepoch);

%In case you want to do the second aggrupation (only the 4 regions):
second_aggroupation = groups_classification(validgroups,mean_aggroupation);

%Applying PCA to reduce the size of the final matrix to 4 groups
[regions , explained_cort, explained_hippo] = pca_regions(second_aggroupation);

%To compute O-information toolbox 
% maxsize = 4;
% groups = ones(t-1,1);
% [Otot, O_tot_value] = hoi_exhaustive_loop_zerolag_fdr(ts,maxsize,20,1,myfolder,groups);

