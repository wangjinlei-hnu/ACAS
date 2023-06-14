%[x,t] = simplefit_dataset;
load('training_data.mat');

beta = beta';
delta = delta';
Tspeed = Tspeed';
Vx = Vx';
Vy = Vy';
yawrate = yawrate';

x = [beta(1:20000); delta(1:20000); Tspeed(1:20000); Vx(1:20000); Vy(1:20000); yawrate(1:20000)];  %�������ɶ�ά�ȾͿ����ˡ�
t = Vx(2:20001);

net = fitnet(20);

net.trainParam.goal = 1e-9;      %Ŀ�����
net.trainParam.epochs = 5e8;   %ѵ��ʱ��
net.trainParam.mc = 0.95;        %��������

net = train(net,x,t); %����x��ά�ȣ����罫�Լ����ã�
%gensim(net);  %����Simulinkģ��
%save CarSimModelNet net;

y = net(x);
perf = perform(net,y,t);

figure(1);
plot(t,'-.'); hold on;
plot(y,'--'); hold off;
legend ('t','y');

figure(2);
plot(y-t);



