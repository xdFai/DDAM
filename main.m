clc;
clearvars;
close all;
flag = 0;   %控制显示
flagw = 1;  %控制存储

nn=0;   %
tic
fold = 'D:\02KAN\00paperwritter\Mat\selectimg\tests\';
imperty_orig='png';imperty_goal='png';dot='.';
imgDir1 = dir([fold ['*',dot,imperty_orig]]); 

for kk = 1:63 % 序列中的总图像数
    name=struct2cell(imgDir1(kk));
    name=name{1,1};%读取每张图片的名称
    name= strrep(name,[dot,imperty_orig],'');%减去字符串中的图像格式
    img = imread([fold imgDir1(kk).name]);
    img = img(:,:,1);
    img = double(img);
    re = DDAMfunc(img);
    bw = bwfunc(re);  %阈值分割
    if flag
        figure; imshow(uint8(img)); title('original image');
        figure; imshow(re, []); title('result image');
%             figure('color',[1 1 1]); surf(re);
        figure; imshow(bw) ; title('binary image');
%             加框
        hold on;           
%             stats = regionprops(bw, 'basic');
%             centroids = cat(1, stats.Centroid);
%             plot(centroids(:,1), centroids(:,2), 'b*'),
%             for i=1:size(stats)
%                 rectangle('Position',[stats(i).BoundingBox],'LineWidth',2,'LineStyle','--','EdgeColor','r'),
%             end
%             saveas(gcf,'D:\home\code\matlab\infrared-small-target-detection-master\result\detection\DNDA\EI\12\111.jpg');
    end
    if flagw
%             refold = ['D:\home\code\matlab\infrared-small-target-detection-master\EIpaper\simul\result\detection\'];
        refold = ['D:\02KAN\00paperwritter\Mat\selectimg\SRWS\' ];
        if exist(refold,'dir') == 0
            mkdir(refold);
        end
%             imwrite(uint8(img), [refold, num2str(kk), '1.png']);
%             imwrite(uint8( mat2gray(re) * 255), [refold, name, '2.png']);
        imwrite(uint8( mat2gray(bw) * 255), [refold, name, '.png']);
    end
end
    

toc