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
Cd = 0.6 ; %[NaN] Coefficient of drag
d = 2.0 *10^-2; % [m] diameter
A = pi*(d/2)^2; % [m^2] Area
m = 0.050; %[kg] Mass
g = 9.81; %[m/s^2] Gravity
wind_vel = [0; 0; 0];

n = 100;

space = (5000/(n-1));

% Create air density vector
alts = [0: space: 5000];
for i = 1:n
    [rho(i),a,T,P,nu,ZorH] = stdatmo(alts(i),0,'',true); %[kg/m³] Air density
end
% Get State Vector
pEE_0 = [0; 0; 0]; % starting x position UPDATE!!
vEE_0 = [0; 20; -20]; % starting velocity x position UPDATE!!
% Statevector starting position
x0 = [pEE_0; vEE_0];

%% ODE options
options = odeset('RelTol',1e-8,'AbsTol',1e-8);

%input options into brackets
for i = 1:n
    [tout,xout] = ode45(@(t,x) objectEOM(t,x,rho(i),Cd,A,m,g,wind_vel),tspan,x0, options);
    
    
    % Sort out useful data
    yE_E = xout(:,2);
    zE_E = xout(:,3);
    
    
    % Indentify min (index of landing value)
    sen = 70;
    zE_E(1:sen) = [];
    zE_E = abs(zE_E);
    [minValue, minIndex] = min(zE_E);
    minIndex = minIndex + sen;
    
    % Calculate distances
    distance(i) = yE_E(minIndex);

end



%% Part e

figure(Name="Problem 2 - part e")
hold on
%-zE_E to flip the Down axis into height
plot(alts,distance,'LineWidth',2)

grid on;
xlabel('Geopotential Altitude (m)');
ylabel('Landing distance (m)');
title('Problem 2e: Landing distances vs. Geopotential Altitude');
hold off
