load('plots.mat');
figure()
hold on;
plot(FAR_mat(:,1),FAR_mat(:,2),'r',FRR_mat(:,1),FRR_mat(:,2),'b');
legend('FRR','FAR');
title('FRR - FAR Curve');
xlabel('Accuracy');