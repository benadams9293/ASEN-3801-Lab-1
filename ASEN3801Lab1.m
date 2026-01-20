% Contributors: --
% Course number: ASEN 3801
% File name: AirRelativeVelocityVectorToWindAngles
% Created: 01/13/26

clc;
clear;
close all;

%% Function for ode45 solving for Part 1 of the Lab

function dadt = ODESystem(t,a) % a = [w; x; y; z]

w = a(1);
x = a(2);
y = a(3);
z = a(4);

wdot = -9*w + y;
xdot = 4*w*x*y - x^2;
ydot = 2*w - x - 2*z;
zdot = x*y - y^2 - 3*z^3;

dadt = [wdot; xdot; ydot; zdot];
end

% Solving the above 4 ODEs using ode45 simultaneously
tspan = [0 20]; 
a0 = [1; 5; 1; 1];
opts = odeset('RelTol',10^-8, 'AbsTol',10^-8);
[t, a] = ode45(@ODESystem, tspan, a0, opts);

% Extracting the individual components from the solution
w = a(:, 1);
x = a(:, 2);
y = a(:, 3);
z = a(:, 4);

% Plotting the result
figure;
subplot(4, 1, 1);
plot(t, w);
xlabel('t (n.d.)'); ylabel('w (n.d.)');
grid on;

subplot(4, 1, 2);
plot(t, x);
xlabel('t (n.d.)'); ylabel('x (n.d.)');
grid on;

subplot(4, 1, 3);
plot(t, y);
xlabel('t (n.d.)'); ylabel('y (n.d.)');
grid on;

subplot(4, 1, 4);
plot(t, z);
xlabel('t (n.d.)'); ylabel('z (n.d.)');
grid on;


%% Function for ode45 solving for Part 2 of the Lab 

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
rho = 1.14; % [kg/m^3] Boulder Air Density
Cd = 0.6 ; % [NaN] Coefficient of drag
d = 2.0 *10^-2; % [m] diameter
A = pi*(d/2)^2; % [m^2] Area
m = .050; % [kg] Mass
g = [0 0 9.8]; % [m/s^2] Gravity
wind_vel = [5 0 0]; % dummy var :: three-dimensional wind velocity in inertial coordinates
x_initial = [ 5 0 -5 0 20 -20]'; % [m/s] :: the position variables are all dummy

% Get State Vector
function dx1dt = ODESystem1(t, x1)
xE_E = x1(1);
yE_E = x1(2);
zE_E = x1(3);
uE_E = x1(4);
vE_E = x1(5);
wE_E = x1(6);



dx1dt = [xE_Edot; yE_Edot; zE_Edot; uE_Edot; vE_Edot; wE_Edot];
end

%% Part a

%% Part b
% Get rho using stdatmo.m
%   Boulder at a geopotential altitude of 1655m on a standard day
rho = NULL ; %[kg/m³] Air density

%% Part c
wind_vel = [0 0 0];
xdot2 = objectEOM(t,x,rho,Cd,A,m,g,wind_vel);

ode45()

% Plot the trajectory of the object in three-dimensional space using a 
% three-dimensional figure in MATLAB
figure(Name="Problem 2 - part c")
hold on
plot3()
hold off

%% Part d
wind_vel = [NULL NULL NULL];
xdot2 = objectEOM(t,x,rho,Cd,A,m,g,wind_vel);


% d1)

% d2)

%% Part e



%% Part f



%% END

%% function wind_angles = AirRelativeVelocityVectorToWindAngles(velocity_body)
%
% Inputs: velocity_body = column vector of aircraft air-relative velocity in
% body  coordinates
% = [u,v,w]'
%
% Outputs: wind_angles = [speed beta alpha]'
% speed = aircraft airspeed
% beta = side slip angle
% alpha = angle of attack
%
% Methodology: Use definitions to calculate wind angles and speed from velocity
% vector