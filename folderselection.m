function [folderpwd] = folderselection(pwd)
    %This function allows to read all the folders
        % Input: directory 
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
    for i = 1:1:length(epochsubfoldername)
        folderpwd(i,1) = strcat(strdir, '\',epochsubfoldername(i,1));
        if contains(epochsubfoldername(i,1),'sn') == 1
           snNum(1,i) = extractAfter(epochsubfoldername(i,1),'sn');
        end  
        % for sommeil is not necessary as it is ordered
    end
    
    %To order the folder names, so that the graphs and loading data is
    %ordered too
    for i = 1:length(snNum)
        a = str2double(snNum(1,i));
        folder(a,1) = folderpwd(i,1);
    end
    missing = ismissing(folder);
    posmissing = find(missing == 1);
    folder(posmissing) = [];
    folderpwd(1:length(folder)) = folder;

end

