%[x,t] = simplefit_dataset;
 Data = load('V50U35.mat');
% Data = load('V60U65.mat');
% Data = load('V70U95.mat');
The_Actual_State = Data.The_Actual_State;

beta = The_Actual_State(:,1)';
delta = The_Actual_State(:,2)';
Tspeed = The_Actual_State(:,3)'*1.2;
Vx = The_Actual_State(:,4)';
Vy = The_Actual_State(:,5)';
yawrate = The_Actual_State(:,6)';

s = length(yawrate);

x = [beta(1:s-1); delta(1:s-1); Tspeed(1:s-1); Vx(1:s-1); Vy(1:s-1); yawrate(1:s-1)];  %将输入变成多维度就可以了。
t = Vx(2:s);

load V_Net.mat

V_Net.trainParam.goal = 1e-3;      %目标误差
V_Net.trainParam.epochs = 5e8;   %训练时间
V_Net.trainParam.mc = 0.95;        %动量参数
V_Net.trainParam.max_fail=10; 
%predict and trained on-line

% y = zeros(s-9,1);

% for i = 10:s-2
%    
%    % predict 
%    y(i-9) = V_Net(x(:,i));
%    
%    % Load the latest data and train 
% %    Train_Data = x(:,i-9:i-1); 
% %    Target = t(i-8:i);
% %    V_Net = train(V_Net,Train_Data,Target); 
%    
% end

y = V_Net(x);

perf = perform(V_Net,y,t);

y = y(1:11800);
t = t(1:11800);

figure(1);
plot(t,'-.'); hold on;
plot(y,'--'); hold off;
legend ('t','y');

figure(2);
plot(y-t);




