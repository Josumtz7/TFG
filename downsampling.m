function [downsepoch, posdown] = downsampling(epoch, SampleFrequencies)
    % This function downsamples each channel from a frequency of 32556 Hz,
    % which is horribly high, to 1000 Hz. It is important to save the
    % position of the downsampling value so in case there is a missing
    % value in any channel the time of all the dowsampled datapoints are
    % the same.

    %   Input : 
    %       - epoch: all the concatenated values of each channel
    %       - SampleFrequencies: Frequency of each miniepoch (32556 Hz)
    %   Output:
    %       - downsepoch: matrix with all the sample values downsampled
    %       - posdown: save the position of the datapoints. STILL HAVE TO
    %       TO A REVISION OF THIS
    
    %Calculate the number of samples we need to downsample at 1000Hz.
    downFreq = 1000;
    samplenum = round((length(epoch)*downFreq)/SampleFrequencies(1,1));
    %Define the factor number for downsampling
    samplevalue = length(epoch)/samplenum;
    %Save the position of each timestamp in order to have the same datapoint
    %time in each channel
    posdown = (1:33:length(epoch))';
    %Downsample
    downsepoch = downsample(epoch,round(samplevalue));    
end

