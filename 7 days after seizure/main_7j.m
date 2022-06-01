clear 
close all
pwd = 'D:\Erasmus\TFG\Neuralynx\Classe C_TLE 7j\1h avt test';

folderpwd = folderselection_7j(pwd);
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

    %Plotting all channels for validation, erase if you want. This part of
    % the code can be found in plotting.m 
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

