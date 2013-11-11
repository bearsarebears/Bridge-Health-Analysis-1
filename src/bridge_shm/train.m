function [ model ] = train(features,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch classifier
        case 'svm' 
	    whos('labels')
	    whos('features')
            model = svmtrain(labels,features','-t 0 -m 1000');
    end
end

