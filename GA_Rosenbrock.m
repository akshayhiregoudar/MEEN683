l=-5; % Lower Limit
u=5; % Upper Limit
n=10; % No.of Iterations

SP = zeros(10,2); % Starting Points

for i=1:n
x0(1)=l+(u-l).*rand(1,1); % Generate random X-Coordinates within limit
x0(2)=l+(u-l).*rand(1,1); % Generate random Y-Coordinates within limit
SP(i,1) = x0(1); % X-Coordinate
SP(i,2) = x0(2); % Y-Coordinate
[xi,objval,h] = RB(x0)
x=xi.'
y1(i) = x(1);
y2(i) = x(2);
val(i)=objval;
F = 100.*(h(2,:)-h(1,:).^2).^2  + (1-h(1,:)).^2;
Fun=F.';
plot(Fun,'*-');
hold on;
end

grid on
legend('Run1','Run2','Run3','Run4','Run5','Run6','Run7','Run8','Run9','Run10');
title('\bf Rosenbrock Function');

y = zeros(length(y1),2); % Last co-ordinates at which the program terminated
y(:,1) = y1;
y(:,2) = y2;
%% Display The Final Solution

SP
y
val
%% Define Rosenbrock Function

function [x objval h] = RB(x0)
h=[];
options = optimset('OutputFcn', @output);
[x objval] = ga(@objfun,1,options);
        
function stop = output(x,optimumvalues,state)
    stop = false;
    if isequal(state,'iter')
        h = [h x];
    end
end
    
function f = objfun(x)
    f=(100.*(x(2)-x(1).^2).^2+(1-x(1)).^2);
end
end