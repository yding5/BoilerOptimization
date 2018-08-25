load Error.mat Er
LoadData

Result=zeros(8,12);
SizeValue=[1,5,10,20:10:100];

for i=1:8
    for ss=1:12
        size=SizeValue(ss);
        X=[];
        T=[];
        for sp=1:(2000-size)
            X=[X;Er(i,sp:sp+size-1)];
            T=[T;Er(i,sp+size)];
        end
        x=X;
        t=T;
        
        mdl = fitrsvm(x,t,'KernelFunction','linear','Standardize',true,'OptimizeHyperparameters','auto',...
            'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
            'expected-improvement-plus'));
        X=[];
        T=[];
        for sp=1:(1801-size)
            X=[X;Er(i,2000+sp:2000+sp+size-1)];
            T=[T;Er(i,sp+size)];
        end
        x=X;
        t=T;
        
        PredTest=predict(mdl,x);
        TEerror=PredTest-t;
        Result(i,ss)=mse(TEerror);
    end
end
save EC_SVR_L_Single.mat Result