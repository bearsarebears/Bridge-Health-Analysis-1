function [ rfeatures ] = feature_compute( rdata,f0,f1,f2,f3,feature)
    n0 = numel(f0);
    n1 = numel(f1);
    n2 = numel(f2);
    n3 = numel(f3);
    type = feature.type; 
    
    if (~n0 || ~n1 || ~n2 || ~n3)
        %error all fields must be populated
        rfeatures = [];
        return;
    end
    for a = f0
        for b = f1
            for c = f2
		tmp = rdata.(a{1}).(b{1}).(c{1}).(f3{1});
		tmp = prefilter(tmp,feature);
               	[n_runs,run_len]= size(tmp);
		%allocate the sparse matrix to hold features for each n_runs
		switch type
		case 'wavelet'
			run_len = numel(wavedec(tmp(1,:),feature.depth,feature.basis));
			rfeatures.(a{1}).(b{1}).(c{1}).wcoef = sparse(n3*run_len,n_runs);
		case 'packet'
			rfeatures.(a{1}).(b{1}).(c{1}).wcoef = sparse(feature.depth*n3*run_len,n_runs);
		end
		count = 0;	
                for d= f3
		    tmp = rdata.(a{1}).(b{1}).(c{1}).(d{1}); 
		    tmp = prefilter(tmp,feature);
                    switch feature.type
		    % haar wavelet decomposition
		    % document how this is done
                    case 'packet'
                        for i = 1:n_runs
				tmp_dec = wpdec(tmp(i,:),feature.depth,feature.basis);
				for n = 0:feature.depth
					count = count + 1;
					depth_delta = ceil(run_len/(2^n));
					for p = 0: (2^n - 1)
						indicies = (count-1)*run_len+ p*depth_delta +1  : (p+1)*depth_delta + (count-1)*run_len;
						[rfeatures.(a{1}).(b{1}).(c{1}).wcoef(indicies,i)] = ...
                                			wpcoef(tmp_dec,[n,p]);
					end
				end
                        end
		    case 'wavelet'
		    	count = count + 1;
                        for i = 1:n_runs
				[rfeatures.(a{1}).(b{1}).(c{1}).wcoef((count-1)*run_len+1:count*run_len,i),~] = ...
                                	wavedec(tmp(i,:),feature.depth,feature.basis);
                        end

			clear tmp;
		    otherwise 
			rfeatures = [];
                    end
                end
			
            end
        end;
    end;
end
