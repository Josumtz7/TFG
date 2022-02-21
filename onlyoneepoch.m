%In case you want to work with only one epoch folder use this file
clear 
close
pwd =  'D:\Erasmus\TFG\Neuralynx'; %Write here the place you have downloaded the epoch folders
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
heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings');

% This function is used to fill the missing values
[mean1,mean2] = mean_values(downsepoch, ChannelNum, validchann); 

groups = ones(t-1,1);
num_valid_chann = nonzeros(ChannelNum)';

% This function gives the option to clasiffy all the info before doing the
% O info analysis, uncomment the following line to implement it

% groups = groups_classification(num_valid_chann,groups);

% maxsize = 4;
% [Otot, O_tot_value] = hoi_exhaustive_loop_zerolag_fdr(ts,maxsize,20,1,myfolder,groups);
% Otot = real_channel(maxsize, Otot, num_valid_chann); %This function changes the channel numbers to the real ones

% plot(ts,'DisplayName','ts'); xlim([0 length(downsepoch)]);