clc; clear; close all;
G = 6.673 * 10^(-11);
M = 5.972 * 10^24;
radius = 6371000;
ISS_height = 420000;
ISS_velocity = 8665;
ISS_time = 90*60;
n = randn(3, 1); n = n / norm(n);
T = null(n');
tau = T*randn(2, 1); tau = tau / norm(tau);

r0 = n * (radius + ISS_height);
v0 = tau * ISS_velocity;

tspan = linspace(0, 2*ISS_time, 10^5);
x0 = [r0; v0];
odefun = @(t, x) [x(4:6); -G*M*x(1:3) / ((norm(x(1:3)))^3)];

opts = odeset('Reltol',1e-13,'AbsTol',1e-14,'Stats','on');

[t, x] = ode89(odefun,tspan,x0, opts);

figure
subplot(2, 2, 1) 
plot(t, x(:, 1:3))
subplot(2, 2, 3)
plot(t, x(:, 4:6))

subplot(2, 2, [2, 4])
plot3(x(:, 1), x(:, 2), x(:, 3), 'r', 'Linewidth', 1.5); hold on;
plot3(0, 0, 0, 'o', 'MarkerFaceColor', 'r')
plot3(x(1, 1), x(1, 2), x(1, 3), 'o', 'MarkerFaceColor', 'k')
grid on;

earth_sphere(50,'m')