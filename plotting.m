% By pasting this files content in the line defined in main.m we will be
% able to plot all the channels of all the epoch folders with the name of
% each channel. This will be usefull as some channels are invalid.
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
