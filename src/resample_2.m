
SAMPLE_SIZE = 3000;

fields = fieldnames(pdata);


for i = 1:numel(fields)
fields2 = fieldnames(pdata.(fields{i}));
for j = 1:numel(fields2)
    fields3 = fieldnames(pdata.(fields{i}).(fields2{j}));
    for k = 1:numel(fields3)
        fields4 = fieldnames(pdata.(fields{i}).(fields2{j}).(fields3{k}));
        for l = 1:numel(fields4)
n = size((pdata.(fields{i}).(fields2{j}).(fields3{k}).(fields4{l})),2);
rdata.(fields{i}).(fields2{j}).(fields3{k}).(fields4{l})  = resample((pdata.(fields{i}).(fields2{j}).(fields3{k}).(fields4{l}))',SAMPLE_SIZE,n);
rdata.(fields{i}).(fields2{j}).(fields3{k}).(fields4{l}) = (rdata.(fields{i}).(fields2{j}).(fields3{k}).(fields4{l}))';
        end
    end
end
end