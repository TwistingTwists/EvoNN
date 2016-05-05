in_index = (1:16)';

% include in path, the foldername.

FolderName = '.\furnace302\';
filename = 'furnace302.mat';

out_index = 17  ;
n_obj = length(out_index);

% currently the file PP_NNGA_subsets supports the input data in form of matrix (not cell) type.

for out=out_index
    PP_NNGA_subsets(FolderName,filename,in_index,out);
    
end

%% Saving gifs
name = {'all_fronts','front-1','gen'};
disp('Saving gifs...')
saveasgif(FolderName,filename,name,out_index);

disp('Gifs Saved!...')

%% Comments and Caution
%if you change the name of the folders, take care to change it in
%FinalPlotSave.m - Directory to save images