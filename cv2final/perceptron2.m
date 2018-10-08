clear all
close all


%% PR2

pocet = 10;
trida1 = 1*ones(pocet, 3) + rand(pocet, 3)/10;
trida2 = 0.5*ones(pocet, 3) + rand(pocet, 3)/10;
in = zeros(pocet*2,4);
in(1:2:end,:) = [trida1 ones(pocet,1)];
in(2:2:end,:) = [trida2 zeros(pocet,1)];
PatchXYZ = [0,0; 2,0 ; 2,2;0,2];   % xy , xy,

% pociatocna ukazka
figure(1);hold on; 
plot3(in(:,1) , in(:,2) ,in(:,3),'marker','.','LineStyle', 'none' );
axis([0.0000    1.5000    0.0000    1.5000    0.0200    1.5000]);
title('Before the computation'); xlabel('x');ylabel('y');zlabel('z');
view(24,36)
pause();
clear figure(1)


%% riesenie 
w=ones(4,1)*0.5;
MaxOpak     = 10;
alfa        = 0.4;


figure(2);
for opak=1:MaxOpak                                                  
    clf('reset');hold on;
%     axis([0.0000    1.5000    0.0000    1.5000    0.0200    1.5000]);
   
    for singleX=1:size(in,1)                                     
        
        % func Z
        z=w(1)+w(2)*in(singleX,1)+w(3)*in(singleX,2)+w(4)*in(singleX,3);         
        
        % vypocet Y         
        if (z>0)    y=0;    col = '+r'; 
        else        y=1;    col = '+b';   
        end    
        
        %  prepocet vah + bias
        if (y~=in(singleX,4))
            w(1)=w(1)+sign(y-0.5)*alfa*1;
            w(2)=w(2)+sign(y-0.5)*alfa*in(singleX,1);
            w(3)=w(3)+sign(y-0.5)*alfa*in(singleX,2);
            w(4)=w(4)+sign(y-0.5)*alfa*in(singleX,3);
        end
       
        plot3(in (singleX,1), in(singleX,2),in(singleX,3),col);
              
    end
    % vypocet grafickej reprezentacie  
    for tmp=1:1:size(PatchXYZ,1)
        PatchXYZ(tmp,3) = (-w(1)-w(2)*PatchXYZ(tmp,1)-w(3)*PatchXYZ(tmp,2))/w(4);
    end
    
    patch(PatchXYZ(:,3),PatchXYZ(:,2),PatchXYZ(:,1),[0,1,0]);
       
    title(strcat('Opakovanie c.',num2str(opak),'    r = 0 , g = 1'));
    xlabel('x');ylabel('y');zlabel('z');
   
    
    view(24,36)
    pause()
end
