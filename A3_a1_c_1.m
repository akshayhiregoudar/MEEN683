hVec=logspace(-15,1); % Step Size
x=1; % Given

f=exp(x); % Given Fuction
df=exp(x); % First Derivative of Function

y1=exp(x+hVec); % Forward Difference
y2=exp(x-hVec); % Backward Difference
% Complex
hcomp=complex(0,hVec);
ycomp=imag(exp(x + hcomp));

% Finite Difference Method
ff=(y1-f)./hVec;
ef=abs(ff-df);

% Central Difference Method
fc=((y1-y2)/2)./hVec;
ec=abs(fc-df);

% Complex Step Estimate
fi=ycomp./hVec;
ei=abs(fi-df);

if ei==0
   ei=10^-20;
end

loglog(hVec,ef,'*-');
hold on;
loglog(hVec,ec,'*-');
hold on;
loglog(hVec,ei,'*-');
hold on;
grid on;
title('\bf First Derivative Error of e^x');
xlabel('Step Size');
ylabel('Error in Derivatives');
legend('Finite','Central','Complex');