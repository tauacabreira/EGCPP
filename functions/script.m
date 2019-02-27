%write_waypoints_file02('exp_46_cell_06_normal.txt', fullListOfWaypoints, waypointsInfo, home, 15)



%% compute the area in meters
[points, obst_points, Home ] = waypoints2meters('New_area.waypoints','New_area_obstacles.waypoints')
