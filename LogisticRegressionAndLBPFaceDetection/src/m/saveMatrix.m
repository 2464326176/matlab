function saveMatrix(X, filename)
%% Save the whole Matrix as text file
%  saveMatrix(X)

fid = fopen(filename, 'w')

for ii = 1 : size(X, 1)
        fprintf(fid, '%d ', X(ii, :));
        fprintf(fid, '\n');
end

fclose(fid)
