addr = 'G:\Acads\5th Sem\PR\Ass1\Dataset2\Speaker_Dataset\Team5';

global targetmatrix;
global outputmatrix;
global pointer;
pointer = 1;

fields = (1:1:10);
values = cell(1,10);
Datasets_train = containers.Map(fields, values);
Datasets_test = containers.Map(fields, values);
Means = containers.Map(fields, values);
Weights = containers.Map(fields, values);
Covars = containers.Map(fields, values);

classfvfb0_train = [];
filename = fullfile(addr,'fvfb0\Train\sa1');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
filename = fullfile(addr,'fvfb0\Train\sa2');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
filename = fullfile(addr,'fvfb0\Train\si1032');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
filename = fullfile(addr,'fvfb0\Train\sx42');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
filename = fullfile(addr,'fvfb0\Train\sx132');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
filename = fullfile(addr,'fvfb0\Train\sx222');   
classfvfb0_train = [classfvfb0_train; get_dataset(filename)];
%Datasets_train(1) = standardise(classfvfb0_train);
Datasets_train(1) = (classfvfb0_train);

classmdem0_train = [];
filename = fullfile(addr,'mdem0\Train\sa1');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
filename = fullfile(addr,'mdem0\Train\sa2');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
filename = fullfile(addr,'mdem0\Train\si608');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
filename = fullfile(addr,'mdem0\Train\si800');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
filename = fullfile(addr,'mdem0\Train\si1868');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
filename = fullfile(addr,'mdem0\Train\sx428');   
classmdem0_train = [classmdem0_train; get_dataset(filename)];
%Datasets_train(2) = standardise(classmdem0_train);
Datasets_train(2) = (classmdem0_train);

classmdwm0_train = [];
filename = fullfile(addr,'mdwm0\Train\sa1');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
filename = fullfile(addr,'mdwm0\Train\sa2');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
filename = fullfile(addr,'mdwm0\Train\si916');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
filename = fullfile(addr,'mdwm0\Train\sx16');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
filename = fullfile(addr,'mdwm0\Train\sx286');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
filename = fullfile(addr,'mdwm0\Train\sx376');   
classmdwm0_train = [classmdwm0_train; get_dataset(filename)];
%Datasets_train(3) = standardise(classmdwm0_train);
Datasets_train(3) = (classmdwm0_train);

classmilb0_train = [];
filename = fullfile(addr,'milb0\Train\sa1');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
filename = fullfile(addr,'milb0\Train\sa2');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
filename = fullfile(addr,'milb0\Train\si807');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
filename = fullfile(addr,'milb0\Train\si2163');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
filename = fullfile(addr,'milb0\Train\sx183');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
filename = fullfile(addr,'milb0\Train\sx273');   
classmilb0_train = [classmilb0_train; get_dataset(filename)];
%Datasets_train(4) = standardise(classmilb0_train);
Datasets_train(4) = (classmilb0_train);

classmjeb1_train = [];
filename = fullfile(addr,'mjeb1\Train\sa1');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
filename = fullfile(addr,'mjeb1\Train\sa2');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
filename = fullfile(addr,'mjeb1\Train\si1467');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
filename = fullfile(addr,'mjeb1\Train\sx117');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
filename = fullfile(addr,'mjeb1\Train\sx297');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
filename = fullfile(addr,'mjeb1\Train\sx387');   
classmjeb1_train = [classmjeb1_train; get_dataset(filename)];
%Datasets_train(5) = standardise(classmjeb1_train);
Datasets_train(5) = (classmjeb1_train);

classmjrh1_train = [];
filename = fullfile(addr,'mjrh1\Train\sa1');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
filename = fullfile(addr,'mjrh1\Train\sa2');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
filename = fullfile(addr,'mjrh1\Train\si514');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
filename = fullfile(addr,'mjrh1\Train\si1774');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
filename = fullfile(addr,'mjrh1\Train\sx244');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
filename = fullfile(addr,'mjrh1\Train\sx334');   
classmjrh1_train = [classmjrh1_train; get_dataset(filename)];
%Datasets_train(6) = standardise(classmjrh1_train);
Datasets_train(6) = (classmjrh1_train);

