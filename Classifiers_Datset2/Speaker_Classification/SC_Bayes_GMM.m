load('xyz.mat');

global targetmatrix;
global outputmatrix;
global pointer;
pointer = 1;

confusion_matrix = zeros(10);
total_hits_test = 0;
for i = 1:10
    confusion_matrix(i,:) = assign_class(Datasets_test(i),Weights,Means,Covars,PriorProbs,i);
    total_hits_test = total_hits_test + sum(confusion_matrix(i,:));
end

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
fprintf('\nNumber of Clusters : %0.f\n',num_clusters);
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

figure();
plotconfusion(targetmatrix,outputmatrix);

function no_of_assignments = assign_class(datasets,Weights,Means,Covars,PriorProbs,Actualclasslabel)
    global outputmatrix;
    global targetmatrix;
    global pointer;
    %l_test = length(datasets(:,1));
    no_of_assignments = zeros(1,10);
    actualclass = zeros(10,1);
    actualclass(Actualclasslabel) = 1;
    for i = 1:10
        outputmatrix(:,pointer) = actualclass;
        disc_val = zeros(1,10);
        dataset = datasets(i);
        for j = 1:10            
            l_test = length(dataset(:,1));
            d_val = 0;
            for k = 1:l_test
                X = dataset(k,:);
                d_val = d_val+(discriminant_func_GMM(X,Weights(j),Means(j),Covars(j),PriorProbs(j)));
            end
            %disp(d_val);
            d_val = d_val/l_test;
            disc_val(j) = d_val;
        end
        %disp(disc_val);
        [~,class_label] = max(disc_val);
        %disp(disc_val);
        no_of_assignments(class_label) = no_of_assignments(class_label) + 1;
        predictedclass = zeros(10,1);
        predictedclass(class_label) = 1;
        targetmatrix(:,pointer) = predictedclass;
        pointer = pointer + 1;
        %fprintf('Assigning class %.0f to (%f,%f)\n',class_label,X(1),X(2));
    end
end        

function val = discriminant_func_GMM(x,Wqs,Means,CoVarMatrixs,Prob)
   %Bayes || diff C 
   [Q,~] = size(Means);
%    disp(size(Means));
%    disp(size(CoVarMatrixs));
   val = 0;
   for q = 1:Q
       Mean = Means(q); CoVarMatrix = CoVarMatrixs(q);
       val = val+(Wqs(q)*discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)); 
   end
   val = val*Prob;
   %disp(log(val));
   if(val < 10^-300)
       val = -900;
   else
       val = log(val);
   end
end
function val = discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)
   %Bayes || diff C 
   %[~,dimm] = size(CoVarMatrix);
%    DET = det(CoVarMatrix);
%    val = (1/(sqrt(DET)))*(exp(-(x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)/2)));
   %disp(val);
   val = mvnpdf(x,Mean,CoVarMatrix);
end