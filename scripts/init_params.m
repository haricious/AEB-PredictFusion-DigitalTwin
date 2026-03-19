% scripts/init_params.m
% Initializes all physical, system, and algorithmic constants for the AEB simulation.

clc; clear;

%% 1. Timing and Solver Parameters (Deterministic Execution)
Ts = 0.01;                  % Fixed-step sample time (10ms / 100Hz)
T_sim = 15;                 % Total simulation time (seconds)

%% 2. Vehicle Dynamics (Ego Vehicle)
mass_ego = 1800;            % Vehicle mass in kg (SUV-class)
v0_ego = 22.22;             % Initial ego velocity (80 km/h)
a_max_brake = -9.81;        % Max deceleration (1G)
tau_brake = 0.2;            % Hydraulic brake system delay (seconds)

%% 3. Sensor Noise Characteristics
% Radar (Good distance/velocity, poor lateral)
radar_range_noise = 0.5;    % meters variance
radar_vel_noise = 0.1;      % m/s variance

% Vision (Good classification, decent lateral, noisy distance)
vision_range_noise = 1.5;   % meters variance
vision_vel_noise = 0.4;     % m/s variance

%% 4. AEB Controller Thresholds (TTC)
TTC_WARN = 2.2;             % Audio/Visual Warning threshold (seconds)
TTC_PARTIAL = 1.4;          % 40% Braking engagement threshold
TTC_EMERG = 0.8;            % 100% Emergency Braking threshold

disp('>> SIXXIS AEB: Initial Parameters Loaded.');