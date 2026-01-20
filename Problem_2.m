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
rho = 1.14; %[kg/m^3] Boulder Air Density
Cd = 0.6 ; %[NaN] Coefficient of drag
d = 2.0 *10^-2; % [m] diameter
A = pi*(d/2)^2; % [m^2] Area
m = .050; %[kg] Mass
g = [0 0 9.8]; %[m/s^2] Gravity
wind_vel = [5 0 0]; % dummy var :: three-dimensional wind velocity in inertial coordinates
x_initial = [ 5 0 -5 0 20 -20]'; %[m/s] :: the position variables are all dummy

%% Rho
    % Get Rho
    % Boulder at a geopotential altitude of 1655m on a standard day
    [rho,a,T,P,nu,ZorH] = stdatmo(1655,0,'',true); %[kg/m³] Air density

%% Const. Wind velocity | Const. Rho
    wind_vel = [0 0 0];
    
    % State vector
    [t,x] = ode45(@(t,x) objectEOM(t,x_0,rho,Cd,A,m,g,wind_vel),tspan,statevector_0);
    
    figure(Name="Problem 2 - part c")
    hold on
    plot3()
    hold off
    
%% Varriable Wind velociticy | Const. Rho
    
    % State vector
    [t,x] = ode45(@(t,x) objectEOM(t,x_0,rho,Cd,A,m,g,wind_vel),tspan,statevector_0);
    
    figure(Name="Problem 2 - part d")
    hold on
    plot3()
    hold off


%% Varriable Rho | Const. Wind velocity 



%% Varriable Mass | Const. Wind Velocity | Const. Rho | Const. Specific Energy



