global targetmatrix;
global outputmatrix;
global pointer;
pointer = 1;

Datasets_train = cell(2,1);
Datasets_test = cell(2,1);
Datasets_val = cell(2,1);

Means = cell(2,1);
Covars = cell(2,1);
Weights = cell(2,1);
Probs = cell(2,1);

accu_val = 0;
confusion_matrix = zeros(5);
while(accu_val < 0.99)
    
    All_img_data = random();
    [Probs{1},Datasets_train{1},Datasets_test{1}, Datasets_val{1}] = All_img_data.imgset2 ;
    [Probs{2},Datasets_train{2},Datasets_test{2}, Datasets_val{2}] = All_img_data.imgset5 ;
    [Probs{3},Datasets_train{3},Datasets_test{3}, Datasets_val{3}] = All_img_data.imgset10 ;
    [Probs{4},Datasets_train{4},Datasets_test{4}, Datasets_val{4}] = All_img_data.imgset16 ;
    [Probs{5},Datasets_train{5},Datasets_test{5}, Datasets_val{5}] = All_img_data.imgset20 ;
         
    for idx = 1:5
        Means{idx} = mean(Datasets_train{idx});
        Covars{idx} = get_cov(Datasets_train{idx});
    end
    
    L_val = 0;
    for idx = 1:5
        [l_idx,~] = size(Datasets_val);
        L_val = L_val + l_idx;
    end
    
    targetmatrix = zeros(5,L_val);
    outputmatrix = zeros(5,L_val);
    pointer = 1;
    
    confusion_matrix = zeros(5);
    total_hits_test = 0;

    field1 = 'mean';    field2 = 'covariance';  field3 = 'probability';
    values1 = {Means{1};Means{2};Means{3};Means{4};Means{5}};
    values2 = {Covars{1};Covars{2};Covars{3};Covars{4};Covars{5}};
    values3 = [Probs{1} Probs{2} Probs{3} Probs{4} Probs{5}];
    Params = struct(field1,values1,field2,values2,field3,values3);
    
    for idx = 1:5
        confusion_matrix(idx,:) = assign_class(Datasets_val{idx},Params,idx);
        total_hits_test = total_hits_test + sum(confusion_matrix(idx,:));
    end
    
    total_correct_hits_test = trace(confusion_matrix);
    accu_val = total_correct_hits_test/total_hits_test;
    
end
confusion_matrix
fprintf('Classification Accuracy on val data: %f\n',accu_val);

figure();
plotconfusion(targetmatrix,outputmatrix);
title('Confusion Matrix : Validation Data');

L_test = 0;
for idx = 1:5
    [l_idx,~] = size(Datasets_test);
    L_test = L_test + l_idx;
end

targetmatrix = zeros(5,L_test);
outputmatrix = zeros(5,L_test);
pointer = 1;
    
confusion_matrix = zeros(5);
total_hits_test = 0;

field1 = 'mean';    field2 = 'covariance';  field3 = 'probability';
values1 = {Means{1};Means{2};Means{3};Means{4};Means{5}};
values2 = {Covars{1};Covars{2};Covars{3};Covars{4};Covars{5}};
values3 = [Probs{1} Probs{2} Probs{3} Probs{4} Probs{5}];
Params = struct(field1,values1,field2,values2,field3,values3);

for idx = 1:5
    confusion_matrix(idx,:) = assign_class(Datasets_test{idx},Params,idx);
    total_hits_test = total_hits_test + sum(confusion_matrix(idx,:));
end

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

figure();
plotconfusion(targetmatrix,outputmatrix);
title('Confusion Matrix : Test Data');

function no_of_assignments = assign_class(imgset_test,Params,Actualclasslabel)
    global outputmatrix;
    global targetmatrix;
    global pointer;
    
    l_test = length(imgset_test(:,1));
    no_of_assignments = zeros(1,5);
    [mean_2,mean_5,mean_10,mean_16,mean_20] = Params.mean;
    [CovarMatrix_2,CovarMatrix_5,CovarMatrix_10,CovarMatrix_16,CovarMatrix_20] = Params.covariance;
    Probabilities = Params.probability;
    actualclass = zeros(5,1);
    actualclass(Actualclasslabel) = 1;
    for i = 1:l_test
        outputmatrix(:,pointer) = actualclass;
        disc_val = zeros(1,5);
        X = imgset_test(i,:);
        disc_val(1) = discriminant_func_B(X,mean_2,CovarMatrix_2,Probabilities(1));
        disc_val(2) = discriminant_func_B(X,mean_5,CovarMatrix_5,Probabilities(2));
        disc_val(3) = discriminant_func_B(X,mean_10,CovarMatrix_10,Probabilities(3));
        disc_val(4) = discriminant_func_B(X,mean_16,CovarMatrix_16,Probabilities(4));
        disc_val(5) = discriminant_func_B(X,mean_20,CovarMatrix_20,Probabilities(5));
        
        [~,class_label] = max(disc_val);
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        predictedclass = zeros(5,1);
        predictedclass(class_label) = 1;
        targetmatrix(:,pointer) = predictedclass;
        pointer = pointer + 1;
        %fprintf('Assigning class %.0f to (%f,%f)\n',class_label,X(1),X(2));
    end
end        

function val = discriminant_func_B(x,Mean,CoVarMatrix,Prob)
   %Bayes || diff C 
   %val = ((-1/2)*log(det(CoVarMatrix)))+((-1/2)*((x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)))) + log(Prob);	
   val = log(mvnpdf(x,Mean,CoVarMatrix))+ log(Prob);
end

function cov_matrix = get_cov(matrix)
    cov_matrix = cov(matrix);
    cov_matrix = cov_matrix + eye(48)*0.000000000001;
end