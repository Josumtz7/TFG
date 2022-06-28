clear 
close all
pwd = 'D:\Erasmus\TFG\Neuralynx\Classe C_TLE 7j\1h avt test';

folderpwd = folderselection_7j(pwd);
validchann = zeros(length(folderpwd),15);
i_centi = 0; 

%initialize how many folders we have from each behaviour
nSniff_folder = 6;
nSleep_folder = 2; i_sleep = 1;
nRest_folder = 10; i_rest = 1;

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
    t= 1;
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

    % In this part we concatenate each channel for each behavior 
    num_valid_chann = nonzeros(ChannelNum)';
    if genr <= nSniff_folder
        min_sniff = 1 + ((genr-1)*length(downsepoch)); 
        max_sniff = min_sniff + length(downsepoch) - 1;
        [mean_sniffing([min_sniff:max_sniff],:), valid_sn_groups(genr,:)] = first_aggroupation(num_valid_chann, downsepoch);
    elseif genr <= (nSniff_folder + nSleep_folder)
        min_sleep = 1 + ((i_sleep-1)*length(downsepoch)); 
        max_sleep = min_sleep + length(downsepoch) - 1;
        [mean_sleeping([min_sleep:max_sleep],:), valid_sl_groups(genr,:)] = first_aggroupation(num_valid_chann, downsepoch);
        i_sleep = i_sleep +1;
    else
        min_rest = 1 + ((i_rest-1)*length(downsepoch)); 
        max_rest = min_rest + length(downsepoch) - 1;
        [mean_rest([min_rest:max_rest],:), valid_rest_groups(genr,:)] = first_aggroupation(num_valid_chann, downsepoch);
        i_rest = i_rest +1;
    end
    
    %Plotting all channels for validation here, code in plotting.m 

end

groups = ones(length(mean_rest),1); 
[Otot, O_tot_value] = hoi_exhaustive_loop_zerolag_fdr(mean_rest,4,20,1,myfolder,groups);
syn_resting_before = Otot(3).index_var_syn; save('after7j_resting_syn','syn_resting_before');
red_resting_before = Otot(3).index_var_red; save('after7j_resting_red','red_resting_before');

figure(); heatmap(validchann, 'XLabel','Channel number', 'YLabel', 'Epoch recordings'); title('7 days after seizure');


%This function sees if there is any missing value in each channel
function Less512 = NonValidSamples(NumberOfValidSamples,i) 

      NonValid(1,i) = any(NumberOfValidSamples < 512);
      if  NonValid(1,i) == 1 %to check if there are non valid channels
          Less512(i,:) = find(NumberOfValidSamples == 0);
      else
          Less512 = 0;
      end
end

