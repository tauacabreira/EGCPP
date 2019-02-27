function [energy_total, time_total, distance_total] = ...
    compute_energy_time_and_distance(E_table, E_rotate, ...
                                     waypoints, angles, altitude)
    
    load('E_model_full.mat');
    v_rotate = E_model.v_rotate;
    
    energy_total = 0;
    time_total = 0;
    distance_total = 0;
    limit = size(waypoints, 1) - 1;
    
    for i = 1 : limit
        
        % energy consumpion in straight distances
        distance = norm(waypoints(i,:) - waypoints(i+1,:));
        distance_total = distance_total + distance;
        if (distance > 0)
            if (distance > 1080)
                distance = 1080;
            end
            
            e_partial = E_table(ceil(distance));
            t_partial = t_tot(ceil(distance));
            energy_total = energy_total + e_partial;
            time_total = time_total + t_partial;
        end

        % energy consumption during rotations
        if i < limit
            t_partial = (angles(i)*pi/180)/v_rotate;
            energy_total = energy_total + E_rotate*t_partial;
            time_total = time_total + t_partial;
        end
    end
    
    % climb(0,altitude)
    [e_climb, t_climb] = E_climb(E_model, 0, altitude);
    
    % climb (altitute, 15)
    [e_climb_rtl, t_climb_rtl] = E_climb(E_model, altitude, 15);
    
    % go to starting point with the last chosen speed
%     distance = norm(waypoints(end,:) - waypoints(1,:));
%     if distance ~= 0
%         e_rtl = E_table(ceil(distance));
%         t_rtl = t_tot(ceil(distance));
%     else
%         e_rtl = 0;
%         t_rtl = 0;
%     end
    e_rtl = 0;
    t_rtl = 0;

    % descend (15, 0)
    [e_descend, t_descend] = E_climb(E_model, 15, 0);
    
    e_climb         = 0;
    
    e_descend = 0;
    t_climb = 0;
    
    t_descend = 0;
    
    energy_total = energy_total + e_climb + e_climb_rtl + e_rtl + e_descend;
    time_total = time_total + t_climb + t_climb_rtl + t_rtl + t_descend;
    distance_total = distance_total + distance;
end  