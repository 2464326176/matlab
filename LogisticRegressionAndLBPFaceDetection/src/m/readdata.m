function X = readdata(data_file_path)
% readdata function is used for read data into Matrix X
% Usage:    X = readdata(data_file_path)

fileID = fopen(data_file_path, 'r')
formatSpec = '%d';
for i = 1 : 255
        formatSpec = strcat(formatSpec, ' %d')
end
sizeX = [256 Inf]
X = fscanf(fileID, formatSpec, sizeX)
X = X'
