function [ class_features, class_labels ] = load_matrix( rfeatures,f0,f1,f2,ind )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [run_length,n_runs] = size(rfeatures.(f0{1}).(f1{1}).(f2{1}).wcoef);
    if ind == 0
        N = numel(f0)*numel(f1)*numel(f2);
    else
        N = numel(ind);
    end
    class_labels = zeros(N,1);
    class_features = sparse(run_length,N);
    for i = 1:N
i	
        [feature, class] = get_ind(rfeatures,f0,f1,f2,i);
        class_features(:,(i-1)*n_runs+1:i*n_runs) = feature;
        class_labels((i-1)*n_runs+1:i*n_runs) = class;
    end

end

