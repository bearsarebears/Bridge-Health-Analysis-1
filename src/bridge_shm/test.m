function [confusion, accuracy] = test(models,rfeatures,f0,f1,f2,classifier,ind)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n_test = numel(ind);
    n_classes = numel(f0);
    confusion = zeros(n_test,2);
    [class_features, confusion(:,2)] = load_matrix(rfeatures,f0,f1,f2,ind);
   
    for index = 1:n_test;
        model_result = zeros(n_classes,1);
        for class = 1:n_classes
            switch classifier
                case 'svm'
                    model_result(class) = svmclassify(models{class},class_features(:,index)');
            end
        end
        inds = find(model_result);
        if numel(inds) == 0
            confusion(index,1) = 0;
        else
            confusion(index,1) = inds(1)
        end
    end
    err = sum(confusion(:,1) ~= confusion(:,2));
    accuracy = err/n_test;
end

