clear all;
path_results='../text_files/Rfiles/RAM_SIM.txt';
path_true_results='../text_files/Rfiles/RAM_dc.txt';

fid=fopen(path_results);
results =fscanf(fid,'%s');
fclose(fid);
results = strsplit(results,',');
results=cell2mat(results');
sign=results(2:145,1);
sign = repmat(sign,15);
number= results(2:145,2:18);
results = [sign(1:144,:) number];
%results = [repmat('0b',144,1) results repmat('s32',144,1) ];
RAM_content = typecast(uint32(bin2dec(results)),'int32');


fileID = fopen(path_true_results);
%read formatted data as strings of 2 characters
A = textscan(fileID,'%d32', 'Delimiter',',');
results=A{:};
fclose(fileID);

comparison = results==RAM_content;
error_index = find(comparison==0);

if (isempty(error_index))
   msg = 'CORRECT result, no errors found'
else
    msg = 'WRONG values at index: '
    error_index
    
end;