% Bridge Design Problem

% Generate random values for the given variables using x=x_min+(x_max - x_min);

h = 0.1+rand*1.9; % Height
b = 0.1+rand*0.9; % Flange width
t = 0.01+rand*0.49; % Thickness
w = 0.2+rand*1.8; % Width
d = 0.3+rand*2.7; % Depth
n=randi([1,4],1,1);


% Grouping the variables
x0 = [h,b,t,w,d,n];

[x,fval,EXITFLAG,OUTPUT,POPULATION,scores] = min_cost();
%% Solution

x
fval
%% Cost optimization using GA

function [x,fval,exitflag,output,pop,scores]= min_cost()

    L=30;
    q=330000;
    g=9.81;
    H=5;

    CI= [2.05,0.62,0.90,16]; % Cost of I-Beam
    CS= [2.05,0.62,0.90,0.04]; % Cost of the Support
    DI= [2700,7850,7900,4500]; % Density of I-Beam
    DS= [2700,7850,7900,2400]; % Density of the Support
    FSI= [270*10^6,250*10^6,700*10^6,760*10^6]; % Failure stress of I-Beam
    FSS= [270*10^6,250*10^6,700*10^6,70*10^6]; % Failure stress of the Support
    MoES= [70*10^9,210*10^9,210*10^9,31*10^9]; % Modulus of Elasticity of the Support
   
    
    for i = 1:4
        for j = 1:4
        
        A=[-1 0 2 0 0 0;0 -1 1 0 0 0];
        b=[0;0];
        lb=[0.1,0.1,0.01,0.2,0.3,1];
        ub=[2,1,0.5,2,3,4];

        options = optimoptions('ga','PlotFcn',@gaplotbestf,'ConstraintTolerance',1e-10,'FunctionTolerance',1e-20,...
            'CrossoverFraction',0.8,...
            'PopulationSize',50,'PenaltyFactor',1000);
             
[x,fval,exitflag,output,pop,scores]=ga(@Cost,6,A,b,[],[],lb,ub,[],[],options);
        end
    end
    function f= Cost(x)
         f=(CI(i)*((2*x(2)*x(3)+((x(1)-2*x(3))*x(3)))*L*DI(i)*x(6)))+(CS(j)*x(4)*x(5)*H*DS(j));
    end 

    function [C Ceq]=confun(x)
    
    % Constraints
    C(1)= ((((q*((L/2)^2))+(((2*x(2)*x(3)+ ((x(1)-2*x(3))*x(3)))*L*DI(i)*x(6)*(L/4)*g)))/(8*(((((x(1)-2*x(3))^3)*x(3))/12)+2*((((x(3)^3)*x(2))/12)+(x(3)*x(2)*(((x(1)/2)-(x(3)/2))^2)))*x(6))))*(x(1)/2))-FSI(i);
    C(2)= ((((2*x(2)*x(3)+((x(1)-2*x(3))*x(3)))*L*DI(i)*x(6)*g)+q*L)/(4*((2*x(2)*x(3))+((x(1)-2*x(3))*x(3)))*x(6)))-FSI(i);
    C(3)= ((((2*x(2)*x(3)+((x(1)-2*x(3))*x(3)))*L*DI(i)*x(6)*g)+(q*L))/2)-(((3.14)^2*MoES(j)*min((((x(4)^3)*x(5))/12),((x(4)*(x(5)^3))/12)))/(4*H^2));
    C(4)= (((((2*x(2)*x(3)+((x(1)-2*x(3))*x(3)))*L*DI(i)*x(6)*g)+(q*L))/2)/(x(4)*x(5)))-FSS(j);
    Ceq=[];
end
end