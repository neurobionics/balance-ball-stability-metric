clear
close all

% This script tests the dynamics function. Checked on 6/20/23 that it
% matches Fig 2a in the reference paper, so dynamics seem to work. 

t = linspace(0, 10, 10000); 
phi = 0.01 * cos(t); 
phidot = -0.01 * sin(t);
phiddot = -0.01 * cos(t); 

theta = -0.01 * sin(t); 
thetadot = -0.01*cos(t); 
thetaddot = 0.01 * sin(t); 

q0 = [0; 0; 0;0;0;0];

odefunc = @(tsim,q) dynamics(q, interp1(t, theta, tsim),...
                                interp1(t, phi, tsim),interp1(t, thetadot, tsim),...
                                interp1(t, phidot, tsim),interp1(t, thetaddot, tsim),...
                                interp1(t, phiddot, tsim));
[tout, qout] = ode45(odefunc, t, q0); 
    
plot(qout(:,1), qout(:,2))
ylim([-20, 70]/100)
xlim([0, 30]/100)
axis equal
grid on