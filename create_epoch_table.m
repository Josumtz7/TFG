function [epoch] = create_epoch_table(Samples, SampleFrequencies)
    % This function calculates how many epochs we need to downsample up to
    % 4 seconds. It concatenates all of them in a single column.
    
    %   Input : 
    %       - Samples: Values of the samples
    %       - SampleFrequencies: Frequency of each miniepoch (32556 Hz)
    %   Output:
    %       - epoch: matrix with all the sample values until 4 seconds.

    [m nepoch] = size(Samples);
    Secs = m/SampleFrequencies(1,1); 
    epseg = 0;
    contsampl = 1;
    epseg = epseg + (4/(epseg+Secs));
    lastsec = 0;
    for k = 0:1:round(epseg)-1
        epoch(((m*k)+1):(m*(k+1)),1) = Samples((1:end),contsampl);     
        contsampl = contsampl +1;
        lastsec = lastsec+Secs;
    end 
end