function [energy_total, time_total, distance_total] = ...
    compute_energy_time_and_distance_emodel_v2(E_model, E_angle_speed, E_rotate,...
                                               waypoints, angles, altitude, old)
    
    v_rotate = E_model.v_rotate;
    
    energy_total = 0;
    time_total = 0;
    distance_total = 0;
    vin = 0;
    
     % computing the last angle to RTL
    [angle] = compute_angle_between_3_points(waypoints(end-1,:), ...
                                             waypoints(end,:), ...
                                             waypoints(1,:));
    angles(end+1,:) = angle;                                     
    vin = 0;

    limit = size(waypoints, 1) - 1;
    for i = 1 : limit
        
        % energy consumpion in straight distances
        distance = norm(waypoints(i,:) - waypoints(i+1,:));
        distance_total = distance_total + distance;
        
        % rounding the angle
        angle = floor(180- angles(i));
      %  angle = 160;
      
          if old 
            angle = 90;
            
          end
 
        
        % energy consumption during straight distance
        [e_tot, t_tot, v_opt, v_out] = ...
            get_v_opt_dist_angle(E_model, vin, distance, angle, E_angle_speed);
        
%         % energy consumption during rotations
%         t_partial = (angle*pi/180)/v_rotate;
%         energy_total = energy_total + E_rotate*t_partial;
%         time_total = time_total + t_partial;

        if (distance > 0)
            energy_total = energy_total + e_tot;
            time_total = time_total + t_tot;
            vin = v_out;
            %vin = 0.5;
        end
    end
    
    % climb(0,altitude)
    %[e_climb, t_climb] = E_climb(E_model, 0, altitude);
    e_climb = 0;
    t_climb = 0;
    
    % climb (altitute, 15)
    [e_climb_rtl, t_climb_rtl] = E_climb(E_model, altitude, 15);
    
    % go to starting point with the last chosen speed
    distance = norm(waypoints(end,:) - waypoints(1,:));
    
    angle = 180;                                     
    if distance ~= 0
        [e_rtl, t_rtl, v_opt, v_out] = ...
                get_v_opt_dist_angle(E_model, vin, distance, angle, E_angle_speed);
    else
        e_rtl = 0;
        t_rtl = 0;
    end
    
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