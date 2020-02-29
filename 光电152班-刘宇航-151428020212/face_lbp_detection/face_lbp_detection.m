% fprintf('------------------------初始化------------------------------------')
clear;clc;close;
% step1 遍历输出所有的图片
% fprintf('----------------------遍历图片保存信息----------------------------')
for i = 1:40
    for j = 1:10
        Img = ['./images/','s',num2str(i),'_',num2str(j),'.bmp']
        I = imread(Img); % 导入原图
        SP = [-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
        LBP = lbp(I,SP,0,'i');  %lbp处理后的图像
        Data1{(i-1)*10+j} = I;
        Data2{(i-1)*10+j} = LBP;
    end 
end
% step2 随机选取一张图片，将其与上述的矩阵库对比，检测识别
% fprintf('--------------------选取图片检测识别相关图片-----------------------')
Itag = imread('./images/s1_3.bmp'); 
SP = [-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
LBPtag = lbp(Itag,SP,0,'i');  %lbp处理后的图像

for i = 1:40
    for j = 1:10
        dive = abs(Data2{(i-1)*7+j}-LBPtag);
        Data3{(i-1)*10+j} = dive;
    end 
end
%设置一个阈值  判断是否识别成功
for i = 1:400
    if rank(double(Data3{i}))==0
%------------------------------图片-------------------------------------------%
% fprintf('---------------------输出待测试图片其相关的图片---------------------')
        figure('name','与其相关的图片')
        subplot(221)
        imshow(Itag);
        title('待识别的图');
        subplot(223)
        imshow(Data1{i})
        title('匹配的图')
        subplot(222)
        imshow(LBPtag)
        title('lbp处理后待识别的图')
        subplot(224)
        imshow(Data2{i})
        title('lbp处理后匹配的图')
 %------------------------------直方图-------------------------------------------%
%  fprintf('---------------输出待测试图片其相关的图片直方图---------------------')
        figure('name','直方图')
        mapping=getmapping(8,'u2');
        H11=lbp(Itag,1,8,mapping,'h'); %（8,1）邻域中使用均匀模式的LBP直方图
        subplot(2,2,1),title('待识别的图'),stem(H11);
        H12=lbp(Itag);
        subplot(2,2,2),title('lbp处理后待识别的图'),stem(H12);

        H21=lbp(Data1{i},1,8,mapping,'h'); 
        subplot(2,2,3),title('匹配的图'),stem(H21);
        H22=lbp(Data1{i});
        subplot(2,2,4),title('lbp处理后匹配的图'),stem(H22);
  
    end
end
% fprintf('------------------------结束-------------------------------------')


