clear all

load O_SVR_L_C.mat mdl1
load O_SVR_L_C.mat mdl2
mdl7=mdl1;
mdl8=mdl2;
load T_SVR_L_C.mat mdl1
load T_SVR_L_C.mat mdl2
load T_SVR_L_C.mat mdl3
load T_SVR_L_C.mat mdl4
load T_SVR_L_C.mat mdl5
load T_SVR_L_C.mat mdl6

LoadData

x4=TestingDataset_4;
x3=TestingDataset_3;
Er=zeros(8,3801);
Er(1,:)=(TestingTem(:,1)-predict(mdl1,x4))';
Er(2,:)=(TestingTem(:,2)-predict(mdl2,x4))';
Er(3,:)=(TestingTem(:,3)-predict(mdl3,x4))';
Er(4,:)=(TestingTem(:,4)-predict(mdl4,x4))';
Er(5,:)=(TestingTem(:,5)-predict(mdl5,x3))';
Er(6,:)=(TestingTem(:,6)-predict(mdl6,x4))';
Er(7,:)=(TestingOxy(:,1)-predict(mdl7,x4))';
Er(8,:)=(TestingOxy(:,2)-predict(mdl8,x4))';

save Error.mat Er