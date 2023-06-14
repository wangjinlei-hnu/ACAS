%ģ������������
%���������ü�ʻԱģ��
%ģ���������ǰ��ת���
% clear;
% close all;

a=newfis('fuzzpid'); %����һ���µ�ģ��������

a=addvar(a,'input','e_v',[-4,4]);                        %Parameter e  %��������Ϊ������������ֵ�Ĳ�  ����������ģ����������Ҫ����ӳ��һ��
a=addmf(a,'input',1,'NB','zmf',[-4,-2]);
a=addmf(a,'input',1,'NM','trimf',[-3,-1.7,-0.5]);
a=addmf(a,'input',1,'NS','trimf',[-2,-0.7,0]);
a=addmf(a,'input',1,'ZO','trimf',[-0.5,0,0.5]);
a=addmf(a,'input',1,'PS','trimf',[0,0.7,2]);
a=addmf(a,'input',1,'PM','trimf',[0.5,1.7,3]);
a=addmf(a,'input',1,'PB','smf',[2,4]);

a=addvar(a,'input','ec_v',[-4,4]);                       %Parameter ec  ���������ı仯��
a=addmf(a,'input',2,'NB','zmf',[-4,-2.5]);
a=addmf(a,'input',2,'NM','trimf',[-3.5,-2.3,-1.2]);
a=addmf(a,'input',2,'NS','trimf',[-2.5,-1,-0]);
a=addmf(a,'input',2,'ZO','trimf',[-1.2,0,1.2]);
a=addmf(a,'input',2,'PS','trimf',[0,1,2.5]);
a=addmf(a,'input',2,'PM','trimf',[1.2,2.3,3.5]);
a=addmf(a,'input',2,'PB','smf',[2.5,4]);

a=addvar(a,'output','Force',[-3,3]);                   %Parameter kp
a=addmf(a,'output',1,'NB','zmf',[-3,-2]);
a=addmf(a,'output',1,'NM','trimf',[-3,-2,-1]);
a=addmf(a,'output',1,'NS','trimf',[-2,-1,0]);
a=addmf(a,'output',1,'ZO','trimf',[-1,0,1]);
a=addmf(a,'output',1,'PS','trimf',[-0,1,2]);
a=addmf(a,'output',1,'PM','trimf',[1,2,3]);
a=addmf(a,'output',1,'PB','smf',[2,3]);

rulelist=[1 1 1 1 1;    %�������һ�д������e��ģ�����룬�ڶ���Ϊec��ģ�����룬�������ġ����зֱ�Ϊ�����������ģ�����
              1 2 1 1 1;
              1 3 1 1 1;
              1 4 1 1 1;
              1 5 2 1 1;
              1 6 2 1 1;
              1 7 3 1 1;    
              
              2 1 1 1 1;
              2 2 1 1 1;
              2 3 2 1 1;
              2 4 2 1 1;
              2 5 2 1 1;
              2 6 3 1 1;
              2 7 3 1 1;

              3 1 2 1 1;
              3 2 2 1 1;
              3 3 2 1 1;
              3 4 3 1 1;
              3 5 3 1 1;
              3 6 3 1 1;
              3 7 4 1 1;

              4 1 3 1 1;
              4 2 3 1 1;
              4 3 4 1 1;
              4 4 4 1 1;
              4 5 4 1 1;
              4 6 5 1 1;
              4 7 5 1 1;

              5 1 4 1 1;
              5 2 5 1 1;
              5 3 5 1 1;
              5 4 5 1 1;
              5 5 5 1 1;
              5 6 6 1 1;
              5 7 6 1 1;

              6 1 5 1 1;
              6 2 5 1 1;
              6 3 6 1 1;
              6 4 6 1 1;
              6 5 6 1 1;
              6 6 7 1 1;
              6 7 7 1 1;
              
              7 1 5 1 1;
              7 2 6 1 1;
              7 3 6 1 1;
              7 4 7 1 1;
              7 5 7 1 1;
              7 6 7 1 1;
              7 7 7 1 1];
      
              
a=addrule(a,rulelist);  %��������
a=setfis(a,'DefuzzMethod','centroid');  %ʹ�����ķ���ģ��
writefis(a,'FuzzyInferenceSystem');  %��fuzzpid�����ֱ����aΪfis�ļ����ɹ�simulink�ȵ���

figure(1);plotmf(a,'input',1);
figure(2);plotmf(a,'input',2);
figure(3);plotmf(a,'output',1);

figure(4); gensurf(a);%ʹ��ǰ��������͵�һ����������ɸ���ģ������ϵͳ(fis)���������

figure(5);plotfis(a);

