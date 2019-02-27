function[final_waypoints] = path2wp(waypoints, waypoints_info)
    
    final_waypoints = [];
    line = 1;
    
    for i = 1 : max(waypoints_info)
        if i == 1
            index_ini = find(waypoints_info == line, 1, 'first');
            final_waypoints(end+1,:) = [waypoints(index_ini,1),waypoints(index_ini,2)];
        end
        index_end = find(waypoints_info == line, 1, 'last');
        final_waypoints(end+1,:) = [waypoints(index_end,1),waypoints(index_end,2)];
        
        line = line + 1;
    end
end