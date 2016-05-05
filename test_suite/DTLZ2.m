
p = 2000;
nu = 1 ;
M = 3;
n = 12;
k = n-M+1;
validate = 0;
g = @(x,k) (sum((x-0.5).^(2),2));

data = DTLZ_frame(p,M,n,nu,g);
%%  include util folder in variable paths
plst = {'\util\'};
for i = 1:length(plst)
    path([pwd plst{i}], path);
end

%% Saving Data
FolderName = sprintf('DTLZ2_%s_%s_%s',num2str(p),num2str(n),num2str(M));

if validate
    fprintf('validation ON')
    filename = ['validate_' FolderName];
    mkdir_if_not_exist('validate_')
    Completefilename = sprintf('.\\%s\\%s', 'validate_',filename);
else
    mkdir_if_not_exist(FolderName)
    filename = FolderName;
    Completefilename = sprintf('.\\%s\\%s', FolderName,filename);
end


% Make sure to run this code from EvoNN Folder 
% not test_suite folder

% save in the new directory formed.. CUrrent Directory = EvoNN\

save(Completefilename,'data');
fprintf('saved at %s \n',Completefilename);

