%% Selection Parameter using Bayes optimization
LoadDataM
SR=cell(10,3);

Result=zeros(6,2);
PredTrain=zeros(7497,6); %PredictionOnTraingDataset
PredTest=zeros(3797,6);  %PredictionOnTestingDataset

save O_SVR_R_3.mat Result;

%KernelScaleValue=[4.940525880501587,5.056732588650018,4.556256055727313,4.805718657286466,4.749082872981815,4.850599427524610];
iValue=[0,1,2,3,4,5,6,7,8,9,10];
%CValue=[100,100,60,60,60,100];
for ii=7:10
for k=1:2
        %C=CValue(k);
        i=iValue(ii);
        %KernelScale=KernelScaleValue(k);
        
        eval(['x=TrainingDataset_',num2str(i),';',]);
        t=TrainingOxy(:,k);
        
        %x=x(1:t1*1500+1,:);
        %t=t(1:t1*1500+1,:);
        
        %mdl = fitrsvm(x,t,'KernelFunction','rbf','KernelScale',KernelScale,'Standardize',true,'BoxConstraint',C);
        mdl = fitrsvm(x,t,'KernelFunction','rbf','Standardize',true,'OptimizeHyperparameters',{'BoxConstraint','Epsilon', 'KernelScale'},...
    'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus','KFold',10,'ShowPlots',0));
        PredTrain(:,k)=predict(mdl,x);
        TRerror=PredTrain(:,k)-t;
        Result(k,1)=mse(TRerror(:,:));
        %Save model
        
        eval(['mdl',num2str(k),'=mdl']);
        %eval(['save O_SVR_R_2.mat mdl',num2str(k),' -append']);

        %Test
        eval(['x=TestingDataset_',num2str(i),';',]);
        t=TestingOxy(:,k);
        PredTest(:,k)=predict(mdl,x);
        TEerror=PredTest(:,k)-t;
        Result(k,2)=mse(TEerror);
end
SR{ii,1}=mdl1;
SR{ii,2}=mdl2;
SR{ii,3}=Result;
save O_SVR_R_3.mat SR -append;
end