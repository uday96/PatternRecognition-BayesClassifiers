function [imgdata_struct] = random1()
    
    images = load('CompleteData.mat');

    imgdata_2=images.CompleteData{2,1};
    l2=length(imgdata_2);
    imgdata_5=images.CompleteData{5,1};
    l5=length(imgdata_5);
    imgdata_10=images.CompleteData{10,1};
    l10=length(imgdata_10);
    imgdata_16=images.CompleteData{16,1};
    l16=length(imgdata_16);
    imgdata_20=images.CompleteData{20,1};
    l20=length(imgdata_20);

    L = (l2+l5+l10+l16+l20);

    prior_prob_2=l2/L;
    prior_prob_5=l5/L;
    prior_prob_10=l10/L;
    prior_prob_16=l16/L;
    prior_prob_20=l20/L;

    delimiter = floor((70/100)*l2); 
    imgset2_train = datasample(imgdata_2,delimiter,'Replace',false);
    imgset2_test = setdiff(imgdata_2,imgset2_train,'rows');
    
    delimiter = floor((70/100)*l5); 
    imgset5_train = datasample(imgdata_5,delimiter,'Replace',false);
    imgset5_test = setdiff(imgdata_5,imgset5_train,'rows');
    
    delimiter = floor((70/100)*l10); 
    imgset10_train = datasample(imgdata_10,delimiter,'Replace',false);
    imgset10_test = setdiff(imgdata_10,imgset10_train,'rows');
    
    delimiter = floor((70/100)*l16); 
    imgset16_train = datasample(imgdata_16,delimiter,'Replace',false);
    imgset16_test = setdiff(imgdata_16,imgset16_train,'rows');
    
    delimiter = floor((70/100)*l20); 
    imgset20_train = datasample(imgdata_20,delimiter,'Replace',false);
    imgset20_test = setdiff(imgdata_20,imgset20_train,'rows');
    
    field_2 = 'imgset2';
    values_2 = {prior_prob_2; imgset2_train; imgset2_test};
    field_5 = 'imgset5';
    values_5 = {prior_prob_5; imgset5_train; imgset5_test};
    field_10 = 'imgset10';
    values_10 = {prior_prob_10; imgset10_train; imgset10_test};
    field_16 = 'imgset16';
    values_16 = {prior_prob_16; imgset16_train; imgset16_test};
    field_20 = 'imgset20';
    values_20 = {prior_prob_20; imgset20_train; imgset20_test};
    
    imgdata_struct = struct(field_2,values_2,field_5,values_5,field_10,values_10,field_16,values_16,field_20,values_20);
end