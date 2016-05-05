%K = [0.1,0.3,0.4,0.5,0.6,0.7];
K = [0.15];

FolderName = '.\validate_\furnace301\';
dataFile = 'furnace301.mat';

%dataFile = 'DTLZ2_2000_12_3.mat';
out_index = 17:19;

%set 1 for min and -1 for max in PPopt_tripathi

for k = K
    PPopt(FolderName,dataFile,k,out_index);
end
