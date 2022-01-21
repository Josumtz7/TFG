function [folderpwd] = folderselection(pwd)

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
    end

end
