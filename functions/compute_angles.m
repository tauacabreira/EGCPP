function [anglesPath] = compute_angles(path)
    % all directions organized in order
    allDirection = {'SW', 'S', 'SE', 'E', 'NE', 'N', 'NW', 'W'};
 
    % array with all the angles of the path
    anglesPath = zeros(length(path(:,1))-2, 1);
    
    % computing the direction of: 
    % - the points A and B
    % - the points B and C
    for i = 1 : length(path(:,1)) - 2
        
        if(i == length(path(:,1)) - 2) % last part of the path
            v2 = path(end,:);
            v1 = path(end-1,:);
            v3 = path(end-2,:);
            angle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                               (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));
            
            angle = 180 - angle;
            [direction] = computing_directions(i, path);
                               
            if angle == 0 && ~strcmp(direction{1}, direction{2})
                angle = 180;
            end
        else
            % computing the directions between the points    
            [direction] = computing_directions(i, path);

            % next, computing the angle between the two directions
            indexA = find(strcmp(allDirection, direction{1}));
            indexB = find(strcmp(allDirection, direction{2}));

            if abs(indexA - indexB) <= 3
                angle = abs(indexA - indexB) * 45;
            else
                if indexA > indexB
                   angle = (8 - indexA + indexB) * 45; 
                else
                   angle = (8 - indexB + indexA) * 45;
                end
            end
        end % if  
        
        anglesPath(i) = angle;
    end
end

