% scripts/plot_performance.m
% Generates IEEE-style graphs from the Simulink 'out' dataset.

function plot_performance(out, scenario_name)
    % Extract data from Simulink logsout
    t = out.logsout.get('EgoVelocity').Values.Time;
    v_ego = out.logsout.get('EgoVelocity').Values.Data;
    d_rel = out.logsout.get('RelativeDistance').Values.Data;
    brake = out.logsout.get('BrakeCommand').Values.Data;
    ttc = out.logsout.get('TTC').Values.Data;

    % Create IEEE-formatted figure
    fig = figure('Name', ['AEB Analysis: ', scenario_name], 'Color', 'w', 'Position', [100, 100, 800, 600]);

    % Subplot 1: Velocity & Distance
    subplot(2,1,1);
    yyaxis left
    plot(t, v_ego, 'b-', 'LineWidth', 1.5);
    ylabel('Velocity (m/s)', 'FontName', 'Times New Roman');
    ylim([0 max(v_ego)*1.2]);
    
    yyaxis right
    plot(t, d_rel, 'r--', 'LineWidth', 1.5);
    ylabel('Relative Distance (m)', 'FontName', 'Times New Roman');
    ylim([0 max(d_rel)*1.2]);
    
    title(['Kinematic Profile: ', strrep(scenario_name, '_', ' ')], 'FontName', 'Times New Roman', 'FontSize', 12);
    grid on; set(gca, 'FontName', 'Times New Roman');
    legend('Ego Velocity', 'Relative Distance', 'Location', 'best');

    % Subplot 2: TTC and Brake Command
    subplot(2,1,2);
    yyaxis left
    plot(t, ttc, 'k-', 'LineWidth', 1.2);
    ylabel('TTC (Seconds)', 'FontName', 'Times New Roman');
    ylim([0 5]);
    
    yyaxis right
    area(t, brake, 'FaceColor', 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    ylabel('Brake Pressure (%)', 'FontName', 'Times New Roman');
    ylim([0 1.2]);
    
    xlabel('Time (s)', 'FontName', 'Times New Roman');
    grid on; set(gca, 'FontName', 'Times New Roman');
    legend('Time-to-Collision (2nd Order)', 'AEB Actuation', 'Location', 'best');

    % Save high-res plot
    if ~exist('../results/final_plots', 'dir')
        mkdir('../results/final_plots');
    end
    saveas(fig, ['../results/final_plots/', scenario_name, '_plot.png']);
    disp(['>> Plot saved: ', scenario_name, '_plot.png']);
end