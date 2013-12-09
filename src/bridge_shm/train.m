function [ model ] = train(features,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [feature_len,n_train] = size(features);
    switch classifier.type
	 case 'svm-matlab'
             n_classes = max(labels);
             model.model = cell(n_classes,1);
   	     for i = 1:n_classes
	         model.model{i} = svmtrain(features,labels == i,'kernel_function',classifier.kernel);
	     end
    end
end

