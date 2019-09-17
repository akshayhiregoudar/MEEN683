hVec=logspace(-15,1); % Step Size
x=1; % Given

f=x^3; % Given Fuction
df=3.*(x.^2); % First Derivative of Function
dff=6.*x; % Second Derivative of Function

y1=(x+hVec).^3; % Forward Difference
y2=(x-hVec).^3; % Backward Difference
% Complex
hcomp=complex(0,hVec);
ycomp=real((x + hcomp).^3);

% Second-Order Estimate
ff=(y1 - 2.*f + y2)./(hVec.^2);
ef=abs(ff-dff);

% Complex Step Second Derivative Estimate
fi=2.*(f - ycomp);
fi=fi./(hVec.^2);
ei=abs(fi-dff);

loglog(hVec,ef,'*-');
hold on;
loglog(hVec,ei,'*-');
hold on;
grid on;
title('\bf Second Derivative Error of x^3');
xlabel('Step Size');
ylabel('Error in Derivatives');
legend('Second-Order','Complex');