classmmar0_train = [];
filename = fullfile(addr,'mmar0\Train\sa1');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
filename = fullfile(addr,'mmar0\Train\sa2');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
filename = fullfile(addr,'mmar0\Train\si706');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
filename = fullfile(addr,'mmar0\Train\si1336');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
filename = fullfile(addr,'mmar0\Train\sx166');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
filename = fullfile(addr,'mmar0\Train\sx436');   
classmmar0_train = [classmmar0_train; get_dataset(filename)];
%Datasets_train(7) = standardise(classmmar0_train);
Datasets_train(7) = (classmmar0_train);

classmprk0_train = [];
filename = fullfile(addr,'mprk0\Train\sa1');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
filename = fullfile(addr,'mprk0\Train\sa2');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
filename = fullfile(addr,'mprk0\Train\sx17');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
filename = fullfile(addr,'mprk0\Train\sx197');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
filename = fullfile(addr,'mprk0\Train\sx287');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
filename = fullfile(addr,'mprk0\Train\sx377');   
classmprk0_train = [classmprk0_train; get_dataset(filename)];
%Datasets_train(8) = standardise(classmprk0_train);
Datasets_train(8) = (classmprk0_train);

classmrab1_train = [];
filename = fullfile(addr,'mrab1\Train\sa1');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
filename = fullfile(addr,'mrab1\Train\sa2');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
filename = fullfile(addr,'mrab1\Train\si848');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
filename = fullfile(addr,'mrab1\Train\sx38');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
filename = fullfile(addr,'mrab1\Train\sx128');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
filename = fullfile(addr,'mrab1\Train\sx218');   
classmrab1_train = [classmrab1_train; get_dataset(filename)];
%Datasets_train(9) = standardise(classmrab1_train);
Datasets_train(9) = (classmrab1_train);

classmrfk0_train = [];
filename = fullfile(addr,'mrfk0\Train\sa1');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
filename = fullfile(addr,'mrfk0\Train\sa2');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
filename = fullfile(addr,'mrfk0\Train\si1706');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
filename = fullfile(addr,'mrfk0\Train\si2336');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
filename = fullfile(addr,'mrfk0\Train\sx176');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
filename = fullfile(addr,'mrfk0\Train\sx266');   
classmrfk0_train = [classmrfk0_train; get_dataset(filename)];
%Datasets_train(10) = standardise(classmrfk0_train);
Datasets_train(10) = (classmrfk0_train);

Lengths = zeros(1,10);
for i = 1:10
    Lengths(i) = length(Datasets_train(i));
end
L = sum(Lengths);
PriorProbs = Lengths/L;

for i = 1:10
    Means(i) = mean(Datasets_train(i));
    Covars(i) = get_cov(Datasets_train(i));
end

fields = (1:1:10);
values = cell(1,10);
fvfb0_test = containers.Map(fields, values);
filename = fullfile(addr,'fvfb0\Test\si2292_10');   
fvfb0_test(1) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\si2292_11');   
fvfb0_test(2) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\si2292_12');   
fvfb0_test(3) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\si2292_13');   
fvfb0_test(4) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\si2292_14');   
fvfb0_test(5) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\sx402_20');   
fvfb0_test(6) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\sx402_21');   
fvfb0_test(7) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\sx402_22');   
fvfb0_test(8) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\sx402_23');   
fvfb0_test(9) = get_dataset(filename);
filename = fullfile(addr,'fvfb0\Test\sx402_24');   
fvfb0_test(10) = get_dataset(filename);
Datasets_test(1) = fvfb0_test;

fields = (1:1:10);
values = cell(1,10);
mdem0_test = containers.Map(fields, values);
filename = fullfile(addr,'mdem0\Test\sx158_20');   
mdem0_test(1) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_21');   
mdem0_test(2) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_22');   
mdem0_test(3) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_23');   
mdem0_test(4) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_24');   
mdem0_test(5) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_20');   
mdem0_test(6) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_21');   
mdem0_test(7) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_22');   
mdem0_test(8) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_23');   
mdem0_test(9) = get_dataset(filename);
filename = fullfile(addr,'mdem0\Test\sx158_24');   
mdem0_test(10) = get_dataset(filename);
Datasets_test(2) = mdem0_test;

