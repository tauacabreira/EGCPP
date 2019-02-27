function [points, obst_points, home, coord_area, coord_obst] = waypoints2meters(waypointsfile, obstaclesfile)

    fid = fopen(waypointsfile);
    str = fgetl(fid); 

    % read line from file
    str = fgetl(fid);

    % reads data from string str, converts it according to the format, 
    % and returns the results in array A
    A = sscanf(str,'%d %d %d %d %d %d %d %d %f %f %f %u');

    % getting the first line
    str = fgetl(fid);
    A = sscanf(str,'%d %d %d %d %f %f %f %f %f %f %f %u');

    % home coordinates
    coord_area = [];
    homeLat = double(A(9));
    homeLong = double(A(10));
    homeAlt = double(A(11));
    home = [homeLat homeLong homeAlt];

    coord_area(end+1,:) = [homeLat homeLong];
    points = [0,0];
    str = fgetl(fid);

    while (str ~= -1)
        A = sscanf(str,'%d %d %d %d %f %f %f %f %f %f %f %u');
        lat = double(A(9));
        long = double(A(10));

        coord_area(end+1,:) = [lat long];
        p = gps2meters(homeLat,homeLong,lat,long);
        points(end+1,:) = p;
        str = fgetl(fid);
    end
    fclose(fid);

    % printing the area
%     figure()
%     plot(points(:,1),points(:,2),'o')
%     axis equal
%     hold on 
%     plot([points(1,1) points(end,1)],[points(1,2) points(end,2)],'b-')
%     for i = 1 : size(points,1)-1
%         plot([points(i,1) points(i+1,1)],[points(i,2) points(i+1,2)],'b-')
%     end

%    obst_points = [0,0];

    obst_points = [0,0];
    coord_obst = [];
    if ~isequal(obstaclesfile, '')
        fid = fopen(obstaclesfile);
        
        str = fgetl(fid);
        str = fgetl(fid);

        A = sscanf(str,'%d %d %d %d %d %d %d %d %f %f %f %u');
        obst_points = [0,0];

        str = fgetl(fid);

        while (str ~= -1) 
            A = sscanf(str,'%d %d %d %d %f %f %f %f %f %f %f %u');
            lat = double(A(9));
            long = double(A(10));

            coord_obst(end+1,:) = [lat long];
            p = gps2meters(homeLat,homeLong,lat,long);
            obst_points(end+1,:) = p;
            str = fgetl(fid);
        end
        fclose(fid);

        obst_points = obst_points(2:end,:);

        % plot([obst_points(1,1) obst_points(end,1)],[obst_points(1,2) obst_points(end,2)],'r-')
        % for i = 1 : size(obst_points,1)-1
        %    plot([obst_points(i,1) obst_points(i+1,1)],[obst_points(i,2) obst_points(i+1,2)],'r-')
        % end
        % hold off
    end
end
