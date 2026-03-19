function [ttc, status] = calc_ttc(d_rel, v_rel, a_rel)
    % 2nd-Order Kinematic TTC Solver
    % Avoids divide-by-zero and phantom braking.

    ttc = 5.0; 
    status = 0;

    if v_rel >= 0 && a_rel >= 0
        return; % Target is moving away faster than ego
    end

    discriminant = (v_rel^2) - (2 * a_rel * d_rel);

    if discriminant >= 0
        if abs(a_rel) > 0.05
            t1 = (-v_rel + sqrt(discriminant)) / a_rel;
            t2 = (-v_rel - sqrt(discriminant)) / a_rel;
            
            roots = [t1, t2];
            valid_roots = roots(roots > 0);
            if ~isempty(valid_roots)
                ttc = min(valid_roots);
                status = 1;
            end
        else
            % Fallback to 1st order linear calculation
            if v_rel < 0
                ttc = -d_rel / v_rel;
                status = 1;
            end
        end
    end
    
    if ttc > 5.0 || ttc < 0
        ttc = 5.0;
        status = 0;
    end
end