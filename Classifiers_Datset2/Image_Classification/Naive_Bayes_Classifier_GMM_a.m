All_img_data = random();
[prior_prob_2,imgset2_train,imgset2_test] = All_img_data.imgset2 ;
[prior_prob_5,imgset5_train,imgset5_test] = All_img_data.imgset5 ;
[prior_prob_10,imgset10_train,imgset10_test] = All_img_data.imgset10 ;
[prior_prob_16,imgset16_train,imgset16_test] = All_img_data.imgset16 ;
[prior_prob_20,imgset20_train,imgset20_test] = All_img_data.imgset20 ;

num_clusters = 5;
[Wq_2,Means_2,Covar_2] = EM(num_clusters,imgset2_train);
[Wq_5,Means_5,Covar_5] = EM(num_clusters,imgset5_train);
[Wq_10,Means_10,Covar_10] = EM(num_clusters,imgset10_train);
[Wq_16,Means_16,Covar_16] = EM(num_clusters,imgset16_train);
[Wq_20,Means_20,Covar_20] = EM(num_clusters,imgset20_train);

confusion_matrix = zeros(5);
total_hits_test = 0;

field1 = 'mean';    field2 = 'covariance';  field3 = 'probability'; field4 = 'weights';
values1 = {Means_2;Means_5;Means_10;Means_16;Means_20};
values2 = {Covar_2;Covar_5;Covar_10;Covar_16;Covar_20};
values3 = [prior_prob_2 prior_prob_5 prior_prob_10 prior_prob_16 prior_prob_20];
values4 = [Wq_2,Wq_5,Wq_10,Wq_16,Wq_20];
Params = struct(field1,values1,field2,values2,field3,values3,field4,values4);

confusion_matrix(1,:) = assign_class(imgset2_test,Params);
total_hits_test = total_hits_test + sum(confusion_matrix(1,:));
confusion_matrix(2,:) = assign_class(imgset5_test,Params);
total_hits_test = total_hits_test + sum(confusion_matrix(2,:));
confusion_matrix(3,:) = assign_class(imgset10_test,Params);
total_hits_test = total_hits_test + sum(confusion_matrix(3,:));
confusion_matrix(4,:) = assign_class(imgset16_test,Params);
total_hits_test = total_hits_test + sum(confusion_matrix(4,:));
confusion_matrix(5,:) = assign_class(imgset20_test,Params);
total_hits_test = total_hits_test + sum(confusion_matrix(5,:));

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

function no_of_assignments = assign_class(imgset_test,Params)
    l_test = length(imgset_test(:,1));
    no_of_assignments = zeros(1,5);
    [Means_2,Means_5,Means_10,Means_16,Means_20] = Params.mean;
    [Covar_2,Covar_5,Covar_10,Covar_16,Covar_20] = Params.covariance;
    Probabilities = Params.probability;
    [Wq_2,Wq_5,Wq_10,Wq_16,Wq_20] = Params.weights;
    for i = 1:l_test
        disc_val = zeros(1,5);
        X = imgset_test(i,:);
        disc_val(1) = discriminant_func_GMM(X,Wq_2,Means_2,Covar_2,Probabilities(1));
        disc_val(2) = discriminant_func_GMM(X,Wq_5,Means_5,Covar_5,Probabilities(2));
        disc_val(3) = discriminant_func_GMM(X,Wq_10,Means_10,Covar_10,Probabilities(3));
        disc_val(4) = discriminant_func_GMM(X,Wq_16,Means_16,Covar_16,Probabilities(4));
        disc_val(5) = discriminant_func_GMM(X,Wq_20,Means_20,Covar_20,Probabilities(5));
        [~,class_label] = max(disc_val);
        %disp(disc_val);
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        %fprintf('Assigning class %.0f to (%f,%f)\n',class_label,X(1),X(2));
    end
end        

function val = discriminant_func_GMM(x,Wqs,Means,CoVarMatrixs,Prob)
   %Bayes || diff C 
   Q = size(Means);
   val = 0;
   for q = 1:Q
       Mean = Means(q); CoVarMatrix = CoVarMatrixs(q);
       val = val + (Wqs(q)*discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)); 
   end
   %val = val*Prob;
   val = log(val) + log(Prob); 
end
function val = discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)
   %Bayes || diff C 
   [ncov,~] = size(CoVarMatrix);
   COVM = zeros(ncov,ncov);
   for cc = 1:ncov
       COVM(cc,cc) = CoVarMatrix(cc,cc);
   end
    %val = (1/((det(CoVarMatrix))^(1/2)))*(exp(-(x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)/2)));
    val = mvnpdf(x,Mean,CoVarMatrix);
end