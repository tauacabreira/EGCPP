function[squareArea, distanceWaypoints, numberOfWaypoints, ...
         distanceStripes, numberOfStripes, ovy, ovx] = ...
         computing_square_area(area, width, height, ovx, ovy)
% finding the square area, major and minor axis (distances)
% calculating the number and distance of waypoints/stripes

    % computing the square surrounding the area
    minorX = min(area(:,1));
    minorY = min(area(:,2));
    majorX = max(area(:,1));
    majorY = max(area(:,2));
    
    % specific area of the paper
%     minorY = -6;
%     majorY = 6;

    squareArea = [minorX majorX majorX minorX minorX;...
                  minorY minorY majorY majorY minorY];
    
    % computing the distances
    distanceX = majorX - minorX;
    distanceY = majorY - minorY;

    % computing the distance between the waypoints along the major axis
    distanceWaypoints = height*(1 - ovy);
    numberOfWaypoints = ceil((distanceY - ovy*height) / distanceWaypoints);  
    
    if(numberOfWaypoints == 1)
        distanceWaypoints = 0;
    else    
        distanceWaypoints = (distanceY - height) / (numberOfWaypoints - 1);
    end 
    ovy = height - distanceWaypoints;
    
    % computing the distance between the stripes along the minor axis
    distanceStripes = width*(1 - ovx);
    numberOfStripes = ceil((distanceX - ovx*width) / distanceStripes);
    distanceStripes = (distanceX - width) / (numberOfStripes - 1);
    ovx = width - distanceStripes;
end