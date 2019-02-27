function[waypoints, areaMatrix, forbiddenZones] = ...
    computing_waypoints(area, j, i, width, height,...
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
    
    if inpolygon(waypoints(1), waypoints(2), area(:,1), area(:,2))    
        insideArea = true;
    end

    % if the projectedArea(all points) is outside the area,
    % the correspondent position in the matrix is marked with -1 and
    % forbiddenZone is incremented
    if insideArea
        plot(projectedArea(1,:), projectedArea(2,:), '--k');
    else
        %plot(projectedArea(1,:), projectedArea(2,:), '-r');
        fill(projectedArea(1,:), projectedArea(2,:),'k');
        alpha(.15);
        areaMatrix(i+1,j+1) = -1;
        forbiddenZones = forbiddenZones + 1;
    end                      
end
