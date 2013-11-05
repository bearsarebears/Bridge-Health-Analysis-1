function [confusion, accuracy] = test(model,rfeatures,labels,classifier)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n_test = numel(ind);
    confusion = zeros(numel(labels),2);
    confusion(:,2) = labels;
    switch classifier
    case 'svm'
        for i = 1:n_test
            [~,~,Rawres] = classify(rfeatures,model.X,model.Ynew,...
             model.alpha,model.b,model.kernel,model.p1)
            [~,confusion(i,1)] = max(max(Rawres));
        end
    end
    err = sum(confusion(:,1) ~= confusion(:,2));
    accuracy = err/n_test;
end

