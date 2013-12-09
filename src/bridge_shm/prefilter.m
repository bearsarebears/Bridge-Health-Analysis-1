function rdata = prefilter(rdata,feature_type)

	switch feature_type.prefilter
	case 'center'
		[n_runs,data_len] = size(rdata);
		range = ceil(data_len/2 - data_len/4):ceil(data_len/2 + data_len/4);
		rdata = rdata(:,range); 
	case 'onset detect'
	end
end
