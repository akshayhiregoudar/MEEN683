hVec=logspace(-15,1); % Step Size
x=1; % Given

f=x.^2; % Given Fuction
df=2.*x; % First Derivative of Function

y1=(x+hVec).^2; % Forward Difference
y2=(x-hVec).^2; % Backward Difference
% Complex
hcomp=complex(0,hVec);
ycomp=imag((x + hcomp).^2);

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
title('\bf First Derivative Error of x^2');
xlabel('Step Size');
ylabel('Error in Derivatives');
legend('Finite','Central','Complex');