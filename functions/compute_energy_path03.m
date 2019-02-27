function [temp_cost, previous_wp] = ...
    compute_energy_path03(partial_path, previous_wp, temp_cost, ...
                          waypoints, E_table, E_rotate)
    
    % computing the angle between the last three points
    v3 = partial_path(1,:);
    v1 = partial_path(2,:);
    v2 = partial_path(3,:);
    
    angle = 180 - atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                         (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));

    if angle > 0 % there is a turn
        
        % converting the points to waypoints
        if isequal(previous_wp,[0 0]) % first time
            wp3 = waypoints(v3(1),:,v3(2));
        else 
            wp3 = waypoints(previous_wp(1),:,previous_wp(2));
        end
        wp1 = waypoints(v1(1),:,v1(2));
        wp2 = waypoints(v2(1),:,v2(2));
        
        % measuring the distances between the waypoints
        distance_wp3_wp1 = norm(wp1 - wp3);
        distance_wp1_wp2 = norm(wp2 - wp1);
       
        delete_energy = 0;
        if temp_cost ~= 0
            delete_energy = E_table(ceil(distance_wp3_wp1));
        end
        
        % computing the energy
        current_energy = E_table(ceil(distance_wp3_wp1)) + (E_rotate * angle) + E_table(ceil(distance_wp1_wp2));
        temp_cost = temp_cost - delete_energy + current_energy;
        
        % saving the previous waypoint
        previous_wp = v1;
    else
        % converting the points to waypoints
        if isequal(previous_wp,[0 0]) % first time
            previous_wp = v3;
        end
        prevwp = waypoints(previous_wp(1),:,previous_wp(2));
        wp2 = waypoints(v2(1),:,v2(2));
        wp1 = waypoints(v1(1),:,v1(2));
        
        % measuring the distances
        distance_prevwp_wp2 = norm(wp2 - prevwp);
        distance_prevwp_wp1 = norm(wp1 - prevwp);
        
        delete_energy = 0;
        if temp_cost ~= 0
            delete_energy = E_table(ceil(distance_prevwp_wp1));
        end
        
        % computing the energy
        current_energy = E_table(ceil(distance_prevwp_wp2));
        temp_cost = temp_cost - delete_energy + current_energy;
    end
end  