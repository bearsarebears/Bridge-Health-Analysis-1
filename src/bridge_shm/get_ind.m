function [ data,class] = get_ind(rdata,f0,f1,f2,index)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    f0_len = numel(f0);
    f1_len = numel(f1);
    f2_len = numel(f2);
    % index is by one mod is by zero
    index = index -1;
    n_samples = size(rdata.(f0{1}).(f1{1}).(f2{1}),2);
    N = f0_len * f1_len * f2_len;
    ind2 = round(mod(index, f2_len));
    index = index - ind2*(f2_len);
    ind1 = round(mod(index, f1_len));
    index = index - ind1*(f1_len);
    ind0 = round(mod(index, f0_len));
    class = ind0+1;
    data = rdata.(f0{ind0+1}).(f1{ind1+1}).(f2{ind2+1}).wcoef;
end
