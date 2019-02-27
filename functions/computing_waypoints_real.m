function[waypoints, areaMatrix, forbiddenZones] = ...
    computing_waypoints_real(area, obstPoints, j, i, width, height,...
                        centralPoint, areaMatrix,...
                        distanceStripes, distanceWaypoints, forbiddenZones)
    
    % computing waypoints                    
    waypoints = [(distanceStripes * j) -(distanceWaypoints * i)];

    % positioning the waypoints regarding the centre point
    waypoints(1) = waypoints(1) + centralPoint(1);
    waypoints(2) = waypoints(2) + centralPoint(2); 
    plot(waypoints(1), waypoints(2), '*k');

    % the projected area is computed using the waypoint as a centre point
    % and adding/subtracting the height/width
    x1 = waypoints(1) - width/2;    
    x2 = waypoints(1) + width/2;
    y1 = waypoints(2) - height/2;
    y2 = waypoints(2) + height/2;

    projectedArea = [x1 x2 x2 x1 x1; y1 y1 y2 y2 y1];

    insideArea = false;
    notObstacle = false;
    
%   uncomment in case of areas with internal obstacles    
    if inpolygon(waypoints(1), waypoints(2), area(:,1), area(:,2)) && ...
       inpolygon(waypoints(1), waypoints(2), obstPoints(:,1), obstPoints(:,2))     
            notObstacle = true;
    end

    countCorners = 0;
    for n = 1 : 4
        if inpolygon(projectedArea(1,n), projectedArea(2,n), area(:,1), area(:,2))
            countCorners = countCorners + 1;
        end    
    end
    
    % at leat two corners of the projected area or the waypoint (central point 
    % of the projected area) must be inside the area to be considered a valid cell
    % obstacle regions are considered invalid cells as well
    if countCorners >= 2 || inpolygon(waypoints(1), waypoints(2), area(:,1), area(:,2)) 
        insideArea = true;
    end
        
    % if the projectedArea (all points) is outside the area,
    % the correspondent position in the matrix is marked with -1 and
    % forbiddenZone is incremented
    if insideArea && ~notObstacle
        plot(projectedArea(1,:), projectedArea(2,:), '--k');
    else
        fill(projectedArea(1,:), projectedArea(2,:),'--k');
        alpha(.15);
        areaMatrix(i+1,j+1) = -1;
        forbiddenZones = forbiddenZones + 1;
    end                      
end
