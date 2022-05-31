clear 
close
pwd = 'D:\Erasmus\TFG\Neuralynx\Classe B_TLE 4j\1h avt test';

topLevelFolder = pwd; 
files = dir(topLevelFolder);
strdir = convertCharsToStrings(topLevelFolder);
dirFlags = [files.isdir];
subFolders = files(dirFlags); 
subFolderNames = {subFolders(3:end).name};

j = 1;
%Find the folders called epoch
for i = 1:1:length(subFolderNames)
    if contains(subFolderNames(1,i),'epoch') == 1
        epochsubfoldername(j,1) = subFolderNames(1,i);
        j = j+1;
    end
end

% I have done an string matrix with all the directory location of the
% folders we want to analyse
i_sn = 1; i_vc = 1;
for i = 1:1:length(epochsubfoldername)
    folderpwd(i,1) = strcat(strdir, '\',epochsubfoldername(i,1));
    if contains(epochsubfoldername(i,1),'sn') == 1
       dirSn(i_sn,1) = folderpwd(i,1);
       snNum(1,i_sn) = extractBefore(dirSn(i_sn,1),'sn');
       snNum(1,i_sn) = extractAfter(snNum(1,i_sn),'epoch');
       i_sn = i_sn + 1;
    elseif contains(epochsubfoldername(i,1),'vc') == 1
       dirVc(i_vc,1) = folderpwd(i,1);
       vcNum(1,i_vc) = extractBefore(dirVc(i_vc,1),'vc');
       vcNum(1,i_vc) = extractAfter(vcNum(1,i_vc),'epoch');
       i_vc = i_vc +1;
    end  
    
end

%sPos = in which position of the directory is each sniffing folder
%vPos = in which position of the directory is each vc folder

[~, sPos] = sort(str2double(snNum)); 
[~, vPos] = sort(str2double(vcNum));

%To order the folder names, so that the graphs and loading data is
%ordered too

for i = 1:length(snNum)
    folder(i,1) = dirSn(sPos(1,i),1);
    if i == length(snNum)
        i_fin = i;
    end
end
for i = 1:length(vcNum) 
    folder(i+ i_fin,1) = dirVc(vPos(1,i),1);
end

folderpwd = folder;
validchann = zeros(length(folderpwd),15);
i_centi = 0; count_valid_record = 0;

for genr = 1:length(folderpwd)
    name = folderpwd(genr,1);
    cd(name);
    DetectNcs = dir('*.ncs');
    myfolder = pwd;
    FilenameCell = {DetectNcs.name}';    

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
    figure(genr)
    NonZerosChan = nonzeros(ChannelNum);
    [M,N] = size(ts);
     if N < 13
        for i=1:N
            subplot(3,4,i);
            plot(ts(:,i));
            xlim([0 M]);
            title(strcat('Channel:',num2str(NonZerosChan(i))));
            xlabel('Samples');
            ylabel('Amplitude')
        end
     elseif N >= 13
         for i=1:N
             subplot(3,5,i)
             plot(ts(:,i))
             xlim([0 M]);
             title(strcat('Channel:',num2str(NonZerosChan(i))));
             xlabel('Samples');
             ylabel('Amplitude')
         end
     end

end

figure(); heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings');






%This function sees if there is any missing value in each channel
function Less512 = NonValidSamples(NumberOfValidSamples,i) 

      NonValid(1,i) = any(NumberOfValidSamples < 512);
      if  NonValid(1,i) == 1 %to check if there are non valid channels
          Less512(i,:) = find(NumberOfValidSamples == 0);
      else
          Less512 = 0;
      end
end

