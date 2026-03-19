% scripts/create_scenarios.m
% Generates all three simulation environments programmatically.

% Ensure the scenarios directory exists
if ~exist('../scenarios', 'dir')
    mkdir('../scenarios'); 
end

disp('>> Generating 3D Driving Scenarios...');

%% ------------------------------------------------------------------------
% SCENARIO 1: Highway Emergency Stop
% ------------------------------------------------------------------------
scenario1 = drivingScenario('SampleTime', 0.01);
roadCenters = [0 0 0; 200 0 0];
road(scenario1, roadCenters, 'Lanes', lanespec(2));

% Ego Vehicle (Going 80 km/h)
ego1 = vehicle(scenario1, 'ClassID', 1, 'Position', [10 0 0], 'Velocity', [22.22 0 0]);

% Target Vehicle (Ahead, slows down abruptly)
target1 = vehicle(scenario1, 'ClassID', 1, 'Position', [70 0 0], 'Velocity', [15 0 0]);
trajectory(target1, [70 0 0; 120 0 0; 130 0 0], [15; 15; 0]); % Brakes to a stop

save('../scenarios/highway_emergency_stop.mat', 'scenario1');
disp('   -> Saved: highway_emergency_stop.mat');


%% ------------------------------------------------------------------------
% SCENARIO 2: Cut-in Hazard
% ------------------------------------------------------------------------
scenario2 = drivingScenario('SampleTime', 0.01);
road(scenario2, roadCenters, 'Lanes', lanespec(2));

% Ego Vehicle (Right lane)
ego2 = vehicle(scenario2, 'ClassID', 1, 'Position', [10 -2 0], 'Velocity', [22.22 0 0]);

% Target Vehicle (Left lane, speeds up and cuts in)
target2 = vehicle(scenario2, 'ClassID', 1, 'Position', [30 2 0], 'Velocity', [18 0 0]);
trajectory(target2, [30 2 0; 50 2 0; 60 -2 0; 100 -2 0], [18; 18; 15; 15]);

save('../scenarios/cut_in_hazard.mat', 'scenario2');
disp('   -> Saved: cut_in_hazard.mat');


%% ------------------------------------------------------------------------
% SCENARIO 3: Pedestrian Collision (The missing file)
% ------------------------------------------------------------------------
scenario3 = drivingScenario('SampleTime', 0.01);
road(scenario3, roadCenters, 'Lanes', lanespec(2));

% Ego Vehicle (Urban speed limit: 50 km/h -> 13.8 m/s)
ego3 = vehicle(scenario3, 'ClassID', 1, 'Position', [10 0 0], 'Velocity', [13.8 0 0]);

% Pedestrian (ClassID 4 is standard for pedestrians)
% Dimensions: Length 0.24m, Width 0.45m, Height 1.7m
pedestrian = actor(scenario3, 'ClassID', 4, 'Length', 0.24, 'Width', 0.45, 'Height', 1.7, ...
                   'Position', [60 4 0]);

% Pedestrian walks across the road perpendicular to the ego vehicle
trajectory(pedestrian, [60 4 0; 60 -4 0], [1.5; 1.5]); % Walking at 1.5 m/s

save('../scenarios/pedestrian_collision.mat', 'scenario3');
disp('   -> Saved: pedestrian_collision.mat');

disp('>> All scenarios successfully generated and saved.');