function PP_NNGA_subsets (FolderName,filename,in_index, out_index)
%% (Data, in_index, out_index)
%PP_NNGA_SUBSETS for training Neural Net models on dataset
%Created by Brijesh Kumar Giri
%   2011-2012
%In the plot F1 (x-axis) shows the complexity and
%F2 (y-axis) shows the training error
%====Instruction on creating datafile for the code=========================
% if a .xls file for dataset is available then go to the respective directory
% and double click it. Matlab will load data from the .xls file in a matrix of
% type double in a variable named data. the headers in .xls file will loaded
% matrix of type cell in a variable named textdata. Make sure that the xls
% contains two rows of headers, 1st row gives a detailed name of variable and
% 2nd row gives names to be used as terminal nodes (keep it as simple as
% possible, best would be to give an alphabet followed by a number)
% next execute the following line in commamnd window:
% data = [textdata; num2cell(data)];
% now save variable data in a .mat file by executing the line below:
% save Nmae_of _file data
%try this with example demo.xls
%also check out data_demo.amt and other demo data files

clc
%=====================DND==================================================

Data = strcat(FolderName,filename)
global Setslog figure_handle

plst = {'\NN_util' '\PP_util' '\util' '\res\demo'};
for i = 1:length(plst)
    path([pwd plst{i}], path);
end

figure_handle = [];
RandStream('mt19937ar','seed', sum(100*clock));
Setslog = [];

%% =====================Define input parameters=======================================
%Data = 'DTLZ5.mat';                %Data file
%in_index = [1;20]';                %independent variables column no.
%out_index = 2;                     %dependent variable column no.

%% subsets partioning
Xmin = eps; Setslog.Xmin = Xmin;    %normalization range for variables
Xmax = 1; Setslog.Xmax = Xmax;

Setslog.in_index = in_index;
Setslog.out_index = out_index;

DataSet = importdata(Data);
Setslog.DATA = DataSet;

%Setslog.paraname = DataSet(1:2,:);
%DataSet(1:2,:) = [];
%DataSet = cell2mat(DataSet);
Setslog.DataSet = DataSet;

subsets =1; overlap = 5;           %number of partitions of datafile and overlap b/w them
set_size = length(DataSet(:,1)); Setslog.set_size = set_size;
Setslog.subsets = subsets;
Setslog.overlap = overlap;
subset_size = round((set_size + (subsets-1)*overlap) / subsets);
Setslog.subset_size = subset_size;

%%

Setslog.generations = 120;                      %Maximum number generations for evolution
Setslog.nonodes = 4;                            %maximum number of hidden nodes
Setslog.noinnodes = length(Setslog.in_index);   %Number of input nodes as given in PP_NNGA_automate
Setslog.nooutnodes = length(Setslog.out_index); %Number of output nodes as given in PP_NNGA_automate
Setslog.maxrank = 10;                           %maxrank retained at KillInterval
Setslog.KillInterval = 11;                      %Interval at which bad preys are eliminated
Setslog.Prey_popsize = 200;                     %Initial prey population size
Setslog.no_Prey_preferred = 190;                %Desired prey population size
Setslog.no_new_Prey = 150;                      %Number of new prey introduced every KillInterval
Setslog.Predator_popsize = 75;                  %Number of Predators
Setslog.no_x = 70;                              %lattice size (no of rows)
Setslog.no_y = 70;                              %lattice size (no of cols)
Setslog.ploton = 1;                             %set 0 for no plots or 1 for plots at every generation
Setslog.filename = Data;
Setslog.FolderName = FolderName;
%========================Plotting the output===============================
if Setslog.ploton
    figure_handle = [figure(1) figure(2) figure(3) figure(4)]; 
    scrsz = get(0,'ScreenSize');
    set(figure_handle(1), 'OuterPosition', [0*scrsz(3) scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]); clf(figure_handle(1))
    set(figure_handle(2), 'OuterPosition', [scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]); clf(figure_handle(2))
    set(figure_handle(3), 'OuterPosition', [0*scrsz(3) 0*scrsz(4) scrsz(3)/2 scrsz(4)/2]); clf(figure_handle(3))
    set(figure_handle(4), 'OuterPosition', [scrsz(3)/2 0*scrsz(4) scrsz(3)/2 scrsz(4)/2]); clf(figure_handle(4))
    pause(0.1)
end

%========================Scaling the data==================================
DataSet_sc = [];
for i=1:length(DataSet(1,:))
    Data_min(1,i) = min(DataSet(:,i));
    Data_max(1,i) = max(DataSet(:,i));
    DataSet_sc = [DataSet_sc Xmin+ (DataSet(:,i)-Data_min(1,i))/(Data_max(1,i)-Data_min(1,i))*(Xmax-Xmin)];
end
Setslog.DataSet_sc = DataSet_sc;
Setslog.Data_min = Data_min;
Setslog.Data_max = Data_max;

eval(['delete Setslog' num2str(Setslog.nonodes) '-' num2str(Setslog.out_index) '_' Data])
%==========================================================================

%========================Choose datasets for training======================

if subsets == 1
    training_subsets = 1;
    no_run = 1; Setslog.no_run = no_run;
else
    training_subsets = [eye(subsets,subsets); ones(1,subsets)];
    no_run = 1+subsets; Setslog.no_run = no_run;
end
Setslog.chosen_training_sets = training_subsets;
%==========================================================================

%========================Creating training data============================
data_index = (1:1:length(DataSet))';
for i = 1:no_run
    chosen_data_index = [];
    from = 1; to = from + subset_size - 1;
    for j = 1:subsets-1
        if training_subsets(i,j) == 1
            chosen_data_index = [chosen_data_index; data_index(from:to,:)];
        end
        from = to - overlap + 1; to = from + subset_size - 1;
    end
    
    if training_subsets(i,subsets) == 1
        chosen_data_index = [chosen_data_index; data_index(from:length(data_index(:,1)),:)];
    end
    chosen_data_index = unique(chosen_data_index);
    Setslog.dataset(i).data_index = chosen_data_index;
    Setslog.dataset(i).in = Setslog.DataSet_sc(chosen_data_index,in_index);
    Setslog.dataset(i).out = Setslog.DataSet_sc(chosen_data_index,out_index);
end
%==========================================================================

%========================Train neural nets on each dataset=================
for i = 1:no_run
    if i < no_run
        fprintf('\nTraining Dataset %d\n\n', i);
    else
        fprintf('\nTraining Whole Dataset\n\n');
    end
    PP_NNGA(i);
    %pause(0.1)
end
fprintf('\n\nTrainining Subsets\n');
disp(training_subsets);
%==========================================================================

file = sprintf('%sTrained_%s-%s_%s',char(FolderName),num2str(Setslog.nonodes),num2str(Setslog.out_index),filename);
save(file,'Setslog');


for i = 1:length(plst)
    rmpath([pwd plst{i}]);
end
clear all
end