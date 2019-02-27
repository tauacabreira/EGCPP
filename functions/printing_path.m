function[] = printing_path(area, obstacles, path, waypoints, width, height)
    figure 
    
    % printing the area of interest
    plot(area(:,1), area(:,2), '-b');
    hold on
    axis equal
    
    % printing the waypoints
    for i = 1 : length(waypoints(1,1,:))
        for j = 1 : length(waypoints(:,1,1))
            plot(waypoints(j,1,i), waypoints(j,2,i), '*k'); 
            
            x1 = waypoints(j,1,i) - width/2;    
            x2 = waypoints(j,1,i) + width/2;
            y1 = waypoints(j,2,i) - height/2;
            y2 = waypoints(j,2,i) + height/2;

            projectedArea = [x1 x2 x2 x1 x1; y1 y1 y2 y2 y1];
            insideArea = false;
    
            if inpolygon(waypoints(j,1,i), waypoints(j,2,i), area(:,1), area(:,2)) && ...
               ~inpolygon(waypoints(j,1,i), waypoints(j,2,i), obstacles(:,1), obstacles(:,2)) 
                insideArea = true;
            end

            if insideArea
                plot(projectedArea(1,:), projectedArea(2,:), '--k');
            else
                fill(projectedArea(1,:), projectedArea(2,:),'k');
                alpha(.15);
            end  
        end
    end
    
    % printing the path
    for i = 1 : length(path(:,1)) - 1
        plotting_path(path(i,:), path(i+1,:), waypoints);  
    end
end