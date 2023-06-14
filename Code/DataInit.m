clear all;

time = 0:0.1:50-0.1;
sinewave = sin(time);
coswave = cos(time);

sinesignal = [time; sinewave]'; % 需要转置一下，不然导入simulink会出问题
cossignal = [time; coswave]';

plot(sinewave); hold on;
plot(coswave);


% load training_data;
% TrainingData = [Tspeed'; Vx';  Vy'; beta'; delta';  yawrate']';
% save training_dataS TrainingData;