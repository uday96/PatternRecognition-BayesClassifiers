addr = 'G:\Acads\5th Sem\PR\Ass1\Dataset1\overlapping_data';
delimiterIn = ' ';

fields = (1:1:3);
values = cell(1,3);
Params_all = containers.Map(fields, values);
ConfusionMatrices = containers.Map(fields, values);
index = 1;
choose_num_clusters=zeros(3,2);

Datasets_train = cell(2,1);

filename = fullfile(addr,'class1_train.txt');
Datasets_train{1} = importdata(filename,delimiterIn);

filename = fullfile(addr,'class2_train.txt');
Datasets_train{2} = importdata(filename,delimiterIn);

filename = fullfile(addr,'class3_train.txt');
Datasets_train{3} = importdata(filename,delimiterIn);

filename = fullfile(addr,'class4_train.txt');
Datasets_train{4} = importdata(filename,delimiterIn);

for num_clusters = 2:2:6 
    
    [Wq1,Means1,Covar1] = EM(num_clusters,Datasets_train{1});
    [Wq2,Means2,Covar2] = EM(num_clusters,Datasets_train{2});
    [Wq3,Means3,Covar3] = EM(num_clusters,Datasets_train{3});
    [Wq4,Means4,Covar4] = EM(num_clusters,Datasets_train{4});
    
    field1 = 'mean';    field2 = 'covariance'; field3 = 'weights';
    values1 = {Means1,Means2,Means3,Means4};
    values2 = {Covar1,Covar2,Covar3,Covar4};
    values3 = [Wq1,Wq2,Wq3,Wq4];
    Params = struct(field1,values1,field2,values2,field3,values3);
        
    confusion_matrix = zeros(4);
    total_hits_test = 0;
    filename = fullfile(addr,'class1_val.txt');
    class_test = importdata(filename,delimiterIn);
    confusion_matrix(1,:) = assign_class_val(class_test,Params);
    total_hits_test = total_hits_test + sum(confusion_matrix(1,:));
    filename = fullfile(addr,'class2_val.txt');
    class_test = importdata(filename,delimiterIn);
    confusion_matrix(2,:) = assign_class_val(class_test,Params);
    total_hits_test = total_hits_test + sum(confusion_matrix(2,:));
    filename = fullfile(addr,'class3_val.txt');
    class_test = importdata(filename,delimiterIn);
    confusion_matrix(3,:) = assign_class_val(class_test,Params);
    total_hits_test = total_hits_test + sum(confusion_matrix(3,:));
    filename = fullfile(addr,'class4_val.txt');
    class_test = importdata(filename,delimiterIn);
    confusion_matrix(4,:) = assign_class_val(class_test,Params);
    total_hits_test = total_hits_test + sum(confusion_matrix(4,:));
    total_correct_hits_test = trace(confusion_matrix);
    accuracy_val = total_correct_hits_test/total_hits_test;
    choose_num_clusters(index,:) = [accuracy_val num_clusters ];
    ConfusionMatrices(index) = confusion_matrix;
    Params_all(index) = Params;
    index = index +1;
    if(accuracy_val == 1)
        break;
    end
end
fprintf('Accuracy vs Num_Clusters = \n\n');
disp(choose_num_clusters);

figure();
h = plot(choose_num_clusters(:,2),choose_num_clusters(:,1));
hold on
scatter(choose_num_clusters(:,2),choose_num_clusters(:,1),150,'filled', ...
       'MarkerFaceAlpha',3/8,'MarkerFaceColor',h.Color)         
hold off
title('Num of Clusters vs Accuracy');
xlabel('Number of Clusters');
ylabel('Accuracy');

[~,num_clusters] = sort(choose_num_clusters);
Sorted = choose_num_clusters(num_clusters,:);
l_k = length(Sorted(:,1))/2;
num_clusters = Sorted(l_k,2);
accu_val = Sorted(l_k,1);
fprintf('Number Of Clusters: %f\n\n',num_clusters);
fprintf('Confusion Matrix (val data) = \n\n');
disp(ConfusionMatrices((num_clusters-1)));
fprintf('Classification Accuracy on val data: %f\n',accu_val);

Params = Params_all(floor((num_clusters/2)));

Datasets_test = cell(2,1);
Means = cell(2,1);
Covars = cell(2,1);
Weights = cell(2,1);

[Weights{1},Weights{2},Weights{3},Weights{4}] = Params.weights;
[Means{1}, Means{2},Means{3}, Means{4}] = Params.mean;
[Covars{1}, Covars{2},Covars{3}, Covars{4}] = Params.covariance;

l_test = cell(2,1);

filename = fullfile(addr,'class1_test.txt');
Datasets_test{1} = importdata(filename,delimiterIn);
[l_test{1},~] = size(Datasets_test{1});

filename = fullfile(addr,'class2_test.txt');
Datasets_test{2} = importdata(filename,delimiterIn);
[l_test{2},~] = size(Datasets_test{1});

filename = fullfile(addr,'class3_test.txt');
Datasets_test{3} = importdata(filename,delimiterIn);
[l_test{3},~] = size(Datasets_test{1});

