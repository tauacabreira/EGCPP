function write_waypoints_file02(file_name, waypoints, waypoints_info, home_coords, altitude)
    data = load('e_table_simple.mat');
    fid = fopen(file_name,'wt'); 
    
    fprintf(fid,'QGC WPL 110\n');
    
    % home coordinates
    fprintf(fid,'0\t1\t0\t16\t0\t0\t0\t0\t%.6f\t%.6f\t%.6f\t1\n',home_coords(1),home_coords(2),home_coords(3));
    
    % takeoff: code 22
    fprintf(fid,'1\t0\t0\t22\t0.000000\t0.000000\t0.000000\t0.000000\t%.6f\t%.6f\t%.6f\t1\n',home_coords(1), home_coords(2), altitude);
    
    % computing waypoints 
    line = 1;
    index_txt = 2;
    for i = 1 : max(waypoints_info);
        if(i == 1)
            index_ini = find(waypoints_info == line, 1, 'first');
            index_end = find(waypoints_info == line, 1, 'last');
        else
            index_ini = index_end;
            index_end = find(waypoints_info == line, 1, 'last');
        end
        line = line + 1;
        
        x = [waypoints(index_ini,1) waypoints(index_ini,2); 
             waypoints(index_end,1) waypoints(index_end,2)];
         
        distance = floor(pdist(x, 'euclidean'));
        opt_speed = data.v_opt(distance);
        
        % change speed: code 178
        fprintf(fid, '%d\t0\t3\t178\t%.6f\t%.6f\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t1\n', index_txt, opt_speed, opt_speed);
        index_txt = index_txt + 1;
        
        if i == 1
            % move to waypoint 1: code 16
            coordinate = gpsplusdeltaxy(home_coords(1), home_coords(2), waypoints(index_ini,1), waypoints(index_ini,2));
            fprintf(fid, '%d\t0\t3\t16\t0.000000\t0.000000\t0.000000\t0.000000\t%.6f\t%.6f\t%.6f\t1\n', index_txt, coordinate(1), coordinate(2), altitude);
            index_txt = index_txt + 1;
            %plot(waypoints(index_ini,1),waypoints(index_ini,2),'o');  
            hold on;
        end
        
        % move to waypoint 2: code 16
        coordinate = gpsplusdeltaxy(home_coords(1), home_coords(2), waypoints(index_end,1), waypoints(index_end,2));
        fprintf(fid, '%d\t0\t3\t16\t0.000000\t0.000000\t0.000000\t0.000000\t%.6f\t%.6f\t%.6f\t1\n', index_txt, coordinate(1), coordinate(2), altitude);
        index_txt = index_txt + 1;
        %plot(waypoints(index_end,1),waypoints(index_end,2),'o');
        hold on;
    end
      
    % return-to-launch: code 20
    fprintf(fid, '%d\t0\t3\t20\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t0.000000\t1\n', index_txt);
    
    fclose(fid);
end
