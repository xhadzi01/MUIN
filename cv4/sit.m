clear all;
close all;
clc;

for i=1:10
    m=imread([num2str(i) '.bmp']);
    x(i,:)=m(:);
end
[k,l]=size(x); %k-pocet vzoru, l-pocet pixelu
n=12; %skryta vrstva

w1=rand(n,l+1)/100; %init wah + w0 - mezi vstupni a skrytou
w2=rand(n,n+1)/100; %init wah + w0 - mezi vstupni a skrytou
w3=rand(10,n+1)/100; %init wah + w0 - mezi skrytou a vystupni
u=0.03; %koef uceni
Ep=0.1; %pozadovana chyba
zad=eye(10)*2-1; %zadana hodnota
jedna=ones(10,1);

for i=1:1000
    for vz=1:k
        y1=tanh(w1*[x(vz,:) 1]');
        y2=tanh(w2*[y1; 1]);
        y3=tanh(w3*[y2; 1]);
        Eh(vz)=1/2*sum((zad(vz,:)-y3').^2);
        delta=w3(:,1:end-1)'*(zad(vz,:)-y3')';
        w3=w3+u*(ones(10,1)-y3.^2).*(zad(vz,:)'-y3)*[y2; 1]';
        w2=w2+u*(ones(n,1)-y2.^2).*(delta)*[y1; 1]';
        w1=w1+u*(ones(n,1)-y1.^2).*(delta)*[x(vz,:) 1]; 
        Ec=sum(Eh);
    end
    E(i)=Ec;
    
end
plot(E);


%testovani
figure(2)

summ=imnoise(double(x(2,:)),'salt & pepper',0.3);
vys1=tanh(w1(:,:)*[summ 1]');
vys2=tanh(w2(:,:)*[vys1;1]);
vys3=tanh(w3(:,:)*[vys2;1]);
bar(vys3);

