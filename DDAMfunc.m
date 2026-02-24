function re = DDAMfunc(img)
img = double(img);
[row, col] = size(img);
len = 3;
nr = 5;
nc = 5;
leny = len*nr;
lenx=  len*nc;
op = zeros(leny, lenx, nr*nc);
%  获取滤波器
for ii = 1:nr*nc
    temp = zeros(len*nr,  len*nc);
    [r, c]  = ind2sub([nr, nc], ii);
    temp((r-1)*len + 1:r*len, (c-1)*len+1:c*len) = 1;
    temp = temp/sum(temp(:));
    temp = temp';
    op(:, :, ii) = temp;
end
%% 对图像做滤波
gimg = zeros(row, col, nr*nc);
for ii = 1:nr*nc
    gimg(:, :, ii) = imfilter(img, op(:,:, ii), 'replicate');
end
% 得到滤波后的图像

%% 对外圈做操作
cout1 = gimg(:,:,13) - gimg(:,:,1); 
cout2 = gimg(:,:,13) - gimg(:,:,11); 
cout3 = gimg(:,:,13) - gimg(:,:,21); 
cout4 = gimg(:,:,13) - gimg(:,:,3); 
cout5 = gimg(:,:,13) - gimg(:,:,23);
cout6 = gimg(:,:,13) - gimg(:,:,5);
cout7 = gimg(:,:,13) - gimg(:,:,15);
cout8 = gimg(:,:,13) - gimg(:,:,25);
dout1 = cout1.*cout8;dout1(dout1<=0) = 0;
dout2 = cout2.*cout7;dout2(dout2<=0) = 0;
dout3 = cout3.*cout6;dout3(dout3<=0) = 0;
dout4 = cout4.*cout5;dout4(dout4<=0) = 0;
tout=cat(3, dout1, dout2, dout3, dout4);
dout2 = min(tout, [], 3);


%% 对内圈做操作
cin1 = gimg(:,:,13) - gimg(:,:,7); 
cin2 = gimg(:,:,13) - gimg(:,:,12); 
cin3 = gimg(:,:,13) - gimg(:,:,17); 
cin4 = gimg(:,:,13) - gimg(:,:,8); 
cin5 = gimg(:,:,13) - gimg(:,:,18);
cin6 = gimg(:,:,13) - gimg(:,:,9);
cin7 = gimg(:,:,13) - gimg(:,:,14);
cin8 = gimg(:,:,13) - gimg(:,:,19);
din1 = cin1.*cin8;din1(din1<=0) = 0;
din2 = cin2.*cin7;din2(din2<=0) = 0;
din3 = cin3.*cin6;din3(din3<=0) = 0;
din4 = cin4.*cin5;din4(din4<=0) = 0;
tin=cat(3, din1, din2, din3, din4);
din2 = min(tin, [], 3);

re = dout2.*din2;
end