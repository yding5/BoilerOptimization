load Error.mat Er
LoadData

PredTest=zeros(1801,6);
Result=zeros(6,1);
for i=1:6
x=TestingDataset_4;
x=x(1:2000,:);
t=Er';
t=t(1:2000,i);

mdl = fitrsvm(x,t,'KernelFunction','rbf','Standardize',true,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    'expected-improvement-plus'));

x=TestingDataset_4;
x=x(2001:3801,:);
t=Er';
t=t(2001:3801,i);

PredTest(:,k)=predict(mdl,x);
TEerror=PredTest(:,k)-t;
Result(i,1)=mse(TEerror);
end