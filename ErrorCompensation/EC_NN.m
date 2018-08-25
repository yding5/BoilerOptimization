load Error.mat Er

%PredTest=zeros(3799,8);
Result=zeros(4,8,12);
SizeValue=[1,5,10,20:10:100];
for nn=1:3:10
NeuronNumber=nn;
for i=1:8
    for ss=1:12
        size=SizeValue(ss);
        X=[];
        T=[];
        for sp=1:(2000-size)
            X=[X;Er(i,sp:sp+size-1)];
            T=[T;Er(i,sp+size)];
        end
        x=X';
        t=T';
        
        trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

    % Create a Fitting Network
    hiddenLayerSize = NeuronNumber;
    net = fitnet(hiddenLayerSize,trainFcn);
    
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    net.output.processFcns = {'removeconstantrows','mapminmax'};

    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 20/100;
    net.divideParam.testRatio = 0/100;

    net.performFcn = 'mse';  % Mean Squared Error

    % Train the Network
    [net,tr] = train(net,x,t);
        X=[];
        T=[];
        for sp=1:(1801-size)
            X=[X;Er(i,2000+sp:2000+sp+size-1)];
            T=[T;Er(i,sp+size)];
        end
        x=X';
        t=T';
        y = net(x);
        performance = perform(net,t,y);
    Result(nn,i,ss)=performance

    end
end
end
save EC_NN.mat Result

Best=zeros(8,1);
SelectedSize=zeros(8,1);
for i=1:8
    CurrentBest=1000;
    for j=1:3:10
        for k=1:12
            if CurrentBest>Result(j,i,k)
                CurrentBest=Result(j,i,k);
                SelectedSize(i,1)=SizeValue(k);
            end
        end
    end
    Best(i,1)=CurrentBest;
end
            