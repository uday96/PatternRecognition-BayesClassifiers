%KNN
%Non Linearly Seperable Data

addr = 'G:\Acads\5th Sem\PR\Ass1\Dataset1\non_linearly_seperable_data';
delimiterIn = ' ';

Datasets_train = cell(2,1);
Datasets_test = cell(2,1);
Datasets_val = cell(2,1);

filename = fullfile(addr,'class1_train.txt');
Datasets_train{1} = importdata(filename,delimiterIn);

filename = fullfile(addr,'class2_train.txt');
Datasets_train{2} = importdata(filename,delimiterIn);

choose_k = [];
K_val = 0;
for K = 25:2:50
    
    no_of_assignments = zeros(2);
    total_hits = 0;
    
    filename = fullfile(addr,'class1_val.txt');
    Datasets_val{1} = importdata(filename,delimiterIn);

    filename = fullfile(addr,'class2_val.txt');
    Datasets_val{2} = importdata(filename,delimiterIn);
    
    for i = 1:2
        no_of_assignments(i,:) = knn_val(K,Datasets_val{i},Datasets_train);
        total_hits = total_hits + sum(no_of_assignments(i,:));
    end
    
    total_correct_hits = trace(no_of_assignments);
    accuracy = total_correct_hits/total_hits;
    choose_k = [choose_k; accuracy K];
%     if(accuracy == 1)
%         K_val = K;
%         break;
%     end
end
if(K_val == 0)
    [accu,K_order] = sort(choose_k);
    K_sorted = choose_k(K_order,:);
    l_k = length(K_sorted(:,1))/2;
    K_val = K_sorted(l_k,2);
    acc_val = K_sorted(l_k,1);
    fprintf('Ideal value of K : %.0f\n',K_val);
    fprintf('Accuracy for value of K : %f\n',acc_val);
else
    fprintf('Ideal value of K : %.0f\n',K_val);
    fprintf('Accuracy for value of K : %f\n',1);
end

figure();
h = plot(choose_k(:,2),choose_k(:,1));
hold on
scatter(choose_k(:,2),choose_k(:,1),150,'filled', ...
       'MarkerFaceAlpha',3/8,'MarkerFaceColor',h.Color)         
hold off
title('K vs Accuracy');
xlabel('K');
ylabel('Accuracy');

l_test = cell(2,1);

filename = fullfile(addr,'class1_test.txt');
Datasets_test{1} = importdata(filename,delimiterIn);
[l_test{1},~] = size(Datasets_test{1});

filename = fullfile(addr,'class2_test.txt');
Datasets_test{2} = importdata(filename,delimiterIn);
[l_test{2},~] = size(Datasets_test{1});

total_hits_test = 0;
confusion_matrix = zeros(2);

% Confusion Matrix Plot
L_test = l_test{1}+l_test{2};
global targetmatrix;
targetmatrix = zeros(2,L_test);
global outputmatrix;
outputmatrix = zeros(2,L_test);
global pointer;
pointer = 1;

for i = 1:2
    confusion_matrix(i,:) = knn(K_val,Datasets_test{i},Datasets_train,i);
    total_hits_test = total_hits_test + sum(confusion_matrix(i,:));
end

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

figure()
plotconfusion(targetmatrix,outputmatrix);

figure();
hold on;

%Regional Decision Plots.
X_Plot_range = -15:.1:20;
Y_Plot_range = -15:.1:20;
[X_plot,Y_plot] = meshgrid(X_Plot_range,Y_Plot_range);
[rows,cols] = size(X_plot);
fields = (1:1:2);
values = cell(1,2);
plot_class = containers.Map(fields, values);
for ro = 1:rows
    for co = 1:cols
        X = [X_plot(ro,co) Y_plot(ro,co)];
        x1 = X(1); y1 = X(2);
        dis = [];
        values_train = {Datasets_train{1},Datasets_train{2}};
        plot_train = containers.Map(fields, values_train);
        for n = 1:2
            class_train = plot_train(n);
            ln_train = length(class_train(:,1));
            dis = [dis; dist(x1,y1,class_train,ln_train,n)];
        end
        [~, order] = sort(dis(:,1));
        sorted_dis = dis(order,:);
        class_hits = zeros(1,2);
        for j = 1:K_val
            cls = sorted_dis(j,2);
            weight = sorted_dis(j,1);
            class_hits(cls) = class_hits(cls) + 1/weight;
        end
        [~,ind] = max(class_hits);
        plot_class(ind) = [plot_class(ind); X]; 
    end
end
% figure();
class1 = plot_class(1);class2 = plot_class(2);
plot (class1(:,1),class1(:,2),'y.',class2(:,1),class2(:,2),'c.');

plot (Datasets_train{1}(:,1),Datasets_train{1}(:,2),'r.',Datasets_train{2}(:,1),Datasets_train{2}(:,2),'b.');
title('Decision Region Plot');

ylim=get(gca,'ylim');
xlim=get(gca,'xlim');
text(xlim(2)-3,ylim(2)-4,{'Actual: '...
        '{\color{red} o } class1', '{\color{blue} o } class2',...
        '','Predicted: ',...
        '{\color{yellow} o } class1', '{\color{cyan} o } class2'},...
        'EdgeColor', 'k','BackgroundColor','w');