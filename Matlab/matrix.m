function [M_dc, M_bn, M_hx] = matrix(r, c ,p ,number, is_negative, is_A)

	% matrix  Generate a mtrix fot testbench
	%   M_dc = random int matrix
	%   M_bn = M_dc in binary format
	%   M_bn = M_dc in hex format
	
	%	r rows
	%   c columns
	%   is_negative use of negative numbers
    if is_A==true
        M_dc= [3,8,18,1; 22, 15, 40, 10; 11,2,3,4; 1,4,2,0; 8,12,16,2; 3,6,9,12; 1,1,1,1 ; 2,2,2,2 ];
    else
	if is_negative == false
         %For propper Matlab version use:M_dc=randi([0,number-1],r,c);
         M_dc=randi([0,(number/2)-1],r,c);
	else
		number
		 M_dc=randi([-number/2,(number/2)-1],r,c);
    end
    end
	M_hx = reshape(cellstr(dec2hex(M_dc',round(p/4))),[c,r])';

	aux=dec2bin(M_dc',p)
	if(is_negative)
	
	aux = aux(:,2:8)
	end
	M_bn = reshape(cellstr(aux),[c,r])';

end


