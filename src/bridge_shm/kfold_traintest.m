function [folds ] = kfold_traintest(rdata, f0,f1,f2, K )
    f0_len = numel(f0);
    f1_len = numel(f1);
    f2_len = numel(f2);
    n_samples = size(rdata.(f0{1}).(f1{1}).(f2{1}).wcoef,2)
    N = f0_len * f1_len * f2_len * n_samples;
    folds = crossvalind('kfold',N,K);
end

