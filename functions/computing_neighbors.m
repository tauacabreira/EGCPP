function[neighbors] = computing_neighbors(cell, areaMatrix)

    neighbors = [];
    majorValue = 0;
    i = cell(1);
    j = cell(2);

    % the valiad neighbors of the cell 
    % will be added in the following lines
    for m = -1 : 1
        for n = -1 : 1
            % the neighbor is added if it is:
            % - inside the limits of line and column of the matrix
            % - different from -1 (forbidden zones)
            % - the major value
            if i+m <= length(areaMatrix(:,1)) && i+m ~= 0 && ...
               j+n <= length(areaMatrix(1,:)) && j+n ~= 0 && ...
               areaMatrix(i+m, j+n) ~= -1
           
               % saving the highest neighbors 
               if areaMatrix(i+m, j+n) > majorValue
                  majorValue = areaMatrix(i+m, j+n);
                  index = 1;
                  neighbors = [];
                  neighbors(index,:) = [i+m j+n];
                   
               elseif areaMatrix(i+m, j+n) == majorValue
                  index = index + 1;
                  neighbors(index,:) = [i+m j+n];
               end
            end % if
        end % for
    end % for   
end