clear 

%Detection of files and names
DetectNcs = dir('*.ncs');
myfolder = pwd;
FilenameCell = {DetectNcs.name}';
[ChannelNum, FinalFilenames] = loaddata(FilenameCell);

for k = length(FilenameCell)+1:1:15
DetectNcs(k).name = [];
end

%Definition of data loading characteristics with predefined values
%(recommendation of Neuralynx)
FieldSelectionFlags = [1 1 1 1 1];
HeaderExtractionFlag = 1;
ExtractMode = 1;
ExtractionModeVector = 1;

validchann = zeros(1,15);
rst = 1;
t = 1;
for i = 1:1:length(FinalFilenames)
    j = 1;
    centi = 0;
    while centi ~= 1 && j < 16
        CorrColumn = strcmp(FinalFilenames(i,1),DetectNcs(j).name);
        %Need a correction, this is due to the lack of data in the 11 and
        %12 channel. Each epoch will have a different wrong channel so I
        %have to identify them in each folder. (epoch 1 && i ~= 11)
        if CorrColumn == 1 && i ~= 11
            centi = 1;
            Filename = convertStringsToChars(FinalFilenames(i,1)); 
            [Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = Nlx2MatCSC(Filename, FieldSelectionFlags, HeaderExtractionFlag, ExtractMode, ExtractionModeVector);
            epoch(:,i) = create_epoch_table(Samples, SampleFrequencies);
            validchann(1,i) = 1;         
            [downsepoch, posdown] = downsampling(epoch, SampleFrequencies);                  
        end
        j = j+1;
    end

    if validchann(1,i) == 1 %to create a matrix with only valid channels
        ts(:,t) = downsepoch(:,i);
        t = t+1;
    end

    if i == length(FinalFilenames) && rst == 1
        rst = 2;
        i = 1;
    end
