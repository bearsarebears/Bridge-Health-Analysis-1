function [ rfeatures ] = feature_compute( rdata,f0,f1,f2,f3,feature_type,depth)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    n0 = numel(f0);
    n1 = numel(f1);
    n2 = numel(f2);
    n3 = numel(f3);
    
    if (~n0 || ~n1 || ~n2 || ~n3)
        %error all fields must be populated
        rfeatures = [];
        return;
    end
    for a = f0
        for b = f1
            for c = f2
                for d= f3
                    switch feature_type
                    case 'haar'
                        tmp = rdata.(a{1}).(b{1}).(c{1}).(d{1});
                        n_runs = size(tmp,2);
                        concat = cell(n_runs,1);
                        for i = 1:n_runs
                            concat{i} = ...
                                wpdec(tmp(:,i),depth,feature_type);
                        end
                        rfeatures.(a).(b).(c).(d) = concat;
                        clear concat;
                    end
                end
            end
        end;
    end;
end
