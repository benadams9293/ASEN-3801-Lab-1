% Contributors: Ben Adams, 
% Course number: ASEN 3801
% File name: Problem_2
% Created: 1/13/2026
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Methodology: Study the translational dynamics of a spherical object 
%              moving through the air in an approximate dynamical model.
%  - Assume that the forces acting on the body are not a function of the 
%      body attitude. 
%       - The forces acting on the bodyinclude aerodynamic drag and gravity
%  - Right-handed and orthogonal axes of the inertial frame follow the 
%       convention North-East-Down
%  - Assume the object is here in Boulder to determine the air 
%       density
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Null = 0;
%% Variables
t = NULL; % UNKOWN
Cd = 0.6 ; %[NaN] Coefficient of drag
A = NULL; % UNKOWN
m = .050; %[kg] Mass
g = [0 0 9.8]; %[m/s^2] Gravity
wind_vel = []; % three-dimensional wind velocity in inertial coordinates
x_initial = [ NULL NULL NULL; 20 20 0]; %[m/s]

% Get State Vector
x = [pEE; vEE];

% Get rho using stdatmo.m
%   Boulder at a geopotential altitude of 1655m on a standard day
rho = NULL ; %[kg/m³] Air density



%% Call Functions
% Part c
wind_vel = [0 0 0];
xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel);

% part d
wind_vel = [NULL NULL NULL];
xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel);



