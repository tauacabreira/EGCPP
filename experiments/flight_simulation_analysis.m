function[power_array, time_array,distance_array] = ...
    flight_simulation_analysis(E_model, E_angle_speed, E_rotate, e_total, altitude)
    
    power_array = [];
    time_array = [];
    distance_array = [];
    
    % open every workspace file
    for j = 3 : size(dir('./workspace/real flights'),1)

        workspace = dir('workspace/real flights');
        workspace_path = ['workspace/real flights/' workspace(j).name];
        load(workspace_path);

        % converting from path to waypoints
        [full_waypoints, waypoints_info, ~] = ...
            path2waypoints(minimumPath, waypoints);

        % removing the intermediate waypoints during straight parts
        [final_waypoints] = path2wp(full_waypoints, waypoints_info);                             
        
        % computing the angles between the waypoints
        [angles] = compute_angles_of_waypoints(final_waypoints);
        
        [energy_total, time_total, distance_total] = ...
            compute_energy_time_and_distance_emodel_v2(E_model, E_angle_speed, E_rotate,...
                                                       final_waypoints, angles, altitude, 'false');
        
        power_array(end+1,:) = energy_total;
        time_array(end+1,:) = time_total;
        distance_array(end+1,:) = distance_total;
        
    end
end