function FinalPlotSave (h,name,varargin)
global generation  Setslog
    if isempty(varargin)
        FileNamePattern = strcat(Setslog.filename(1:end-4),'_',num2str(Setslog.out_index,'%02i'));
    else 
        FileNamePattern = strcat(Setslog.filename(1:end-4),'_',num2str(Setslog.out_index,'%02i'));
    end
        template = strcat(FileNamePattern,'_',name,'_',num2str(generation,'%03i'));
        Setslog.FileNamePattern = FileNamePattern;
        filename = sprintf('%s',template);
        saveas(h,filename,'png');
end
