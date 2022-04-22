% This could be a file to start and understand the basics of the code. It
% takes the information of only one channel recording. Change the name of
% the file you want.
clear

FieldSelectionFlags = [1 1 1 1 1];
Filename = 'CSC1_169806023_223259735.ncs'; % to be updated for each 'CSCx.ncs' file
HeaderExtractionFlag = 1;
ExtractMode = 1;
ExtractionModeVector = 1;
myfolder = pwd;
[Timestamps, ChannelNumbers, SampleFrequencies, NumberOfValidSamples, Samples, Header] = Nlx2MatCSC( Filename, FieldSelectionFlags, HeaderExtractionFlag, ExtractMode, ExtractionModeVector);
epoch(:,1) = create_epoch_table(Samples, SampleFrequencies);
downsepoch = downsampling(epoch, SampleFrequencies); 
