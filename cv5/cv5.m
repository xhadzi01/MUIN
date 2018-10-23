clc
close all
clear all

colormap(gray);    

for i = 1:6          
    m = csvread([num2str(i-1) '.csv']);
    x(i,:) = [m(:)'];      
end

%vykresleni trenovacich vzoru
for i = 1:6          
    m = zeros(19,19);
    k = x(i,1:361);
    m(:) = k;
    subplot(3,6,i);
    hold on
    image(m(19:-1:1, 1:19)*255);
end
hold off
%pøidani sumu 
for i = 1:6   
  I=x(i,:);
  I=imnoise(I, 'salt & pepper', 0.3);
  vstup(i,:)=I;
  m(:)=I(1:361)
  subplot(3,6,i+6);
  image(m(1:19, 1:19)*255);
end
%transformace na bipolární 

 for i = 1:6
 x2(i,:) = 2*x(i,1:361)-1;
 end
%nastaveni vah matice  
w1=x2(1,:)'*x2(1,:);
w2=x2(2,:)'*x2(2,:);
w3=x2(3,:)'*x2(3,:);
w4=x2(4,:)'*x2(4,:);
w5=x2(5,:)'*x2(5,:);
w6=x2(6,:)'*x2(6,:);

R=w1+w2+w3+w4+w5+w6;

%nastaveni vah matice na diagonale na nulu 
n=length(R);
diag=n*[0:n-1]+[1:n];
R(diag)=0;



vstup = 2*vstup-1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:6
vstup1=vstup(j,:)
podminka=true;

while(podminka)
  mn=vstup1*R;
  for i=1:length(mn)
    if mn(i)>0
      mn(i)=1;
    elseif mn(i)<0
      mn(i)=-1;
    else mn(i)=m(i);
    end
  end
  if(mn==vstup1)
    podminka=false;
  else
    vstup1=mn;
  end
end   

m(:)=(mn(1:361)+1)*0.5;
subplot(3,6,j+12);
image(m(1:19, 1:19)*255)

end
