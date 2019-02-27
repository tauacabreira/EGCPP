function[angles] = compute_angles_of_waypoints(waypoints)
    angles = [];
    for i = 1 : size(waypoints, 1) - 2
        v2 = waypoints(i,:);
        v1 = waypoints(i+1,:);
        v3 = waypoints(i+2,:);
        
        angle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                           (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));

        angles(end+1,:) = 180 - angle;
    end
end