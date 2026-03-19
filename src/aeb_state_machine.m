function [brake_cmd, warning_flag, aeb_state] = aeb_state_machine(ttc, threat_level, v_ego)
    persistent current_state
    if isempty(current_state)
        current_state = 0; 
    end

    % Thresholds 
    TTC_WARN = 2.0;
    TTC_PARTIAL = 1.2;
    TTC_EMERGENCY = 0.8;

    brake_cmd = 0.0;
    warning_flag = false;

    if threat_level == 0 || v_ego < 1.0
        current_state = 0; 
    else
        if ttc > 0 && ttc <= TTC_EMERGENCY
            current_state = 3; 
        elseif ttc > TTC_EMERGENCY && ttc <= TTC_PARTIAL
            if current_state < 3 
                current_state = 2; 
            end
        elseif ttc > TTC_PARTIAL && ttc <= TTC_WARN
            if current_state < 2
                current_state = 1; 
            end
        else
            current_state = 0;
        end
    end

    switch current_state
        case 0 % STANDBY
            brake_cmd = 0.0;
            warning_flag = false;
        case 1 % WARNING
            brake_cmd = 0.0;
            warning_flag = true;
        case 2 % PARTIAL BRAKING
            brake_cmd = 0.4; 
            warning_flag = true;
        case 3 % EMERGENCY BRAKING
            brake_cmd = 1.0; 
            warning_flag = true;
        otherwise
            brake_cmd = 0.0;
            warning_flag = false;
    end
    
    aeb_state = current_state;
end