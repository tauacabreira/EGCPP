function [currentCost, previousWp] = ...
    cost_function02(current_list, previous_wp, tempCost, waypoints, ...
                    typeCost, E_table, E_rotate)
 
    if typeCost == 0
        partial_path = [current_list(end-2,:); ...
                        current_list(end-1,:); ...
                        current_list(end,:)];
                    
        currentCost = cost_path(partial_path);
        currentCost = currentCost + tempCost;
        previousWp = [0 0];
    else
        partial_path = [current_list(end-2,:); ...
                        current_list(end-1,:); ...
                        current_list(end,:)];
        
        [currentCost, previousWp] = ...
            compute_energy_path03(partial_path, previous_wp, tempCost, ...
                                  waypoints, E_table, E_rotate);
    end
end
