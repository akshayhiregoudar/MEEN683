x1=-100:1:100;
x2=x1;

[x1,x2]=meshgrid(x1,x2);

f=@(x1,x2)(4*(x1).^2)+(12*(x2).^2);
fcontour(f)
hold on

h=@(x1,x2)(x2.^2)-(x1-1).^3;
fcontour(h)
plot(1,0,'r*')
xL=xlim;
yL=ylim;
line(xL,[0 0]);
line([0 0],yL);
grid on
hold off