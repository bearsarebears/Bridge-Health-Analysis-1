function [ rfeatures ] = feature_compute( rdata,f0,f1,f2,f3,feature_type)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    [N_runs,run_length] = size(rdata.(f0{1}).(f1{1}).(f2{1}).(f3{1}));

    n0 = numel(f0);
    n1 = numel(f1);
    n2 = numel(f2);
    n3 = numel(f3);
    
    if (~n0 || ~n1 || ~n2 || ~n3)
        %error all fields must be populated
        rfeatures = [];
        return;
    end
    
    concat_features = zeros(n3*run_length,N_runs);
    for w = 1:numel(f0); 
        a = f0{w}; 
        for y = 1:numel(f1); b = f1{y,1}; 
            for z = 1:numel(f2); 
                c = f2{z}; 
                for i= 1:numel(f3);
                    d = f3{i};
                    index = (i-1)*run_length + 1: i*run_length;
                    switch feature_type
                        case 'haar'
                        depth = 10;
                        tmp = rdata.(a).(b).(c).(d);
                        for j = 1:N_runs
                            concat_features(index,j)= wpcoef(wpdec(tmp(j,:),depth,feature_type));
                        end
                    end
                end
                rfeatures.(a).(b).(c) = concat_features;
            end;
        end;
    end;
end
