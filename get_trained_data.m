function mico_table = get_trained_data(Setslog, set_no, yl,varargin)
% returns the error of the actual value versus the output from trained net
% give more user flexibility
global figure_han saveon ploton

Xmin = Setslog.Xmin;
Xmax = Setslog.Xmax;
f_index = Setslog.out_index;
ymin = Setslog.Data_min(1,f_index);
ymax = Setslog.Data_max(1,f_index);


%DataSet defined according to varargin

%% Getting Trained Neural Net from Setslog
i = 0;
if i == 0, i = Setslog.dataset(set_no).pareto.select; end
Net = Setslog.dataset(set_no).pareto.P(i);

nonodes = Setslog.nonodes;
noinnodes = Setslog.noinnodes;
nooutnodes = Setslog.nooutnodes;
% xmin = Setslog.Data_min(1,Setslog.in_index);
% xmax = Setslog.Data_max(1,Setslog.in_index);
w = Net.w;
W = Net.W;

%%
fig = figure_han;

mico_table = zeros(1,Setslog.no_run);

for l = 1:Setslog.no_run
    if isempty(varargin)
        DataSet = Setslog.DataSet;
        in = Setslog.dataset(l).in;
        out = Setslog.dataset(l).out;
        %x axis of plot
        traindata1 = Setslog.dataset(l).data_index;%DataSet(Setslog.dataset(l).data_index, f1_index);
    else
        %data = importdata(char(varargin(1)));
        DataSet = importdata(char(varargin(1)));
        in = DataSet(:,1:noinnodes);
        out = DataSet(:,noinnodes+1:noinnodes+nooutnodes);
        traindata1 = (1:length(in))';
    end

    %% traindata1 == only the index of the data

    noexp = length(out(:,1));
    s = zeros(noexp,1); z = [];
    for i = 1:nonodes
        s(:) = w(i,1)*ones(noexp,1)+((w(i,2:noinnodes+1)*in')');
        z(:,i) = 1./(1+exp(-s(:)));
    end
    A = [ones(noexp,1) z];

    bber = A*W;

    % rescale the outputs
    for i = 1:nooutnodes
        bber(:,i) = ymin(i)+(ymax(i)-ymin(i))*(bber(:,i)-Xmin)/(Xmax-Xmin);
        if isempty(varargin)
            out(:,i) = ymin(i)+(ymax(i)-ymin(i))*(out(:,i)-Xmin)/(Xmax-Xmin);
        end
    end
    mico_table(1,l) = sqrt(sum(((bber-out)/(ymax-ymin)).^2)/noexp);

    % y axis of plot
    traindata2 = bber;   % Output from current Neural Net

    size(traindata1)
    size(traindata2)
    if l == set_no && l == Setslog.no_run, ploton = 1; end
    if ploton
        set(0,'CurrentFigure',fig(1)); clf
        % plotting f_index against data_index (==traindata1)
        plot(traindata1, DataSet(traindata1,f_index), '-r'); hold on
        if l == set_no
            plot(traindata1, traindata2, '-b')
            legend('Experimental Data', ['Trained Data by NNet ' num2str(l)])
        else
            plot(traindata1, traindata2, '--cs')
            legend('Experimental Data', ['Predicted Data by NNet ' num2str(set_no) ' on dataset ' num2str(l)])
        end
        xlabel('data index')
        ylabel(yl)
        pause(3)
        width = 16; % cm
        height = 12; % cm
        %% to save in high resolution
        %{
        set(gcf, 'PaperPosition', [0, 0, width / 2.54, height / 2.54])
        fname = [Setslog.filename(1:end-4) '_fit'];
        print(fname, '-dpng', '-r500')
        %}
        %%

        set(0,'CurrentFigure',fig(2)); hold off
        plot(DataSet(traindata1,f_index), DataSet(traindata1,f_index), '-kd', 'LineWidth', 2); hold on

        pol = polyfit(DataSet(traindata1,f_index), traindata2, 1);
        pol = pol(1)*DataSet(traindata1,f_index) + pol(2);
        plot(DataSet(traindata1,f_index), pol, '.-b', 'LineWidth', 2);

        text(0.5*(0.5*(ymin+ymax)+ymax), 0.5*(0.5*(ymin+ymax)+ymin), ['slope of fitted line: ' num2str(pol(1))], 'Fontsize', 12)
        xlabel(['Experimental ' yl]); ylabel(['Predicted ' yl]);
        if l == set_no
            legend('Experimental Data', ['Trained Data by NNet ' num2str(l)])
        else
            legend('Experimental Data', ['Predicted Data by NNet ' num2str(set_no) ' on dataset ' num2str(l)])
        end
        plot(DataSet(traindata1,f_index), traindata2, '.r');
        if saveon
            saveas(fig(2), [yl '_fit' num2str(set_no) 'on' num2str(l)], 'jpg')
            saveas(fig(1), [yl '_NNet' num2str(set_no) 'on' num2str(l)], 'jpg')
        end

        pause(3)
    end
end

end