fields = (1:1:10);
values = cell(1,10);
mdwm0_test = containers.Map(fields, values);
filename = fullfile(addr,'mdwm0\Test\si2176_20');   
mdwm0_test(1) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\si2176_21');   
mdwm0_test(2) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\si2176_22');   
mdwm0_test(3) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\si2176_23');   
mdwm0_test(4) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\si2176_24');   
mdwm0_test(5) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\sx433_10');   
mdwm0_test(6) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\sx433_11');   
mdwm0_test(7) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\sx433_12');   
mdwm0_test(8) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\sx433_13');   
mdwm0_test(9) = get_dataset(filename);
filename = fullfile(addr,'mdwm0\Test\sx433_14');   
mdwm0_test(10) = get_dataset(filename);
Datasets_test(3) = mdwm0_test;

fields = (1:1:10);
values = cell(1,10);
milb0_test = containers.Map(fields, values);
filename = fullfile(addr,'milb0\Test\sx3_10');   
milb0_test(1) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx3_11');   
milb0_test(2) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx3_12');   
milb0_test(3) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx3_13');   
milb0_test(4) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx3_14');   
milb0_test(5) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx93_20');   
milb0_test(6) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx93_21');   
milb0_test(7) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx93_22');   
milb0_test(8) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx93_23');   
milb0_test(9) = get_dataset(filename);
filename = fullfile(addr,'milb0\Test\sx93_24');   
milb0_test(10) = get_dataset(filename);
Datasets_test(4) = milb0_test;

fields = (1:1:10);
values = cell(1,10);
mjeb1_test = containers.Map(fields, values);
filename = fullfile(addr,'mjeb1\Test\si2097_20');   
mjeb1_test(1) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\si2097_21');   
mjeb1_test(2) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\si2097_22');   
mjeb1_test(3) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\si2097_23');   
mjeb1_test(4) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\si2097_24');   
mjeb1_test(5) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\sx27_10');   
mjeb1_test(6) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\sx27_11');   
mjeb1_test(7) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\sx27_12');   
mjeb1_test(8) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\sx27_13');   
mjeb1_test(9) = get_dataset(filename);
filename = fullfile(addr,'mjeb1\Test\sx27_14');   
mjeb1_test(10) = get_dataset(filename);
Datasets_test(5) = mjeb1_test;

fields = (1:1:10);
values = cell(1,10);
mjrh1_test = containers.Map(fields, values);
filename = fullfile(addr,'mjrh1\Test\sx154_20');   
mjrh1_test(1) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx154_21');   
mjrh1_test(2) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx154_22');   
mjrh1_test(3) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx154_23');   
mjrh1_test(4) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx154_24');   
mjrh1_test(5) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx424_10');   
mjrh1_test(6) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx424_11');   
mjrh1_test(7) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx424_12');   
mjrh1_test(8) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx424_13');   
mjrh1_test(9) = get_dataset(filename);
filename = fullfile(addr,'mjrh1\Test\sx424_14');   
mjrh1_test(10) = get_dataset(filename);
Datasets_test(6) = mjrh1_test;

fields = (1:1:10);
values = cell(1,10);
mmar0_test = containers.Map(fields, values);
filename = fullfile(addr,'mmar0\Test\sx76_20');   
mmar0_test(1) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx76_21');   
mmar0_test(2) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx76_22');   
mmar0_test(3) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx76_23');   
mmar0_test(4) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx76_24');   
mmar0_test(5) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx346_10');   
mmar0_test(6) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx346_11');   
mmar0_test(7) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx346_12');   
mmar0_test(8) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx346_13');   
mmar0_test(9) = get_dataset(filename);
filename = fullfile(addr,'mmar0\Test\sx346_14');   
mmar0_test(10) = get_dataset(filename);
Datasets_test(7) = mmar0_test;

