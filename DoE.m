% Let us define a design space of 10x10 co-ordinate space for our problem to carry out a DoE
% Our starting point is the origin
% We have 6 pickup stations randomly distributed in our design space

D_S=randi(10,6,2);

X=D_S(:,1);
Y=D_S(:,2);

% Plot
plot(X,Y,'bo','MarkerSize',10);
grid on
title('Design Space');
xlabel('x');
ylabel('y');
xlim([0 12]);
ylim([0 12]);

% Minimun distance between the starting point and pickup stations
d=sqrt(D_S(:,1).^2+D_S(:,2).^2)

% Find the closest and furthest station for pickup
[minDistance,indexOfMin] = min(d);
closestX = X(indexOfMin);
closestY = Y(indexOfMin);
hold on;
[maxDistance,indexOfMax] = max(d);
furthestX = X(indexOfMax);
furthestY = Y(indexOfMax);

% Highlight the closest station
plot(closestX,closestY,'k*','MarkerSize',8,'LineWidth',2);
% Highlight the furthest station
plot(furthestX,furthestY,'c*','MarkerSize',8,'LineWidth',2);

% Draw a line from starting point to the first station for pickup
line([0,closestX],[0,closestY],'LineWidth',2,'Color','r');
legend('Pickup Station','Clostest Station','Furthest Station','Shortest Path');