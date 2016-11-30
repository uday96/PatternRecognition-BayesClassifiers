function no_of_assignments = knn(K,class_test,Dataset_train,Actualclasslabel)
	
    global outputmatrix;
    global targetmatrix;
    global pointer;
    
    [num_classes,~] = size(Dataset_train);
    no_of_assignments = zeros(1,num_classes);
    
    l_test = length(class_test(:,1));
    
    actualclass = zeros(num_classes,1);
    actualclass(Actualclasslabel) = 1;
    
    for i = 1:l_test
        outputmatrix(:,pointer) = actualclass;
        dis = [];
        x1 = class_test(i,1);
        y1 = class_test(i,2);
        for n = 1:num_classes
            [ln_train,~] = size(Dataset_train{n});
            dis = [dis; dist(x1,y1,Dataset_train{n},ln_train,n)];
        end
        
        [~, order] = sort(dis(:,1));
        sorted_dis = dis(order,:);
            
        class_hits = zeros(1,num_classes);
        
        for j = 1:K
            cls = sorted_dis(j,2);
            weight = sorted_dis(j,1);
            class_hits(cls) = class_hits(cls) + 1/weight;
        end

        [~,ind] = max(class_hits);
        
        predictedclass = zeros(num_classes,1);
        predictedclass(ind) = 1;
        targetmatrix(:,pointer) = predictedclass;
        
        no_of_assignments(ind) = no_of_assignments(ind) + 1;
        
        pointer = pointer + 1;
        
    end
    
end