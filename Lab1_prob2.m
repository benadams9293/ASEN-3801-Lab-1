
% Contributors: Ben Adams, Paris Larson
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
clc;
clear all;
close all;

%% Variables
tspan = [0 100]; %[s] dummy time range
[rho,a,T,P,nu,ZorH] = stdatmo(1655,0,'',true); %[kg/m³] Air density
Cd = 0.6 ; %[NaN] Coefficient of drag
d = 2.0 *10^-2; % [m] diameter
A = pi*(d/2)^2; % [m^2] Area
m = 0.050; %[kg] Mass
g = 9.81; %[m/s^2] Gravity
wind_vel = [0;0;0]; % dummy var :: three-dimensional wind velocity in inertial coordinates

% Get State Vector
pEE_0 = [0; 0; 0]; % starting x position UPDATE!!
vEE_0 = [0; 20; -20]; % starting velocity x position UPDATE!!
% Statevector starting position
x0 = [pEE_0; vEE_0];

%% ODE options
options = odeset('RelTol',1e-8,'AbsTol',1e-8);

%input options into brackets
[tout,xout] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel),tspan,x0, options);

xE_E = xout(:,1);
yE_E = xout(:,2);
zE_E = xout(:,3);


figure(Name="Problem 2 - part c")
hold on
%-zE_E to flip the Down axis into height
plot3(xE_E, yE_E,-zE_E,'LineWidth',2);
grid on;
xlabel('North (m)');
ylabel('East (m)');
zlabel('Height (m)');
title('Problem 2c: 3D Trajectory of Object');

hold off

%% Problem 2 part d
%varying the wind speeds
var_wind_speeds = 0:2:20; %[m/s]
x_land = zeros(size(wind_speeds));
range_land = zeros(size(wind_speeds));
for i = 1:length(var_wind_speeds)
    wind_vel = [var_wind_speeds(i);0;0];
    [~,xout_d] = ode45(@(t,x) objectEOM(t,x,rho,Cd,A,m,g,wind_vel),tspan,x0, options);
    land_position = xout_d(end,1:3);


end

