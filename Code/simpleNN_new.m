%[x,t] = simplefit_dataset;
V50U35 = load('V50U35.mat');
V60U65 = load('V60U65.mat');
V70U95 = load('V70U95.mat');

AS = [V50U35.The_Actual_State;V60U65.The_Actual_State;V70U95.The_Actual_State];

beta = AS(:,1)';
delta = AS(:,2)';
Tspeed = AS(:,3)';
Vx = AS(:,4)';
Vy = AS(:,5)';
yawrate = AS(:,6)';

x = [beta(1:22535); delta(1:22535); Tspeed(1:22535); Vx(1:22535); Vy(1:22535); yawrate(1:22535)];  %�������ɶ�ά�ȾͿ����ˡ�
t = Vx(2:22536);

V_Net = fitnet(20);

V_Net.trainParam.goal = 1e-5;      %Ŀ�����
V_Net.trainParam.epochs = 5e8;   %ѵ��ʱ��
V_Net.trainParam.mc = 0.95;        %��������
V_Net.trainParam.max_fail=100; 
V_Net = train(V_Net,x,t); %����x��ά�ȣ����罫�Լ����ã�
%gensim(V_Net);  %����Simulinkģ��
%save CarSimModelV_Net V_Net;

y = V_Net(x);
perf = perform(V_Net,y,t);

figure(1);
plot(t,'-.'); hold on;
plot(y,'--'); hold off;
legend ('t','y');

figure(2);
plot(y-t);

save V_Net V_Net


