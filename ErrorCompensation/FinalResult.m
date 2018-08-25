LoadData
load EC_LA.mat
FinalPred=TestingTem'-PE(1:6,:);
FinalPred=[FinalPred;TestingOxy'-PE(7:8,:)];
for i=1:6
    figure(i)
    plot(TestingTem(:,i),'-.')
    hold on
    plot(FinalPred(i,:))
    legend('Real','Prediction')
    xlim([1,3801])
    xlabel('Index')
    ylabel('Temperature (\circC)')
    grid on
    hold off
    set(gcf,'Position',[100,100,1100,400])
end

for i=7:8
    figure(i)
    plot(TestingOxy(:,i-6),'-.')
    hold on
    plot(FinalPred(i,:))
    legend('Real','Prediction')
    xlim([1,3801])
    xlabel('Index')
    ylabel('O_2 content (%)')
    grid on
    hold off
    set(gcf,'Position',[100,100,1100,400])
end

% 
% for i=1:1
%     figure(i+10)
%     plot(TestingTem(500:1000,i),'-.')
%     hold on
%     plot(FinalPred(i,500:1000))
%     legend('Real','Prediction')
%     xlim([1,500])
%     xlabel('Time Step','FontSize', 12)
%     ylabel('Temperature (\circC)','FontSize', 12)
%     grid on
%     hold off
%     set(gcf,'Position',[100,100,340,280])
% end
% set(gca,'fontname','times')  % Set it to times