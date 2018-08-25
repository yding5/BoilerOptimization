load Error.mat Er

Result=zeros(8,1);
Baseline=zeros(8,1);
    PE=Er;
    WindowSize=50;
    for ss=1:(3800-WindowSize)
        for ii=1:8
            PE(ii,ss+WindowSize)=PE(ii,ss+WindowSize)-mean(Er(ii,ss:ss+WindowSize-1));
        end
    end


for i=1:8
    Result(i,1)=mse(PE(i,2001:3801));
    Baseline(i,1)=mse(Er(i,2001:3801));
end
save EC_LA.mat Result Baseline PE
