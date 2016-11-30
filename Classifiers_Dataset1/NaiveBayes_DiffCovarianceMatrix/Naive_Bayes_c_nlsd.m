% Naive Bayes Classifier
% Non Linearly Seperable Data
% different Covariance Matrix

addr = 'G:\Acads\5th Sem\PR\Ass1\Dataset1\non_linearly_seperable_data';
delimiterIn = ' ';

Datasets_train = cell(2,1);
Datasets_test = cell(2,1);
Means = cell(2,1);
Covars = cell(2,1);

filename = fullfile(addr,'class1_train.txt');
Datasets_train{1} = importdata(filename,delimiterIn);
Means{1} = mean(Datasets_train{1});
Covars{1} = get_cov(Datasets_train{1});

filename = fullfile(addr,'class2_train.txt');
Datasets_train{2} = importdata(filename,delimiterIn);
Means{2} = mean(Datasets_train{2});
Covars{2} = get_cov(Datasets_train{2});

l_test = cell(2,1);

filename = fullfile(addr,'class1_test.txt');
Datasets_test{1} = importdata(filename,delimiterIn);
[l_test{1},~] = size(Datasets_test{1});

filename = fullfile(addr,'class2_test.txt');
Datasets_test{2} = importdata(filename,delimiterIn);
[l_test{2},~] = size(Datasets_test{2});

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

for i=1:2
    confusion_matrix(i,:) = assign_class(Datasets_test{i},Means,Covars,i);
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
   classassigns = zeros(1,2);
   for idx=1:2     
       classassigns(idx)=discriminant_func(X,Means{idx},Covars{idx});
   end
   [~,classlabel]=max(classassigns);
     switch(classlabel)
         case 1
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'ys','MarkerFaceColor','y');
         case 2
            plot(mesh_xy(i,1),mesh_xy(i,2) ,'cs','MarkerFaceColor','c');
     end
end

choosecolor = {'r';'b';};
for i=1:2
     plot(Datasets_train{i}(:,1),Datasets_train{i}(:,2), '.','color',choosecolor{i});
end
title('Decision region plot');
ylim=get(gca,'ylim');
xlim=get(gca,'xlim');
text(xlim(2)-3,ylim(2)-4,{'Actual: '...
        '{\color{red} o } class1', '{\color{blue} o } class2',...
        '','Predicted: ',...
        '{\color{yellow} o } class1', '{\color{cyan} o } class2'},...
        'EdgeColor', 'k','BackgroundColor','w');

function no_of_assignments = assign_class(class_test,Means,Covars,Actualclasslabel)
    global outputmatrix;
    global targetmatrix;
    global pointer;
    l_test = length(class_test(:,1));
    no_of_assignments = zeros(1,2);
    actualclass = zeros(2,1);
    actualclass(Actualclasslabel) = 1;
    for i = 1:l_test
        outputmatrix(:,pointer) = actualclass;
        disc_val = zeros(1,2);
        X = class_test(i,:);
        disc_val(1) = discriminant_func(X,Means{1},Covars{1});
        disc_val(2) = discriminant_func(X,Means{2},Covars{2});
        [~,class_label] = max(disc_val);
        predictedclass = zeros(2,1);
        predictedclass(class_label) = 1;
        targetmatrix(:,pointer) = predictedclass;
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        pointer = pointer + 1;
    end
end        

function val = discriminant_func(x,Mean,CoVarMatrix)
   %Naive-Bayes || same C || c = sigma^2I
   %val = ((-1/2)*((x-Mean)*(transpose(x-Mean))));	
   val = log(mvnpdf(x,Mean,CoVarMatrix));
end

function covarmatrix = get_cov(arr) 
    Var_train = var(arr,1);
    covarmatrix = zeros(2);
    for i = 1:2
        covarmatrix(i,i) = Var_train(i);
    end
end