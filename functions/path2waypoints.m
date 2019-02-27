function [fullListOfWaypoints, waypointsInfo, minimumAngles] = path2waypoints(path, waypoints)
    
    fullListOfWaypoints = [];
    waypointsInfo = [];
    
    [minimumAngles] = compute_angles( path );
    
    counter = 1;
    waypointsInfo(1) = counter;
    for p = 1 : length(path(:,1))
        wpx = waypoints(path(p,1),1,path(p,2));
        wpy = waypoints(path(p,1),2,path(p,2));
        fullListOfWaypoints(p,:) = [wpx wpy];

        if p < length(path(:,1))
            waypointsInfo(p+1) = counter;
            if p < length(path(:,1)) - 1 && minimumAngles(p) ~= 0
                counter = counter + 1;
            end
        end
    end
end