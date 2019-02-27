function[] =  plotting_path(cell, neighbor, waypoints)
    % plotting each part of the path from cell to selected neighbor
    
    plot([waypoints(cell(1),1,cell(2)) waypoints(neighbor(1),1,neighbor(2))], ...
        [waypoints(cell(1),2,cell(2)) waypoints(neighbor(1),2,neighbor(2))], '-b');
    hold on;
end