clc;    clear all;  close all;
load('data.csv');

%% uvod  -- morse code
% tecka je reprezentov�na jako -1 a carka 1


for opak=1:MaxOpak                                                  % number of iteration
    clf('reset');hold on; axis([-1 2 -1 2]);                        % just figure manipulation
    for singleX=1:size(vstup,1)                                     
        
        % func Z
        z=w(1)+w(2)*vstup(singleX,1)+w(3)*vstup(singleX,2);         
        
        % vypocet Y         
        if (z>0)    y=0;    col = '+r'; 
        else        y=1;    col = '+g';   
        end    
        
        %  prepocet vah + bias
        if (y~=vstup(singleX,3))
            w(2)=w(2)+sign(y-0.5)*alfa*vstup(singleX,1);
            w(3)=w(3)+sign(y-0.5)*alfa*vstup(singleX,2);
            w(1)=w(1)+sign(y-0.5)*alfa*1;
        end
       
        plot (vstup (singleX,1), vstup(singleX,2),col);
            
    end
    % vypocet grafickej reprezentacie  
    fimplicit3(@(x1,x2)  w(1)+w(2)*x1+w(3)*x2);
    title(strcat('Opakovanie c.',num2str(opak),'    r = 0 , g = 1'));
    view(17,69);
    pause()
end
