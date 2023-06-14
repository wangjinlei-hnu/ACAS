%模糊控制器建立
%本控制器用驾驶员模型
%模糊输出变量前轮转向角
% clear;
% close all;

a=newfis('fuzzpid'); %定义一个新的模糊控制器

a=addvar(a,'input','e_v',[-4,4]);                        %Parameter e  %输入误差的为滑动率与理想值的差  清晰变量到模糊变量还需要额外映射一下
a=addmf(a,'input',1,'NB','zmf',[-4,-2]);
a=addmf(a,'input',1,'NM','trimf',[-3,-1.7,-0.5]);
a=addmf(a,'input',1,'NS','trimf',[-2,-0.7,0]);
a=addmf(a,'input',1,'ZO','trimf',[-0.5,0,0.5]);
a=addmf(a,'input',1,'PS','trimf',[0,0.7,2]);
a=addmf(a,'input',1,'PM','trimf',[0.5,1.7,3]);
a=addmf(a,'input',1,'PB','smf',[2,4]);

a=addvar(a,'input','ec_v',[-4,4]);                       %Parameter ec  滑动率误差的变化率
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

rulelist=[1 1 1 1 1;    %这里面第一列代表的是e的模糊输入，第二列为ec的模糊输入，第三、四、五列分别为三个输出量的模糊输出
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
      
              
a=addrule(a,rulelist);  %加入规则表
a=setfis(a,'DefuzzMethod','centroid');  %使用重心法解模糊
writefis(a,'FuzzyInferenceSystem');  %以fuzzpid的名字保存的a为fis文件，可供simulink等调用

figure(1);plotmf(a,'input',1);
figure(2);plotmf(a,'input',2);
figure(3);plotmf(a,'output',1);

figure(4); gensurf(a);%使用前两个输入和第一个输出来生成给定模糊推理系统(fis)的输出曲面

figure(5);plotfis(a);

