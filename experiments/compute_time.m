function [time_total,distance_total,energy_total ] = compute_time(E_model,waypoints,angles,altitude)


    max_speed = 10;

    v_rotate = E_model.v_rotate;
    
    time_total = 0;
    distance_total = 0;
    
         % computing the last angle to RTL
    [angle] = compute_angle_between_3_points(waypoints(end-1,:), ...
                                             waypoints(end,:), ...
                                             waypoints(1,:));
    angles(end+1,:) = angle;   
    
    
    limit = size(waypoints, 1) - 1;
    for i = 1 : limit
        
        % energy consumpion in straight distances
        distance = norm(waypoints(i,:) - waypoints(i+1,:));
        distance_total = distance_total + distance;
        
       
            % rounding the angle
            angle = floor(angles(i));
        
            % energy consumption during rotations
            t_partial = (angle*pi/180)/v_rotate;
            time_total = time_total + t_partial;
        
            
            [ t_tot ] = compute_t(distance,max_speed );
 
       
        
        if (distance > 0)
            time_total = time_total + t_tot;
        end
    end
    
    % climb(0,altitude)
    [~, t_climb] = E_climb(E_model, 0, altitude);
    
    % climb (altitute, 15)
    [~, t_climb_rtl] = E_climb(E_model, altitude, 15);
    
    % go to starting point with the last chosen speed
    distance = norm(waypoints(end,:) - waypoints(1,:)) 
    
                             
    if distance ~= 0
         [ t_rtl ] = compute_t(distance,max_speed );
       
    else
        t_rtl = 0;
    end
    
    % descend (15, 0)
    [~, t_descend] = E_climb(E_model, 15, 0);
    
    t_climb = 0;
    t_climb_rtl = 0;
    t_descend = 0;
    
    time_total = time_total + t_climb + t_climb_rtl + t_rtl + t_descend;
    distance_total = distance_total + distance;
    energy_total = 0;
end
