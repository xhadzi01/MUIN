%% %  cviko c. 1  [MUIN/2018]
% xhadzi01
clc;clear all; close all
%% ul1
load('data1.csv');              % --> data1
fir1 = data1(1,:)*data1(2,:)'
fir2 = data1(1,:)'*data1(2,:)

%% ul2

load('data2.mat');              % --> data
[size_x, size_y]= size(data);

size2_1 = 0;
for x2=1:1:size_x*size_y
     size2_1 = data(x2) + size2_1;
end
clear x2

size2_2 = 0;
size2_2 =sum(data(:));

size2_3 = 0;
size2_3 = data(:)' * ones((size_x* size_y),1);


mat1 = data(5:10,34:40);                            % 34. až 40. sloupec a 5. až 10.øádek
mat2 = data(28:34,[4, 9, 12, 25, 38, 46]);           % 4., 9., 12., 25., 38. a 46. sloupec 28. až 34.øádek
mat3 = data(17:22,2);                                % 2. sloupec a 17. až 22. øádek
matsum = mat1*mat2*mat3/2000;


%% ul3

load('data3.csv');              % --> data3
vec1sudy = data3(1,2:2:end);
vec1lich = data3(1,1:2:end);

vec2sudy = data3(2,2:2:end);
vec2lich = data3(2,1:2:end);

figure(1)
subplot(2,1,1)
hold on;
plot(vec1sudy(1:100),'b');
plot(vec2sudy(1:100),'g');
xlabel('tralal') 
ylabel('blablabla')
title('hej hou')

subplot(2,1,2)
hold on;
plot(vec1lich(1:100),'b');
plot(vec2lich(1:100),'g');
xlabel('aaaaaaa') 
ylabel('bbbbbb')
title('muinko')


%% ul4
obrazok = imread('1.bmp');
combo = zeros(10, size(obrazok,1) * size(obrazok,2)); 
for num = 1:10                               
    tmp = imread([num2str(num) '.bmp']);
    combo(num,:) = tmp(:);      
end

figure(2)
colormap(gray);                              
hold on
axis('off');
for num = 1:10                                
    m = reshape(combo(num, :),size(obrazok,1), size(obrazok,2));
    subplot(2,5,num);
    imshow(m*255);
end

