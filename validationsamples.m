function [Pos_Wrsam] = validationsamples(NumberOfValidSamples)
    %to know if there is incomplete information on the samples and identify the
    %missing data's position
    missing = 1;
    for i = 1:1:length(NumberOfValidSamples)
          if NumberOfValidSamples(i) ~= 512
             Pos_Wrsam(1,missing) = i;
             missing = missing+1;
          end
    end
end