fields = (1:1:10);
values = cell(1,10);
mprk0_test = containers.Map(fields, values);
filename = fullfile(addr,'mprk0\Test\si1097_20');   
mprk0_test(1) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si1097_21');   
mprk0_test(2) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si1097_22');   
mprk0_test(3) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si1097_23');   
mprk0_test(4) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si1097_24');   
mprk0_test(5) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si467_10');   
mprk0_test(6) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si467_11');   
mprk0_test(7) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si467_12');   
mprk0_test(8) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si467_13');   
mprk0_test(9) = get_dataset(filename);
filename = fullfile(addr,'mprk0\Test\si467_14');   
mprk0_test(10) = get_dataset(filename);
Datasets_test(8) = mprk0_test;

fields = (1:1:10);
values = cell(1,10);
mrab1_test = containers.Map(fields, values);
filename = fullfile(addr,'mrab1\Test\sx308_20');   
mrab1_test(1) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx308_21');   
mrab1_test(2) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx308_22');   
mrab1_test(3) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx308_23');   
mrab1_test(4) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx308_24');   
mrab1_test(5) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx398_10');   
mrab1_test(6) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx398_11');   
mrab1_test(7) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx398_12');   
mrab1_test(8) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx398_13');   
mrab1_test(9) = get_dataset(filename);
filename = fullfile(addr,'mrab1\Test\sx398_14');   
mrab1_test(10) = get_dataset(filename);
Datasets_test(9) = mrab1_test;

fields = (1:1:10);
values = cell(1,10);
mrfk0_test = containers.Map(fields, values);
filename = fullfile(addr,'mrfk0\Test\sx446_20');   
mrfk0_test(1) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx446_21');   
mrfk0_test(2) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx446_22');   
mrfk0_test(3) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx446_23');   
mrfk0_test(4) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx446_24');   
mrfk0_test(5) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx86_10');   
mrfk0_test(6) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx86_11');   
mrfk0_test(7) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx86_12');   
mrfk0_test(8) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx86_13');   
mrfk0_test(9) = get_dataset(filename);
filename = fullfile(addr,'mrfk0\Test\sx86_14');   
mrfk0_test(10) = get_dataset(filename);
Datasets_test(10) = mrfk0_test;

targetmatrix = zeros(10,100);
outputmatrix = zeros(10,100);
pointer = 1;

confusion_matrix = zeros(10);
total_hits_test = 0;
for i = 1:10
    confusion_matrix(i,:) = assign_class(Datasets_test(i),Means,Covars,PriorProbs,i);
    total_hits_test = total_hits_test + sum(confusion_matrix(i,:));
end

total_correct_hits_test = trace(confusion_matrix);
accuracy_test = total_correct_hits_test/total_hits_test;
confusion_matrix
fprintf('Classification Accuracy on test data: %f\n',accuracy_test);

figure();
plotconfusion(targetmatrix,outputmatrix);

function no_of_assignments = assign_class(datasets,Means,Covars,PriorProbs,Actualclasslabel)
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
                d_val = d_val + discriminant_func_GMM(X,Means(j),Covars(j),PriorProbs(j));
            end
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

function val = discriminant_func_GMM(x,Mean,CoVarMatrix,Prob)
   %Bayes || diff C 
   val = (discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)); 
   val = val*Prob;
   if(val < 10^-300)
       val = -800;
   else
       val = log(val);
   end
end
function val = discriminant_func_GMM_cluster(x,Mean,CoVarMatrix)
   %Bayes || diff C 
   %DET = det(CoVarMatrix);
   %val = (1/((det(CoVarMatrix))^(1/2)))*(exp(-(x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)/2)));
   %val = (1/(sqrt(DET)))*(exp(-(x-Mean)*(inv(CoVarMatrix))*(transpose(x-Mean)/2)));
   val = mvnpdf(x,Mean,CoVarMatrix);
end

function cov_matrix = get_cov(matrix)
    cov_matrix = cov(matrix);
%     if(det(cov_matrix)== 0)
%         cov_matrix = cov_matrix + eye(39)*0.000001;
%     end
    %disp(det(cov_matrix));
end

function dataset = get_dataset(filename)
     data = dlmread(filename);
     dataset = data(2:end,:);
end