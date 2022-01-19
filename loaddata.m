function [ChannelNum, FinalFilenames] = loaddata(FilenameCell)
    % loaddata identifies the channels with valid and detects the ones
    %without valid data.

        %    Input : Filenames of each epoch channel
        %    Output : Matrix with the valid and invalid numbers

    %Select the files which have a name pattern (the ones we want to analyze)
    [~,Names] = cellfun(@fileparts,FilenameCell,'uni',0);
    k = length(FilenameCell)+1;
    while length(FilenameCell) ~= 15
        FilenameCell{k,1} = [];        
        k = k+1;
    end
    Abrev = regexp(Names,'CSC\d*','match');
    comp = string([Abrev{:}]');
    k = length(comp)+1;
    while length(comp) ~= 15
        comp(k,1) = "";
        k = k+1;
    end
    FinalFilenames = strings(15,1);
    %See the Channels which are available for this epoch
    ChannelNum = zeros(15,1);
    for i = 1:1:length(ChannelNum)
        StrComp = strlength(comp(i,1));
        ChannelDet = comp(i,1);
        for j = 1:1:length(StrComp)        
            if StrComp == 4                
                Channel = double(extractAfter(ChannelDet,3));
            elseif StrComp == 5
                Channel = double(extractAfter(ChannelDet,3));
            else 
                Channel = [];
            end            
        end
        ChannelNum(Channel,1) = Channel;
        if isempty(Channel) == 0
            FinalFilenames(Channel,1) = string(FilenameCell(i,1));
        elseif isempty(Channel) == 1
            FinalFilenames(Channel,1) = 'NaN';
        end

    end
end
