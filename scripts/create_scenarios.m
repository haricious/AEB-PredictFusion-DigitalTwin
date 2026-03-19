%% 
% scripts/create_scenarios.m
% Generates the cuboid scenarios automatically instead of using the GUI.

if ~exist('../scenarios', 'dir'); mkdir('../scenarios'); end

%% Scenario 1: Highway Emergency Stop
scenario = drivingScenario('SampleTime', 0.01);
roadCenters = [0 0 0; 200 0 0];
road(scenario, roadCenters, 'Lanes', lanespec(2));

% Ego Vehicle
egoVehicle = vehicle(scenario, 'ClassID', 1, 'Position', [10 0 0], 'Velocity', [22.22 0 0]);
% Target Vehicle (Stops abruptly)
targetVehicle = vehicle(scenario, 'ClassID', 1, 'Position', [70 0 0], 'Velocity', [15 0 0]);
trajectory(targetVehicle, [70 0 0; 120 0 0; 130 0 0], [15; 15; 0]); % Slows down to 0

save('../scenarios/highway_emergency_stop.mat', 'scenario');

%% Scenario 2: Cut-in Hazard
scenario2 = drivingScenario('SampleTime', 0.01);
road(scenario2, roadCenters, 'Lanes', lanespec(2));

ego2 = vehicle(scenario2, 'ClassID', 1, 'Position', [10 -2 0], 'Velocity', [22.22 0 0]);
target2 = vehicle(scenario2, 'ClassID', 1, 'Position', [30 2 0], 'Velocity', [18 0 0]);
% Target cuts into ego lane aggressively
trajectory(target2, [30 2 0; 50 2 0; 60 -2 0; 100 -2 0], [18; 18; 15; 15]);

save('../scenarios/cut_in_hazard.mat', 'scenario2');

disp('>> SIXXIS AEB: 3D Scenarios generated and saved to /scenarios.');