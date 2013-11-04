function [ class_features, class_labels ] = load_matrix( rfeatures,f0,f1,f2,ind )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    N = numel(ind);
    class_labels = zeros(N,1);
    [run_length,~] = size(rfeatures.(f0{1}).(f1{1}).(f2{1}));
    class_features = zeros(run_length,N);
    for i = 1:N
        index = ind(i);
        [feature, class] = get_ind(rfeatures,f0,f1,f2,index);
        class_features(:,i) = feature;
        class_labels(i) = class;
    end

end

