% This function will help us to detect the index values of the real
% channels. If not with the missing data and without making use of the
% aproximation and mean values (in short, without completing the missing
% data) we couldn't see the real interdependencies between neural channels.

function [Otot] = real_channel(maxsize, Otot, num_valid_chann)
    for i = 3:maxsize
        for j = 1:length(Otot(i).index_var_red)
            for k = 1:i
                 Otot(i).index_var_red(j,k) = num_valid_chann(1,Otot(i).index_var_red(j,k));
            end
        end

         for j = 1:length(Otot(i).index_var_syn)
            for k = 1:i
                 Otot(i).index_var_syn(j,k) = num_valid_chann(1,Otot(i).index_var_syn(j,k));
            end
        end
    end
end