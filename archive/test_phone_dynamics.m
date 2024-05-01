clearvars 
close all




if ~exist('m','var')
    m = mobiledev;
end
sampleRate = 25; 
dt = 1/sampleRate; 

m.SampleRate = 50; 
m.AngularVelocitySensorEnabled = 1;
m.OrientationSensorEnabled = 1;

disp('Connecting to device...')
while isempty(m.Orientation)
    m.Logging = 1;
end
disp('Connected!')


%time logger
time_log=0

totalTime = tic;

q = zeros(6,1); 
tlog = 0;
qlog = q; 
while toc(totalTime) < 20
    loopRate = tic; 
    orient = m.Orientation;
    angVel = m.AngularVelocity; 
    if ~isempty(orient)
        theta = -deg2rad(orient(2));
        phi = deg2rad(orient(3)); 
        thetadot = -deg2rad(angVel(2));
        phidot = deg2rad(angVel(3));
    end
    odefun = @(tsim, q) dynamics(q, theta, phi, thetadot,phidot,0,0); 
    [tout, qout] = ode45(odefun, [0, dt], q); 
    
    q = qout(end,:)';
    qlog = [qlog, q];
    tlog = [tlog, toc(totalTime)];
   
    hold off
    xlog = qlog(1,:);
    ylog = qlog(2,:);
    plot(xlog, ylog, '-','Color','#bbbbbb','LineWidth',3)
    hold on
    scatter(0,0,1500,hex2rgb('31ab1b'),'filled','pentagram')
    scatter(q(1), q(2),400,hex2rgb('046ebf'), 'filled')
    curX = q(1);
    xlim([min(curX,-3), max(curX,3)])
    axis equal
    drawnow limitrate nocallbacks
    
    %time logger
    time_log=[time_log,(toc(loopRate))];
    
    while toc(loopRate) < dt
        pause(.00000001)
    end


end

%rmse score, basically our measure of test performance
dist=sqrt(xlog.^2+ylog.^2);
n=size(dist);
n=n(2); 
rmse=sqrt(sum(dist.^2)/n);

%another metric, per-step RMSE, could be useful
%(assumes expected value is previous point)
diffX=diff(xlog);
diffY=diff(ylog);
stepDist=hypot(diffX,diffY);
stepDev=sqrt(sum(stepDist)/n);



fprintf("RMSE: "+ rmse + "\n");
fprintf("Point-Wise RMSE: " + stepDev + "\n");

m.Logging = 0; 

%time logger
disp(mean(time_log))


