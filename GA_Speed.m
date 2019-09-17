% Define Limits
x1l=2.6; x1u=3.6;
x2l=0.7; x2u=0.8;
x3l=17; x3u=28;
x4l=7.3; x4u=8.3;
x5l=7.3; x5u=8.3;
x6l=2.9; x6u=3.9;
x7l=5.0; x7u=5.5;

for i=1:1:10
    x0(1)=x1l+(x1u-x1l).*rand(1,1);
    
    x0(2)=x2l+(x2u-x2l).*rand(1,1);
    x0(3)=x3l+(x3u-x3l).*rand(1,1);
    x0(4)=x4l+(x4u-x4l).*rand(1,1);
    x0(5)=x5l+(x5u-x5l).*rand(1,1);
    x0(6)=x6l+(x6u-x6l).*rand(1,1);
    x0(7)=x7l+(x7u-x7l).*rand(1,1);
    
    SP(i,1) = x0(1);
    SP(i,2) = x0(2);
    SP(i,3) = x0(3);
    SP(i,4) = x0(4);
    SP(i,5) = x0(5);
    SP(i,6) = x0(6);
    SP(i,7) = x0(7);
    
   [x objval h] = GSR(x0);
   y1(i) = x(1);
   y2(i) = x(2);
   y3(i) = x(3);
   y4(i) = x(4);
   y5(i) = x(5);
   y6(i) = x(6);
   y7(i) = x(7);
   
   val(i)=objval;
   Fun = 0.7854.*h(:,1).*(h(:,2).^2).*(3.3333.*h(:,3).^2 + 14.9334.*h(:,3) - 43.0934) -1.5079.*h(:,1).*(h(:,6).^2+  h(:,7).^2 ) + 7.477.*(h(:,6).^3 + h(:,7).^3) + 0.7854.*(h(:,4).*h(:,6).^2 + h(:,5).*h(:,7).^2);
   plot(Fun,'*-');
   hold on;
end

grid on
legend('Run1','Run2','Run3','Run4','Run5','Run6','Run7','Run8','Run9','Run10');
title("\bf Golinski's Speed Reducer");
ylim([2000 5000]);

y=zeros(length(y1),2); % Last co-ordinates at the function terminated
y(:,1) = y1;
y(:,2) = y2;
y(:,3) = y3;
y(:,4) = y4;
y(:,5) = y5;
y(:,6) = y6;
y(:,7) = y7;
%% Display the Final Solution
SP
y
val
%% Golinski's Speed Reducer Function

function [x fval h] = GSR(x0)
    h = [];
    
    ll = [2.6,0.7,17,7.3,7.3,2.9,5.0];
    ul = [3.6,0.8,28,8.3,8.3,3.9,5.5];
    
    %no linear constraints
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    
    nonlcon=@nc;
    options=optimset('OutputFcn', @myoutput);
    [x,fval]=ga(@objfun,7,A,b,Aeq,beq,ll,ul,nonlcon,options);
        
    function stop = myoutput(x,optimvalues,state)
        stop = false;
        if isequal(state,'iter')
          h = [h; x];
        end
    end
    
    function f = objfun(x)
      f = 0.7854*x(1)*(x(2)^2)*(3.3333*x(3)^2 + 14.9334*x(3) - 43.0934) -1.5079*x(1)*(x(6)^2+  x(7)^2 ) + 7.477*(x(6)^3 + x(7)^3) + 0.7854*(x(4)*x(6)^2 + x(5)*x(7)^2);
    end
 % Constraints taken from the AIAA Journal given in the question
    function [c,ceq] = nc(x)
        c1 = (27/(x(1)*x(2)*x(2)*x(3))) - 1;
        c2 = (397.5/(x(1)*x(2)*x(2)*x(3)*x(3))) - 1;
        c3 = ((1.93*x(4)^3)/(x(2)*x(3)*x(6)^4)) - 1;
        c4 = ((1.93*x(5)^3)/(x(2)*x(3)*x(7)^4)) - 1;
        c5 = (((((745*x(4))/(x(2)*x(3)))^2 + 16.9*10^6)^(1/2))/(110.0*x(6)^3)) - 1;
        c6 = (((((745*x(5))/(x(2)*x(3)))^2 + 157.5*10^6)^(1/2))/(85.0*x(7)^3)) - 1;
        c7 = ((x(2)*x(3))/40) - 1;
        c8 = ((5*x(2))/x(1)) - 1;
        c9 = (x(1)/(x(2)*12)) - 1;
        c10 = (2.6/x(1)) - 1;
        c11 = (x(1)/3.6) - 1;
        c12 = (0.7/x(2)) - 1;
        c13 = (x(2)/0.8) - 1;
        c14 = (17/x(3)) - 1;
        c15 = (x(3)/28) - 1;
        c16 = (7.3/x(4)) - 1;
        c17 = (x(4)/8.3) - 1;
        c18 = (7.3/x(5)) - 1;
        c19 = (x(5)/8.3) - 1;
        c20 = (2.9/x(6)) - 1;
        c21 = (x(6)/3.9) - 1;
        c22 = (5/x(7)) - 1;
        c23 = (x(7)/5.5) - 1;
        c24 = ((1.5*x(6) + 1.9)/x(4)) - 1;
        c25 = ((1.1*x(7) + 1.9)/x(5)) - 1;
        

        c = [c1;c2;c3;c4;c5;c6;c7;c8;c9;c10;c11;c12;c13;c14;c15;c16;c17;c18;c19;c20;c21;c22;c23;c24;c25];

        ceq = [];
    end
end
