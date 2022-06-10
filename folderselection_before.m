function folderpwd = folderselection_before(pwd)
    %This function allows to read all the folders in 7 days afer injection
    %recordings, the data has been taken 1 hour after the test.
        % Input: directory 
        % Output: a matrix with all the names of the channel's directory ordered
    
    topLevelFolder = pwd; 
    files = dir(topLevelFolder);
    strdir = convertCharsToStrings(topLevelFolder);
    dirFlags = [files.isdir];
    subFolders = files(dirFlags); 
    subFolderNames = {subFolders(3:end).name};
    
    j = 1;
    %Find the folders called epoch
    for i = 1:1:length(subFolderNames)
        if contains(subFolderNames(1,i),'epoch') == 1
            epochsubfoldername(j,1) = subFolderNames(1,i);
            j = j+1;
        end
    end
    
     % I have done an string matrix with all the directory location of the
        % folders we want to analyse
        i_sn = 1; i_vc = 1;i_sl = 1;
        for i = 1:1:length(epochsubfoldername)
            folderpwd(i,1) = strcat(strdir, '\',epochsubfoldername(i,1));
            if contains(epochsubfoldername(i,1),'sn') == 1
               dirSn(i_sn,1) = folderpwd(i,1);
               snNum(1,i_sn) = extractBefore(dirSn(i_sn,1),'sn');
               snNum(1,i_sn) = extractAfter(snNum(1,i_sn),'epoch');
               i_sn = i_sn + 1;
            elseif contains(epochsubfoldername(i,1),'vc') == 1
               dirVc(i_vc,1) = folderpwd(i,1);
               vcNum(1,i_vc) = extractBefore(dirVc(i_vc,1),'vc');
               vcNum(1,i_vc) = extractAfter(vcNum(1,i_vc),'epoch');
               i_vc = i_vc +1;
           elseif contains(epochsubfoldername(i,1),'sommeil') == 1
           dirSl(i_sl,1) = folderpwd(i,1);
           slNum(1,i_sl) = extractBefore(dirSl(i_sl,1),'sommeil');
           slNum(1,i_sl) = extractAfter(slNum(1,i_sl),'epoch');
           i_sl = i_sl +1;
           end  
            
        end
    
        %sPos = in which position of the directory is each sniffing folder
        %vPos = in which position of the directory is each vc folder
        %slPos = in which position of the directory is each sleep folder
        
        [~, sPos] = sort(str2double(snNum)); 
        [~, vPos] = sort(str2double(vcNum));
        [~, slPos] = sort(str2double(slNum));
    
        %To order the folder names, so that the graphs and loading data is
        %ordered too
        
        %First the sniffing files
        for i = 1:length(snNum) 
            folder(i,1) = dirSn(sPos(1,i),1);
            if i == length(snNum)
                i_fin = i;
            end
        end
        %Then the resting files
        for i = 1:length(vcNum) 
            folder(i+ i_fin,1) = dirVc(vPos(1,i),1);
            if i == length(vcNum)
                i_fin = i + i_fin;
            end
        end
        %Finally the sleeping ones
        for i = 1:length(slNum) 
            folder(i+ i_fin,1) = dirSl(slPos(1,i),1);
        end
        folderpwd = folder;
end