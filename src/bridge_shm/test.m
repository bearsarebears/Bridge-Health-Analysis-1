function [confusion, accuracy] = test(model,rfeatures,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n_test = size(rfeatures,2);
    confusion = zeros(2,numel(labels));
    confusion(2,:) = labels;
    switch classifier
    case 'svm'
	     [confusion(1,:),accuracy,~] = svmpredict(labels, rfeatures', model);
    end
end

