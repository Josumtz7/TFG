function [downsepoch] = downsampling(epoch, SampleFrequencies)
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
    
    
    Fsa =  SampleFrequencies(1,1);                              % Actual Sampling Frequency
    Fsd = 900;                                                 % Desired Sampling Frequency
    [N,D] = rat(Fsd/Fsa);                                       % Rational Fraction Approximation
    Check = [Fsd/Fsa, N/D];                                     % Approximation Accuracy Check 
    downsepoch = resample(epoch, N, D);                         % Resampled Signal
end

