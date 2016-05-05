function saveasgif(FolderName,filename,nameArray,out_index)
% make sure the folder name is properly attributed
n_obj = length(out_index);
    %% saving using ImageMagick

    % Run the code from EvoNN directory.
    ImageMagick = '.\ImageMagick-6.9.3-8-portable-Q16-x64\convert -loop 0 -delay 50 '; %make sure to leave a blank space at end

    for i=1:n_obj
        FileNamePattern = strcat(FolderName,filename);
        FileNamePattern = FileNamePattern(1:end-4); % remove `.mat` from FileNamePattern
        FileNamePattern=strcat(FileNamePattern,'_',num2str(out_index(i)));
        for nam=nameArray
            name = char(nam);
            FilePattern = strcat(FileNamePattern,'_',name,'*');
            SaveAs = sprintf(' %s%s%s%s',FileNamePattern,'_',name,'.gif');
            cmd = sprintf('%s%s%s',ImageMagick,FilePattern,SaveAs);
            system(cmd);
        end
    end
end
