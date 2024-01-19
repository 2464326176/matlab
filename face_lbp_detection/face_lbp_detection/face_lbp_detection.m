% fprintf('------------------------��ʼ��------------------------------------')
clear;clc;close;
% step1 ����������е�ͼƬ
% fprintf('----------------------����ͼƬ������Ϣ----------------------------')
for i = 1:40
    for j = 1:10
        Img = ['./images/','s',num2str(i),'_',num2str(j),'.bmp']
        I = imread(Img); % ����ԭͼ
        SP = [-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
        LBP = lbp(I,SP,0,'i');  %lbp������ͼ��
        Data1{(i-1)*10+j} = I;
        Data2{(i-1)*10+j} = LBP;
    end 
end
% step2 ���ѡȡһ��ͼƬ�������������ľ����Աȣ����ʶ��
% fprintf('--------------------ѡȡͼƬ���ʶ�����ͼƬ-----------------------')
Itag = imread('./images/s1_3.bmp'); 
SP = [-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
LBPtag = lbp(Itag,SP,0,'i');  %lbp������ͼ��

for i = 1:40
    for j = 1:10
        dive = abs(Data2{(i-1)*7+j}-LBPtag);
        Data3{(i-1)*10+j} = dive;
    end 
end
%����һ����ֵ  �ж��Ƿ�ʶ��ɹ�
for i = 1:400
    if rank(double(Data3{i}))==0
%------------------------------ͼƬ-------------------------------------------%
% fprintf('---------------------���������ͼƬ����ص�ͼƬ---------------------')
        figure('name','������ص�ͼƬ')
        subplot(221)
        imshow(Itag);
        title('��ʶ���ͼ');
        subplot(223)
        imshow(Data1{i})
        title('ƥ���ͼ')
        subplot(222)
        imshow(LBPtag)
        title('lbp������ʶ���ͼ')
        subplot(224)
        imshow(Data2{i})
        title('lbp�����ƥ���ͼ')
 %------------------------------ֱ��ͼ-------------------------------------------%
%  fprintf('---------------���������ͼƬ����ص�ͼƬֱ��ͼ---------------------')
        figure('name','ֱ��ͼ')
        mapping=getmapping(8,'u2');
        H11=lbp(Itag,1,8,mapping,'h'); %��8,1��������ʹ�þ���ģʽ��LBPֱ��ͼ
        subplot(2,2,1),title('��ʶ���ͼ'),stem(H11);
        H12=lbp(Itag);
        subplot(2,2,2),title('lbp������ʶ���ͼ'),stem(H12);

        H21=lbp(Data1{i},1,8,mapping,'h'); 
        subplot(2,2,3),title('ƥ���ͼ'),stem(H21);
        H22=lbp(Data1{i});
        subplot(2,2,4),title('lbp�����ƥ���ͼ'),stem(H22);
  
    end
end
% fprintf('------------------------����-------------------------------------')


