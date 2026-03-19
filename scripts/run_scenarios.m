% scripts/run_scenario_tests.m
% SIXXIS AEB: Automated Scenario Testing Suite

% 1. Initialization
run('init_params.m');
run('setup_bus.m');

test_scenarios = {
    'highway_emergency_stop.mat', ...
    'pedestrian_collision.mat', ...
    'cut_in_hazard.mat'
};

% Create results directory if it doesn't exist
if ~exist('../results/data', 'dir'), mkdir('../results/data'); end

fprintf('Starting SIXXIS AEB Deterministic Testing...\n');
fprintf('-------------------------------------------\n');

for i = 1:length(test_scenarios)
    scenario_path = ['../scenarios/', test_scenarios{i}];
    fprintf('Testing: %s\n', test_scenarios{i});
    
    % Pass the file path to the Simulink Scenario Reader block
    % (Make sure your Scenario Reader block File Name is set to: scenario_file)
    scenario_file = scenario_path; 
    
    % Run the simulation
    try
        simOut = sim('../models/AEB_Main_System.slx', 'StopTime', '10');
        
        % 2. Extract Metrics for Chapter 8
        dist_data = simOut.logsout.get('True_d_rel').Values.Data;
        vel_data = simOut.logsout.get('Ego_Velocity').Values.Data;
        ttc_data = simOut.logsout.get('ttc').Values.Data;
        
        stop_gap = min(dist_data); % Closest the car got to the target
        collision = any(dist_data <= 0.1); % Boolean check for crash
        
        % 3. Log Results
        if collision
            fprintf('  >> RESULT: [FAIL] - Collision Detected!\n');
        else
            fprintf('  >> RESULT: [PASS] - Stopped at %.2f meters.\n', stop_gap);
        end
        
        % 4. Generate & Save professional plots
        plot_performance(simOut, test_scenarios{i});
        
    catch ME
        fprintf('  >> ERROR: Simulation failed for %s. Check block connections.\n', test_scenarios{i});
        disp(ME.message);
    end
end
fprintf('-------------------------------------------\n');
fprintf('Testing Phase Complete. Check /results/final_plots/\n');