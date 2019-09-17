x=-5:0.01:5;
y=x;
[x1,x2]=meshgrid(x);
f=(4*(x1).^2)+(12*(x2).^2);
contour3(f,500)
hold on
h=(x2.^2)-(x1-1).^3;
contour3(h,500)
hold off
