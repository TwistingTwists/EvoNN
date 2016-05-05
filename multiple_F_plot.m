% this is only a pilot (beta) script for visualisation of multiple F on N by N grid
paretoFile= 'DTLZ2_800_12_3_K-25_pareto_13-15.mat';
load(paretoFile)
out_index = 13:15;
%{

for i = out_index
fig = [fig; figure(i)];
% create an array of figure

end
%}
n_obj=length(out_index);

width=25;
height = 25;
set(gcf, 'PaperPosition', [0, 0, width / 2.54, height / 2.54])
%text(0.5,0.5,'K Non Dominated Front','Units','normalized')
count = 0;
pareto_save = 1 ;
%% save K-non_dom

if ~pareto_save
    for i=1:n_obj
        for j=1:n_obj
            count = count + 1;
            subplot(n_obj,n_obj,count)
            plot(pareto.F(:,i),pareto.F(:,j),'.')

            xl = sprintf('F %s',num2str(out_index(i)));
            yl = sprintf('F %s',num2str(out_index(j)));
            xlabel(xl,'Fontsize',9)
            axis([min(pareto.F(:,i)) max(pareto.F(:,i)) min(pareto.F(:,j)) max(pareto.F(:,j))])
            ylabel(yl,'Fontsize',9)
            %fname = [paretoFile(1:end-4) '_F' num2str(out_index(i)) '-' out_index(j)];
        end
    end

    fname = [paretoFile(1:end-4) '_K-DOM' ];
    print(fname, '-dpng', '-r500');

else
    for i=1:n_obj
        for j=1:n_obj
            count = count + 1;
            subplot(n_obj,n_obj,count)
            plot(pareto.F_nondom(:,i),pareto.F_nondom(:,j),'*')

            xl = sprintf('F %s',num2str(out_index(i)));
            yl = sprintf('F %s',num2str(out_index(j)));
            xlabel(xl,'Fontsize',9)
            axis([min(pareto.F_nondom(:,i)) max(pareto.F_nondom(:,i)) min(pareto.F_nondom(:,j)) max(pareto.F_nondom(:,j))])
            ylabel(yl,'Fontsize',9)
            %fname = [paretoFile(1:end-4) '_F' num2str(out_index(i)) '-' out_index(j)];
        end
    end

    fname = [paretoFile(1:end-4) '_NONDOM' ];
    print(fname, '-dpng', '-r500');
end
%%

clear all

%{

y2 = sin(2*x);
subplot(2,2,2)
plot(x,y2)
title('Second subplot')

y3 = sin(4*x);
subplot(2,2,3)
plot(x,y3)
title('Third subplot')

y4 = sin(6*x);
subplot(2,2,4)
plot(x,y4)
title('Fourth subplot')



for i=out_index
    set(0,'CurrentFigure',fig(i));
    plot(pareto.F(:,i))

end
%}
