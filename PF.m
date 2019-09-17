CI= [2.05,0.62,0.90,16]; % Cost of I-Beam
CS= [2.05,0.62,0.90,0.04]; % Cost of the Support
DI= [2700,7850,7900,4500]; % Density of I-Beam
DS= [2700,7850,7900,2400]; % Density of the Support
FSI= [270*10^6,250*10^6,700*10^6,760*10^6]; % Failure stress of I-Beam
FSS= [270*10^6,250*10^6,700*10^6,70*10^6];% Failure stress of the Support
MoEI= [70*10^9,210*10^9,210*10^9,31*10^9]; % Modulus of Elasticity of I-Beam
MoES= [70*10^9,210*10^9,210*10^9,31*10^9]; % Modulus of Elasticity of the Support

% x=[b t h w d I S n]
lb=[0.1,0.01,0.1,0.2,0.3,1,1,1]; % Lower bound
ub=[1,0.5,2,2,3,4,4,4]; % Upper bound

%% Function
fun=@(x)min_cost(x,DI,MoEI,FSI,CI,DS,MoES,FSS,CS);
options=optimoptions('gamultiobj','PopulationSize',60,...
    'ParetoFraction',0.7,'PlotFcn',@gaplotpareto);

nonlcon=@(x)nc(x,DI,MoEI,FSI,CI,DS,MoES,FSS,CS);
IntCon=[6,7,8];
[x,fval,flag,output,population]=gamultiobj(fun,8,[],[],[],[],lb,ub,nonlcon,options);
x
fval

function Cost=min_cost(x,DI,MoEI,FSI,CI,DS,MoES,FSS,CS)
L=30;
H=5;
MI=(2*x(1)*x(2)+(x(3)-2*x(2))*x(2))*L*DI(x(6))*x(8);
MS=x(4)*x(5)*H*DS(x(7));
Cost=CI(x(6))*MI+CS(x(7))*MS+0.1*(CI(x(6))*MI+CS(x(7))*MS); % 10% increase in cost
end

function [C Ceq]=nc(x,DI,MoEI,FSI,CI,DS,MoES,FSS,CS)
L=30;
q=330000;
g=9.81;
H=5;
MI=(2*x(1)*x(2)+((x(3)-2*x(2))*x(2)))*L*DI(x(6))*x(8);
MS=x(4)*x(5)*H*DS(x(7));

C1= ((((q*((L/2)^2))+(((2*x(1)*x(2)+ ((x(3)-2*x(2))*x(2)))*L*DI(x(6))*x(8)*(L/4)*g)))/(8*(((((x(3)-2*x(2))^3)*x(2))/12)+2*((((x(2)^3)*x(1))/12)+(x(2)*x(1)*(((x(3)/2)-(x(2)/2))^2)))*x(8))))*(x(3)/2))-FSI(x(6));
C2= ((((2*x(1)*x(2)+((x(3)-2*x(2))*x(2)))*L*DI(x(6))*x(8)*g)+q*L)/(4*((2*x(1)*x(2))+((x(3)-2*x(2))*x(2)))*x(8)))-FSI(x(6));
C3= ((((2*x(1)*x(2)+((x(3)-2*x(2))*x(2)))*L*DI(x(6))*x(8)*g)+(q*L))/2)-(((3.14)^2*MoES(x(7))*min((((x(4)^3)*x(5))/12),((x(4)*(x(5)^3))/12)))/(4*H^2));
C4= (((((2*x(1)*x(2)+((x(3)-2*x(2))*x(2)))*L*DI(x(6))*x(8)*g)+(q*L))/2)/(x(4)*x(5)))-FSS(x(7));
C5=(2*x(2)/x(3))-1;
C6=(x(2)/x(1))-1;
C=[C1;C2;C3;C4;C5;C6];
Ceq=[];
end