filename = fullfile(addr,'class4_test.txt');
Datasets_test{4} = importdata(filename,delimiterIn);
[l_test{4},~] = size(Datasets_test{1});

total_hits_test = 0;
confusion_matrix = zeros(4);

% Confusion Matrix Plot
L_test = l_test{1}+l_test{2}+l_test{3}+l_test{4};
global targetmatrix;
targetmatrix = zeros(4,L_test);
global outputmatrix;
outputmatrix = zeros(4,L_test);
global pointer;
pointer = 1;

for i=1:4
    confusion_matrix(i,:) = assign_class(Datasets_test{i},Weights,Means,Covars,i);
    total_hits_test = total_hits_test + sum(confusion_matrix(i,:));
end

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

figure();
plotconfusion(targetmatrix,outputmatrix);

figure();
% Decision Region Plot
X_Plot_range = -15:.1:20;
Y_Plot_range = -15:.1:20;
[X_plot,Y_plot] = meshgrid(X_Plot_range,Y_Plot_range);
mesh_xy = [X_plot(:) Y_plot(:)];

hold on;

for i=1:length(mesh_xy)
   X=mesh_xy(i,1:2);
   classassigns = zeros(1,4);
   for idx=1:4     
       classassigns(idx)=discriminant_func_GMM(X,Weights{idx},Means{idx},Covars{idx});
   end
   [~,classlabel]=max(classassigns);
     switch(classlabel)
         case 1
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'ys','MarkerFaceColor','y');
         case 2
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'cs','MarkerFaceColor','c');
         case 3
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'ws','MarkerFaceColor','w');
         case 4
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'gs','MarkerFaceColor','g');
     end
end

choosecolor = {'r';'b';'k';'m';};
for i=1:4
     plot(Datasets_train{i}(:,1),Datasets_train{i}(:,2), '.','color',choosecolor{i});
end
title('Decision region plot');
ylim=get(gca,'ylim');
xlim=get(gca,'xlim');
text(xlim(2)-3,ylim(2)-6.5,{'Actual: ',...
    '{\color{red} o } class1', '{\color{blue} o } class2', '{\color{black} o } class3', '{\color{magenta} o } class4',...
    '','Predicted: ',...
    '{\color{yellow} o } class1', '{\color{cyan} o } class2', '{\color{white} o } class3', '{\color{green} o } class4'}, ...
    'EdgeColor', 'k','BackgroundColor','w');


function no_of_assignments = assign_class(class_test,Weights,Means,Covars,Actualclasslabel)
    global outputmatrix;
    global targetmatrix;
    global pointer;
    l_test = length(class_test(:,1));
    no_of_assignments = zeros(1,4);
    actualclass = zeros(4,1);
    actualclass(Actualclasslabel) = 1;
    for i = 1:l_test
        outputmatrix(:,pointer) = actualclass;
        disc_val = zeros(1,4);
        X = class_test(i,:);
        disc_val(1) = discriminant_func_GMM(X,Weights{1},Means{1},Covars{1});
        disc_val(2) = discriminant_func_GMM(X,Weights{2},Means{2},Covars{2});
        disc_val(3) = discriminant_func_GMM(X,Weights{3},Means{3},Covars{3});
        disc_val(4) = discriminant_func_GMM(X,Weights{4},Means{4},Covars{4});
        [~,class_label] = max(disc_val);
        predictedclass = zeros(4,1);
        predictedclass(class_label) = 1;
        targetmatrix(:,pointer) = predictedclass;
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        pointer = pointer + 1;
    end
end                

function val = discriminant_func_GMM(x,Wqs,Means,CoVarMatrixs)
   %Bayes || GMM  || diff C 
   Q = size(Means);
   val = 0;
   for q = 1:Q
       Mean = Means(q); CoVarMatrix = CoVarMatrixs(q);
       val = val + (Wqs(q)*discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)); 
   end
   val = log(val);
end

function val = discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)
   %Bayes || GMM  || diff C 
   %val = (1/((det(CoVarMatrix))^(1/2)))*(exp(-(x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)/2)));
   val = mvnpdf(x,Mean,CoVarMatrix);
end

function no_of_assignments = assign_class_val(class_test,Params)
    l_test = length(class_test(:,1));
    no_of_assignments = zeros(1,4);
    [Wq1,Wq2,Wq3,Wq4] = Params.weights;
    [Means1, Means2,Means3, Means4] = Params.mean;
    [Covar1, Covar2,Covar3, Covar4] = Params.covariance;
    for i = 1:l_test
        disc_val = zeros(1,4);
        X = class_test(i,:);
        disc_val(1) = discriminant_func_GMM(X,Wq1,Means1,Covar1);
        disc_val(2) = discriminant_func_GMM(X,Wq2,Means2,Covar2);
        disc_val(3) = discriminant_func_GMM(X,Wq3,Means3,Covar3);
        disc_val(4) = discriminant_func_GMM(X,Wq4,Means4,Covar4);
        [~,class_label] = max(disc_val);
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        %fprintf('Assigning class %.0f to (%f,%f)\n',class_label,X(1),X(2));
    end
end        