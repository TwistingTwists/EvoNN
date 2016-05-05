
function response = mkdir_if_not_exist(dirpath)
    if dirpath(end) ~= '/', dirpath = [dirpath '/']; end
    if (exist(dirpath, 'dir') == 0), 
        response = 'Does not exist! Making one!';
        mkdir(dirpath); 
    end
end

