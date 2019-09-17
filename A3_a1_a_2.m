hVec=logspace(-15,1); % Step Size
x=1; % Given

f=x^2; % Given Fuction
df=2.*x; % First Derivative of Function
dff=2; % Second Derivative of Function

y1=(x+hVec).^2; % Forward Difference
y2=(x-hVec).^2; % Backward Difference
% Complex
hcomp=complex(0,hVec);
ycomp=real((x + hcomp).^2);

% Second-Order Estimate
ff=(y1 - 2.*f + y2)./(hVec.^2);
ef=abs(ff-dff);

% Complex Step Second Derivative Estimate
fi=2.*(f - ycomp)./(hVec.^2);
ei=abs(fi-dff);

loglog(hVec,ef,'*-');
hold on;
loglog(hVec,ei,'*-');
hold on;
grid on;
title('\bf Second Derivative Error of x^2');
xlabel('Step Size');
ylabel('Error in Derivatives');
legend('Second-Order','Complex');