function xdot = objectEOM(t,x,rho,Cd,A,m,g,wind_vel)
% Contributors: Ben Adams, Paris Larson
% Course number: ASEN 3801
% File name: objectEOM.m
% Created: 1/13/2026
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Inputs: t = time (s)
%         x = State Vector [position; velocity] in inertial coordinates
%            x = [x_E; y_E; z_E; vx_E; vy_E; vz_E]
%         rho = 1.14 [kg/m³] Air density
%         Cd = 0.6 [NaN] Coefficient of drag
%         A = cross-sectional area (m^2)
%         m = 50 [g] Mass
%         g = gravitational acceleration (m/s^2)
%         wind_vel = inertial wind velocity vector (m/s)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Outputs: xdot = Derivative of State Vector x (with respect to time as a 
%                    function of the time,the state, the physical 
%                    parameters of the problem, and the three-dimensional 
%                    wind velocity in inertial coordinates)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%Decomposing the statevector into position and velocity components
position_E = x(1:3);
velocity_E = x(4:6);

%Air-relative velocity
v_air = velocity_E - wind_vel;
V_air = norm(v_air);

%Drag force
if V_air > 0
    Fdrag = -(v_air/ V_air).*((1/2).*Cd.*A.*rho.*V_air.^2);
else
    Fdrag = [0;0;0];
end

%Gravitional Force (NED: positive down)
Fgravity = [0;0;m*g];

accel_E = (Fdrag + Fgravity) / m;

xdot = zeros(6,1);
xdot(1:3) = velocity_E; %position derivative
xdot(4:6) = accel_E; %velocity derivatice

end
