
function qdot = dynamics(q, theta, phi, thetadot, phidot, phiddot, thetaddot)
% https://openresearch.lsbu.ac.uk/download/686833395ced713bba681ef2035f99f2b17c4d98ecd8d45ae8d4959b259a55ab/253688/RollTip%28v5%29.pdf
g = 9.81;
r = .1;
m = .1; 

% Extract variables
x = q(1); 
y = q(2); 
gamma = q(3); 
xdot = q(4); 
ydot = q(5); 
gammadot = q(6); 

% Arbitrary damping to improve controlability
b = .8; 

% Calculate dynamics
termA = 1/5 * [
        7*r*cos(theta) + 5*y*sin(theta), 0; 
        5*x*sin(theta), 7*r;
        -2*r*sin(theta), 0
    ] * [phiddot; thetaddot];

termB = 1/5 * [7,0,0;0,-7,0;0,0,2*r];
termC = [-x, 0;
    y*sin(theta)^2 + r*cos(theta)*sin(theta), y;
    0,0] * [phidot^2; thetadot^2];

termD = 1/5* [10*y*cos(theta) - 12*r*sin(theta), 0, 12*sin(theta), 0, 0, -2*r; ...
    0, 12*sin(theta), 0, 2*r*cos(theta), 0, 0;...
    -2*r*cos(theta), 0, 2*cos(theta), 0, 2, 0] * ...
    [phidot*thetadot; phidot*xdot; phidot*ydot; phidot*gammadot; thetadot*xdot; thetadot*ydot]; 

termE = g * [sin(phi); cos(phi)*sin(theta); 0];

x_y_gamma_ddot = termB \ (termE - termA - termC - termD) - b * [xdot; ydot; gammadot];
qdot = [xdot; ydot; gammadot; x_y_gamma_ddot]; 
end



