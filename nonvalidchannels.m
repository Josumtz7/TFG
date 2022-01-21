%This file says the files that are wrong in each epoch folder
% This README will detect the wrong channels in the future, task for the
% future
    
    %% epoch sn1: 
       % Missing channels: 9 and 12
       % Giving error channels: 11
       epochsn1 = ones(1,15);
       epochsn1(11) = 0;
       % Non valid channels: 4
       epochsn1(4) = 0;
    %% epoch sn2
       % Missing channels: 9, 11, 12 and 15
       % Giving error channels: -
       % Non valid channels: -
    %% epoch sn3
       % Missing channels: 9, 11, 12
       % Giving error channels: -
       % Non valid channels: 4
    %% epoch sn4
       % Missing channels: 9, 11, 12
       % Giving error channels: -
       % Non valid channels: -
     %% epoch sn5
       % Missing channels: 11, 12
       % Giving error channels: -
       % Non valid channels: 4

