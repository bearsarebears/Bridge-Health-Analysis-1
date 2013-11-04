function [ svm_i ] = train_raw( rdata,f1,f2,f3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    temperatures = fieldnames(rdata);
    N_temperature = numel(temperatures);
       N_runs = 32;
    run_length = size(rdata.(temperatures{1}).(f1).(f2).(f3),2);
    all = zeros(run_length,N_temperature*N_runs); 
    svm_i = cell(N_temperature,1); 

    for i=1:N_temperature
        all(:,(N_runs*(i-1) + 1) : N_runs*i) = rdata.(temperatures{i}).(f1).(f2).(f3)'; 
    end
    for i = 1:10; 
        svm_i{i} = svmtrain(all, [ones(N_runs*(i-1),1); zeros(N_runs,1); ones(N_runs*(N_temperature-i),1)]); 
    end

end

