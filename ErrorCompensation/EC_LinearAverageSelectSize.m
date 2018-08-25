load Error.mat Er

Result=zeros(59,18);
SizeValue=[1:10,20:10:500];
for i=1:59
    PE=Er;
    WindowSize=SizeValue(i);
    for ss=1:(2000-WindowSize)
        for ii=1:8
            PE(ii,ss+WindowSize)=PE(ii,ss+WindowSize)-mean(Er(ii,ss:ss+WindowSize-1));
        end
    end
    Result(i,:)=[SizeValue(i),0,mse(PE(1,(WindowSize+1):2000)),mse(PE(2,(WindowSize+1):2000)),mse(PE(3,(WindowSize+1):2000)),mse(PE(4,(WindowSize+1):2000)),mse(PE(5,(WindowSize+1):2000)),mse(PE(6,(WindowSize+1):2000)),mse(PE(7,(WindowSize+1):2000)),mse(PE(8,(WindowSize+1):2000)),mse(Er(1,(WindowSize+1):2000)),mse(Er(2,(WindowSize+1):2000)),mse(Er(3,(WindowSize+1):2000)),mse(Er(4,(WindowSize+1):2000)),mse(Er(5,(WindowSize+1):2000)),mse(Er(6,(WindowSize+1):2000)),mse(Er(7,(WindowSize+1):2000)),mse(Er(8,(WindowSize+1):2000))];

end
Reduce=Result(:,11:18)-Result(:,3:10);
save EC_LA_SelectSize.mat Result