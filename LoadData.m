%% Genernate Dataset
% Genernate training dataset, the number in suffix denote data from how
% many time steps was used.
% "0" is a special case as it denote it contain only control variables
% without measured value of temperature and oxygen content.

% Throttle openings: column 33-48
% Coal feed rate: column 21-32
% Left NOx, Right NOx: column 19-20
% Left Oxy, Right Oxy: column 17-18
% Temp: column 1-6
% Temp difference: column 7-12
% Avg. Temp: column 13
% #1 Hot Wind: column 15
% #1 Cold Wind: column 16
% Generation load: column 14

load FirstPart.txt
load SecondPart.txt
%% Training dataset
TrainingDataset_0=FirstPart(6:7506,[14:16,19:end]);
TrainingDataset_1=FirstPart(6:7506,:);

for i=1:5
    eval(['TrainingDataset_',num2str(i+1),'=[TrainingDataset_',num2str(i),',FirstPart(',num2str(6-i),':',num2str(7506-i),',:)];'])
end
% Prediction target
TrainingTem=FirstPart(7:end,1:6);
TrainingOxy=FirstPart(7:end,17:18);
%% Testing dataset
TestingDataset_0=SecondPart(6:3806,[14:16,19:end]);
TestingDataset_1=SecondPart(6:3806,:);

for i=1:5
    eval(['TestingDataset_',num2str(i+1),'=[TestingDataset_',num2str(i),',SecondPart(',num2str(6-i),':',num2str(3806-i),',:)];'])
end
% Prediction target
TestingTem=SecondPart(7:end,1:6);
TestingOxy=SecondPart(7:end,17:18);
