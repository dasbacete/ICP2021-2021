clear all;
%% parameters

is_negative = false; % set it to true if u want negative values in a
mtw = 8; % number of matrixes to compute, maximum is 16

%%						A matrix generation	and storage instantiation							
[A A_bn A_hx ] =matrix(8,4,7,2^7, is_negative, true);
[Apr_dc Apr_bn Apr_hx] = print_reshape(A, A_bn, A_hx );

indexes = [1 4 3 2];
RAM = [];
m= [];
Xs = [];
Xd = [];
Xb = [];
Xh = [];
Rs = [];

%% 						 Computation
for i = 1:mtw

	[X X_bn X_hx] =matrix(4,8,8,2^8, false, false);
	
	Xs =[Xs; X];

	[Xpr_dc Xpr_bn Xpr_hx] =print_reshape(X', X_bn', X_hx');

	Xd = [Xd;Xpr_dc];
	Xb = [Xb;Xpr_bn];
	Xh = [Xh;Xpr_hx];

	R = X*A;
	Rs = [Rs R];

	R_STarray = R(1:2,1:2);
	R_NDarray = R(3:4,1:2);
	R_RDarray = R(1:2,3:4);
	R_THarray = R(3:4,3:4);
    
    diag = R(1,1)+R(2,2)+R(3,3)+R(4,4);
    
	R_STarray = R_STarray(indexes);
	R_NDarray = R_NDarray(indexes);
	R_RDarray = R_RDarray(indexes);
	R_THarray = R_THarray(indexes);
    
    maxST = max(R_STarray);
    maxND = max(R_NDarray);
    maxRD = max(R_RDarray);
    maxTH = max(R_THarray);
    
    max_value = max([maxST maxND maxRD maxTH]);
    m = [m max_value]
    diag = floor(diag/4);
    
	MatrixInMem = [R_STarray R_NDarray R_RDarray R_THarray diag max_value];

	RAM = [RAM MatrixInMem ];
end 
	RAM_hx = dec2hex(RAM);
	RAM_bn = dec2bin(RAM,18);

%% 						Write files
Xpath='../text_files/Xfiles';
Apath='../text_files/Afiles';
Rpath='../text_files/Rfiles';

%A
filename_d = [Apath '/A_dec.txt'];
filename_b = [Apath '/A_bn.txt'];
filename_h = [Apath '/A_hx.txt'];
a = fopen(filename_d,'w');
b = fopen(filename_b,'w');
c = fopen(filename_h,'w');
for i = 1:((length(Apr_dc))-1)
	fprintf(a, '%s,\n',Apr_dc(i,:));	
	fprintf(b, '"%s",\n',Apr_bn(i,:));
	fprintf(c, '"%s",\n',Apr_hx(i,:));
end
	fprintf(a, '%s',Apr_dc(length(Apr_dc),:));
	fclose(a);
	fprintf(b, '"%s"',Apr_bn(length(Apr_bn),:));
	fclose(b);
	fprintf(c, '"%s"',Apr_hx(length(Apr_bn),:));
	fclose(c);

%X
filename_d = [Xpath '/X_dec.txt'];
filename_b = [Xpath '/X_bn.txt'];
filename_h = [Xpath '/X_hx.txt'];

a = fopen(filename_d,'w');
b = fopen(filename_b,'w');
c = fopen(filename_h,'w');

for i = 1:((length(Xb))-1)
	fprintf(a, '%s,\n',Xd(i,:));
	fprintf(b, '%s\n',Xb(i,:));
	fprintf(c, '%s\n',Xh(i,:));
end
	fprintf(a, '%s',Xd(length(Xd),:));
	fclose(a);
	fprintf(b, '%s',Xb(length(Xb),:));
	fclose(b);
	fprintf(c, '%s',Xh(length(Xh),:));
	fclose(c);

%RAM
filename_d = [Rpath '/RAM_dc.txt'];
filename_h = [Rpath '/RAM_hx.txt'];
filename_b = [Rpath '/RAM_bn.txt'];

a = fopen(filename_d,'w');
b = fopen(filename_h,'w');
c = fopen(filename_b,'w');

for i = 1:((length(RAM))-1)
	fprintf(a, '%i,\n',RAM(i));
	fprintf(b, '%s,\n',RAM_hx(i,:));
	fprintf(c, '%s,\n',RAM_bn(i,:));
end
	fprintf(a, '%i',RAM(length(RAM)));
	fclose(a);
	fprintf(b, '%s',RAM_hx(length(RAM),:));
	fclose(b);
	fprintf(c, '%s',RAM_bn(length(RAM),:));
	fclose(c);
	