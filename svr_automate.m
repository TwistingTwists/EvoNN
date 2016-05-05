trend = 'trend.mat';

%{
file = {'Trained_4-14_furnace_feature_remove_x3_x4_x7.mat'}
figl = 'Total BF gas Vol';


file = {'Trained_4-16_furnace_feature_remove_x3_x4_x7.mat'}
figl = 'Tuyere Velocity';

file = {'Trained_4-15_furnace_feature_remove_x3_x4_x7.mat'}
figl = 'Heat Loss';
%}
file = {'Trained_9-13_DTLZ2_2000_12_3.mat'}

%'Trained_9-14_DTLZ2_2000_12_3.mat',
%'Trained_9-15_DTLZ2_2000_12_3.mat'};
figl = {'DTLZ2'};
response = [];
for f=file
    response = [response; svr(char(f),figl,trend)]
end
