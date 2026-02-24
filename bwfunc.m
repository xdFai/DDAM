%  ãĞÖµ·Ö¸î´úÂë
function bw = bwfunc(re)
mm = 2;
m =mean2(re);
s = std2(re);
% maxv = max(re(:));
maxv = max(re);
switch mm
    case 1
        T = m + 0.5*(maxv - m);
    case 2
        ratio = 0.99;
        T = ratio * maxv;
    case 3
        ratio = 20;
        T = m+ ratio*s;
end
% disp(T);
bw = re> T;
end