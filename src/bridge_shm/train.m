function [ models ] = train(rfeatures,f0,f1,f2,classifier,ind)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [class_features, class_labels] = load_matrix(rfeatures,f0,f1,f2,ind);
    n_classes = numel(f0);
    models = cell(n_classes,1);
    for i = 1:n_classes
        switch classifier
            case 'svm' 
                label = (class_labels == i);
                models{i} = svmtrain(class_features',label); 
        end
    end
end

