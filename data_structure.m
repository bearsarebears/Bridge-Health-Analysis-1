addpath('C:\Users\xong\Documents\Wavelets\');
addpath('C:\Users\xong\Documents\Wavelets\B1 R2 T SC020 final');
cd('C:\Users\xong\Documents\Wavelets\B1 R2 T SC020 final');
files = dir('*.mat');
for file = files'
    load(file.name);
    speed = file.name(1:2);
    temperature = file.name(10:12);

%load('C:\Users\XiaoChuan\Documents\Wavelets\B1 R2 T SC020 final\S3V1SC020T00B1R2.mat');
%% 4 speeds (S3-S6), 11 temperatures (T00 - T10) %% 
clear data_forwards;
clear data_backwards;


minimum = size(accel_vf{1,1},1);
for i = 1:32
    for j = 1:2
if(size(accel_vf{i,j},1) < minimum)
    minimum = size(accel_vf{i,j},1);
end
    end
end

for i=1:32
data_forwards(i,:,:) = accel_vf{i,1}(1:minimum,:);
data_backwards(i,:,:) = accel_vf{i,2}(1:minimum,:);
end

% wavemenu

data.(temperature).(speed).F.T = data_forwards(:,:,1);
data.(temperature).(speed).B.T = data_backwards(:,:,1);

data.(temperature).(speed).F.B1 = data_forwards(:,:,2);
data.(temperature).(speed).B.B1 = data_backwards(:,:,2);

data.(temperature).(speed).F.B2 = data_forwards(:,:,3);
data.(temperature).(speed).B.B2 = data_backwards(:,:,3);


data.(temperature).(speed).F.B3 = data_forwards(:,:,4);
data.(temperature).(speed).B.B3 = data_backwards(:,:,4);

data.(temperature).(speed).F.B4 = data_forwards(:,:,5);
data.(temperature).(speed).B.B4 = data_backwards(:,:,5);

data.(temperature).(speed).F.SF = data_forwards(:,:,6);
data.(temperature).(speed).B.SF = data_backwards(:,:,6);

data.(temperature).(speed).F.SB = data_forwards(:,:,7);
data.(temperature).(speed).B.SB = data_backwards(:,:,7);

data.(temperature).(speed).F.WF = data_forwards(:,:,8);
data.(temperature).(speed).B.WF = data_backwards(:,:,8);

data.(temperature).(speed).F.WB = data_forwards(:,:,9);
data.(temperature).(speed).B.WB = data_backwards(:,:,9);

for i = 1:32
[value, START_INDEX_F(i)] = min(abs(data.(temperature).(speed).F.T(i,:)- Times(1,1,1)) );
[value, END_INDEX_F(i)] = min(abs(data.(temperature).(speed).F.T(i,:)- Times(1,2,1)) );
end

length = max(END_INDEX_F) - min(START_INDEX_F);
AVERAGE_F = (START_INDEX_F + END_INDEX_F)/2;
START = AVERAGE_F - length/2;
END = AVERAGE_F + length/2;


pdata.(temperature).(speed).F.T = data_forwards(:,START(1):END(1),1);
pdata.(temperature).(speed).F.B1 = data_forwards(:,START(2):END(2),2);
pdata.(temperature).(speed).F.B2 = data_forwards(:,START(3):END(3),3);
pdata.(temperature).(speed).F.B3 = data_forwards(:,START(4):END(4),4);
pdata.(temperature).(speed).F.B4 = data_forwards(:,START(5):END(5),5);
pdata.(temperature).(speed).F.SF = data_forwards(:,START(6):END(6),6);
pdata.(temperature).(speed).F.SB = data_forwards(:,START(7):END(7),7);
pdata.(temperature).(speed).F.WF = data_forwards(:,START(8):END(8),8);
pdata.(temperature).(speed).F.WB = data_forwards(:,START(9):END(9),9);

for i = 1:32
[value , START_INDEX_B(i)] = min(abs(data.(temperature).(speed).B.T(i,:)- Times(1,1,1)) );
[value, END_INDEX_B(i)] = min(abs(data.(temperature).(speed).B.T(i,:)- Times(1,2,1)) );
end

length = max(END_INDEX_B) - min(START_INDEX_B);
AVERAGE_B = (START_INDEX_B + END_INDEX_B)/2;
START = ceil(AVERAGE_B - length/2);
END = ceil(AVERAGE_B + length/2);

pdata.(temperature).(speed).B.T = data_forwards(:,START(1):END(1),1);
pdata.(temperature).(speed).B.B1 = data_forwards(:,START(2):END(2),2);
pdata.(temperature).(speed).B.B2 = data_forwards(:,START(3):END(3),3);
pdata.(temperature).(speed).B.B3 = data_forwards(:,START(4):END(4),4);
pdata.(temperature).(speed).B.B4 = data_forwards(:,START(5):END(5),5);
pdata.(temperature).(speed).B.SF = data_forwards(:,START(6):END(6),6);
pdata.(temperature).(speed).B.SB = data_forwards(:,START(7):END(7),7);
pdata.(temperature).(speed).B.WF = data_forwards(:,START(8):END(8),8);
pdata.(temperature).(speed).B.WB = data_forwards(:,START(9):END(9),9);



end