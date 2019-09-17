hVec=logspace(-15,1); % Step Size
x=1; % Given

f=exp(x); % Given Fuction
df=exp(x); % First Derivative of Function
dff=exp(x); % Second Derivative of Function

y1=exp(x+hVec); % Forward Difference
y2=exp(x-hVec); % Backward Difference
% Complex
hcomp=complex(0,hVec);
ycomp=real(exp(x + hcomp));

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
title('\bf Second Derivative Error of e^x');
xlabel('Step Size');
ylabel('Error in Derivatives');
legend('Second-Order','Complex');