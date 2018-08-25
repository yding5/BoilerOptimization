%% Genernate Dataset
% Genernate training dataset, the number in suffix denote data from how
% many time steps was used.
% "0" is a special case as it denote it contain only control variables
% without measured value of temperature and oxygen content.
load FirstPart.txt
load SecondPart.txt
% Training dataset
TrainingDataset_0=FirstPart(10:7506,[14:16,19:end]);
TrainingDataset_1=FirstPart(10:7506,:);

for i=1:9
    eval(['TrainingDataset_',num2str(i+1),'=[TrainingDataset_',num2str(i),',FirstPart(',num2str(10-i),':',num2str(7506-i),',:)];'])
end
% Prediction target
TrainingTem=FirstPart(11:end,1:6);
TrainingOxy=FirstPart(11:end,17:18);
% Testing dataset
TestingDataset_0=SecondPart(10:3806,[14:16,19:end]);
TestingDataset_1=SecondPart(10:3806,:);

for i=1:9
    eval(['TestingDataset_',num2str(i+1),'=[TestingDataset_',num2str(i),',SecondPart(',num2str(10-i),':',num2str(3806-i),',:)];'])
end
% Prediction target
TestingTem=SecondPart(11:end,1:6);
TestingOxy=SecondPart(11:end,17:18);