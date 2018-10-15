classdef OneLayerNetwork
   properties
      w;                        %matica vah
      alpha;                    %koeficient ucenia
      inCpy;                    %local copy of input dataVector
      d;                        %matica spravnych vysledkov
      y;                        %matica  vysledkov
      
      maxSteps;                 %max pocet krokov
      step;                     %aktualny krok
      tmpErr;                   %aktualna differencia Y a D
      tmpEc;                    %aktualna chyba v percentach
      Ec_final;                 %ukoncovacia podmienka
      logErr;                   %vektor chyby pre vykreslenie
      
   end
   
   methods
       
   %% member functions   
       function obj = OneLayerNetwork(dataVect,teacherVect)                % ctor
         obj.inCpy = dataVect;
         obj.w = rand(5, 6)/10;
         obj.alpha = 0.05;
         obj.d = teacherVect;
         obj.maxSteps = 500;
         obj.step = 1;
         obj.tmpEc = 100;
       end

      function  obj = setMaxSteps(obj,stp)                  % alpha set for correction
         obj.maxSteps = stp;
      end
      
      function obj = computeY(obj,n)                        % compute output vector
         obj.y = tanh(obj.w * [1 obj.inCpy(n, :)]');
      end
      
      function obj = computeErr(obj,n)                      % compute err
          obj.tmpErr = (obj.d(n,:) - obj.y');
      
      end
      
      function obj = setWeight(obj , n)                     % recalculate weights 
%        obj.w = obj.w + obj.alpha *([1 obj.inCpy(n,:)]' * (obj.tmpErr .* (1 - obj.y.^2)'))';
         obj.w = obj.w + obj.alpha *((1 - obj.y.^2) .* obj.tmpErr')*[1 obj.inCpy(n,:)];

      end
      
      function obj = computeEc(obj)                         % compute difference
         obj.tmpEc =  obj.tmpEc + 0.5 * obj.tmpErr * obj.tmpErr'; 
      end   
       
      function obj = logError(obj)                          % log me actual err
         obj.logErr = [obj.logErr obj.tmpEc];
      end
   

   %% automated state engines  
        function obj = oneRotation(obj)                     % complete one full rotation
           obj.tmpEc = 0; 
           for n = 1:5
               obj = computeY(obj,n);
               obj = computeErr(obj,n);
               obj = setWeight(obj,n);
               obj = computeEc(obj);
           end
          obj = logError(obj);
          obj.step = obj.step+1;    
        end
       
        function obj = computeUntil(obj)                    % compute until conditions are met
           while((obj.step<obj.maxSteps)|(obj.logErr(end)<obj.Ec_final))
              obj = oneRotation(obj);
              if (mod(obj.step,5)==0)
                  figure(1); subplot(2,1,1);
                  plotErr(obj);
                  figure(1); subplot(2,1,2);
                  testMe(obj,obj.inCpy(1,:),0);
                  pause();
              end
           end
        end
        
  %% graph makers
  
  function obj = plotErr(obj)                               % plots how err looks in all iterations
          figure(1);
          if (size(obj.logErr,2)<500)
              plot(obj.logErr(1:end));
          else
              plot(obj.logErr(1:500))
          end
          title('Chyba siete');
          xlabel('Iteracia'); 
          ylabel('Ec');                
        end
    
  %% testing
  
    function obj = testMe(obj,unknown,isTEST)                % plots likelihood of output
      if (~isTEST)    
          if ((size(unknown,1)~= 1)|(size(unknown,2)~= 5)) 
            disp('zle zadany vektor pre porovnavanie!!!!!');
          end
          figure(1);
          tmpVecY = tanh(obj.w * [1 unknown]');
          bar(tmpVecY)
          title('Odhad vystupu');
          xlabel('vystup'); 
          ylabel('pravdepodobnost vyberu'); 
      elseif (isTEST)
          if ((size(unknown,1)~= 5)|(size(unknown,2)~= 5)) 
            disp('zle zadany vektor pre porovnavanie!!!!!');
          end
          figure('units','normalized','outerposition',[0 0 1 1]);
          for i=1:1:5
            tmpVecY(i,:) = tanh(obj.w * [1 unknown(i,:)]');
            subplot(5,1,i)
            bar(tmpVecY(i,:))
          end
          xlabel('vystup'); 
          ylabel('pravdepodobnost vyberu');
          subplot(5,1,1)
          n = get(gcf,'Number')
          if (n == 2)
             title('Odhad vystupu pre povodne data');
          else
             title('Odhad vystupu pre zasumene data');
          end 
      end
    end
       
   end
end