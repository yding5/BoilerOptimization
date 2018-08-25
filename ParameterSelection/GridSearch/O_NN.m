%% Cross-validation of NN
LoadData
% Genernater index for cross-validation 
ind=(1:7500)';
indices=crossvalind('Kfold',ind,10);

Result=zeros(20,10);
for k=1:2
    for i=0:6
        for n=1:10
            NeuronNumber=n;
            CrossValidationError=0;%reset
            for j=1:10
                % Select samples
                CurrentTestInd=find(indices==j);
                CurrentTrVaInd=find(indices~=j);
                % Divide training dataset into two part for using of Early
                % Stop
                [rn,~]=size(CurrentTrVaInd);
                RP=randperm(rn,rn);
                CurrentTrainInd=CurrentTrVaInd(RP(1:floor(0.8*rn)),:);
                CurrentValidInd=CurrentTrVaInd(RP(floor(0.8*rn))+1:rn,:);
                
                % input and target
                eval(['x=TrainingDataset_',num2str(i),''';',]);
                t=TrainingOxy(:,k)';
                     
                trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.
                
                % Create a Fitting Network
                hiddenLayerSize = NeuronNumber;
                net = fitnet(hiddenLayerSize,trainFcn);
                
                % Choose Input and Output Pre/Post-Processing Functions
                % For a list of all processing functions type: help nprocess
                net.input.processFcns = {'removeconstantrows','mapminmax'};
                net.output.processFcns = {'removeconstantrows','mapminmax'};
                
                % Setup Division of Data for Training, Validation, Testing              
                TrInd=CurrentTrainInd;
                VaInd=CurrentValidInd;
                TeInd=CurrentTestInd;
                
                net.divideFcn = 'divideind';  % Divide data randomly
                net.divideMode = 'sample';  % Divide up every sample
                net.divideParam.trainInd = TrInd;
                net.divideParam.valInd = VaInd;
                net.divideParam.testInd = TeInd;
               
                net.performFcn = 'mse';  % Mean Squared Error
                
                % Train the Network
                [net,tr] = train(net,x,t);
                
                % Test the Network
                y = net(x);
                e = gsubtract(t,y);
                
                % Recalculate Training, Validation and Test Performance
                trainTargets = t .* tr.trainMask{1};
                valTargets = t .* tr.valMask{1};
                testTargets = t .* tr.testMask{1};
                trainPerformance = perform(net,trainTargets,y);
                valPerformance = perform(net,valTargets,y);
                testPerformance = perform(net,testTargets,y);
                
                CrossValidationError=CrossValidationError+testPerformance;
                
            end
            CrossValidationError=CrossValidationError/10;
            Result((k-1)*10+n,i+1)=CrossValidationError;
        end
    end
end

save O_NN.mat Result 
