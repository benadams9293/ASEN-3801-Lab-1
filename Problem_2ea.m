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

n = 100;

space = (20/(n-1));
y_wind_velo = [-10: space : 10];
wind_vel = zeros(3, n);
wind_vel(2,:) = y_wind_velo; % dummy var :: three-dimensional wind velocity in inertial coordinates

% Create air density vector
alts = [0 1000 2000 3000 4000];
for i = 1:5
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
    [tout1,xout1] = ode45(@(t,x) objectEOM(t,x,rho(1),Cd,A,m,g,wind_vel(:,i)),tspan,x0, options);
    [tout2,xout2] = ode45(@(t,x) objectEOM(t,x,rho(2),Cd,A,m,g,wind_vel(:,i)),tspan,x0, options);
    [tout3,xout3] = ode45(@(t,x) objectEOM(t,x,rho(3),Cd,A,m,g,wind_vel(:,i)),tspan,x0, options);
    [tout4,xout4] = ode45(@(t,x) objectEOM(t,x,rho(4),Cd,A,m,g,wind_vel(:,i)),tspan,x0, options);
    [tout5,xout5] = ode45(@(t,x) objectEOM(t,x,rho(5),Cd,A,m,g,wind_vel(:,i)),tspan,x0, options);
    
    % Sort out useful data
    yE_E1 = xout1(:,2);
    zE_E1 = xout1(:,3);
    
    yE_E2 = xout2(:,2);
    zE_E2 = xout2(:,3);
    
    yE_E3 = xout3(:,2);
    zE_E3 = xout3(:,3);
    
    yE_E4 = xout4(:,2);
    zE_E4 = xout4(:,3);
    
    yE_E5 = xout5(:,2);
    zE_E5 = xout5(:,3);
    
    % Indentify zeros
    sen = 70;
    [minValue11, minIndex11] = min(abs(zE_E1));
    zE_E1(1:sen) = [];
    [minValue12, minIndex12] = min(abs(zE_E1));
    minIndex12 = minIndex12 + sen;

    [minValue21, minIndex21] = min(abs(zE_E2));
    zE_E2(1:sen) = [];
    [minValue22, minIndex22] = min(abs(zE_E2));
    minIndex22 = minIndex22 + sen;

    [minValue31, minIndex31] = min(abs(zE_E3));
    zE_E3(1:sen) = [];
    [minValue32, minIndex32] = min(abs(zE_E3));
    minIndex32 = minIndex32 + sen;

    [minValue41, minIndex41] = min(abs(zE_E4));
    zE_E4(1:sen) = [];
    [minValue42, minIndex42] = min(abs(zE_E4));
    minIndex42 = minIndex42 + sen;

    [minValue51, minIndex51] = min(abs(zE_E5));
    zE_E5(1:sen) = [];
    [minValue52, minIndex52] = min(abs(zE_E5));
    minIndex52 = minIndex52 + sen;

    % Calculate distances
    distance1(i) = yE_E1(minIndex12);
    distance2(i) = yE_E2(minIndex22);
    distance3(i) = yE_E3(minIndex32);
    distance4(i) = yE_E4(minIndex42);
    distance5(i) = yE_E5(minIndex52);

end



%% Part e

figure(Name="Problem 2 - part e")
hold on
%-zE_E to flip the Down axis into height
plot(wind_vel(2,:),distance1,'LineWidth',2)
plot(wind_vel(2,:),distance2,'LineWidth',2)
plot(wind_vel(2,:),distance3,'LineWidth',2)
plot(wind_vel(2,:),distance4,'LineWidth',2)
plot(wind_vel(2,:),distance5,'LineWidth',2)
grid on;
xlabel('y Axis Wind velocity(m/s)');
ylabel('Landing distance (m)');
legend('H = 0 ft', 'H = 1000 ft', 'H = 2000 ft', 'H = 3000 ft', 'H = 4000 ft')
title('Problem 2e: Landing Distances vs. Wind Velocity With Varying Altitude');
hold off
