
function [to_print_dc to_print_bn to_print_hx] = print_reshape(M_dc,M_bn, M_hx)

	rs_m = reshape(cellstr([repmat(' ', [32,1]) int2str(reshape(M_dc,32,1))]),8,4);
	rs_m = rs_m(:,[1 3 2 4]);
	to_print_dc = cell2mat(reshape(rs_m,16,2));

	rs_m = M_bn(:,[1 3 2 4])
	aux = cell2mat(reshape(rs_m,16,2))
    to_print_bn = aux;
	
	to_print_hx = dec2hex(bin2dec(aux));
end