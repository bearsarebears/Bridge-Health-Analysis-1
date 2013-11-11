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
		tmp = rdata.(a{1}).(b{1}).(c{1}).(f3{1});
               	[n_runs,run_len]= size(tmp);
		if strcmp(feature_type,'haar packet')
			run_len = numel(wpcoef(wpdec(tmp(1,:),depth,feature_type)));
		else if strcmp(feature_type,'haar wavelet')
			run_len = numel(wavedec(tmp(1,:),depth,'haar'));
		end
		rfeatures.(a{1}).(b{1}).(c{1}).wcoef = sparse(n3*run_len,n_runs);
		count = 0;	
                for d= f3
		    count = count + 1;
                    switch feature_type
		    % haar wavelet decomposition
                    case 'haar packet'
			tmp = rdata.(a{1}).(b{1}).(c{1}).(d{1}); 
                        for i = 1:n_runs
				[rfeatures.(a{1}).(b{1}).(c{1}).wcoef((count-1)*run_len+1:count*run_len,i)] = ...
                                	wpcoef(wpdec(tmp(i,:),depth,'haar'));
                        end
			case 'haar wavelet'
			tmp = rdata.(a{1}).(b{1}).(c{1}).(d{1}); 
                        for i = 1:n_runs
				[rfeatures.(a{1}).(b{1}).(c{1}).wcoef((count-1)*run_len+1:count*run_len,i), ~] = ...
                                	wavedec(tmp(i,:),depth,'haar');
                        end

			clear tmp;
                    end
                end
			
            end
        end;
    end;
end
