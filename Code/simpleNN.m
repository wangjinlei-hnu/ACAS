%[x,t] = simplefit_dataset;
load('training_data.mat');

beta = beta';
delta = delta';
Tspeed = Tspeed';
Vx = Vx';
Vy = Vy';
yawrate = yawrate';

x = [beta(1:20000); delta(1:20000); Tspeed(1:20000); Vx(1:20000); Vy(1:20000); yawrate(1:20000)];  %将输入变成多维度就可以了。
t = Vx(2:20001);

net = fitnet(20);

net.trainParam.goal = 1e-9;      %目标误差
net.trainParam.epochs = 5e8;   %训练时间
net.trainParam.mc = 0.95;        %动量参数

net = train(net,x,t); %根据x的维度，网络将自己配置；
%gensim(net);  %生成Simulink模块
%save CarSimModelNet net;

y = net(x);
perf = perform(net,y,t);

figure(1);
plot(t,'-.'); hold on;
plot(y,'--'); hold off;
legend ('t','y');

figure(2);
plot(y-t);



