function[direction] = computing_directions(i, path)
    for j = 0 : 1
        if path(i+j,1) > path(i+j+1,1) % heading north
            if path(i+j,2) > path(i+j+1,2)
                direction{j+1} = 'NW';
            elseif path(i+j,2) < path(i+j+1,2)
                direction{j+1} = 'NE';
            else
                direction{j+1} = 'N';
            end

        elseif path(i+j,1) < path(i+j+1,1) % heading south
            if path(i+j,2) > path(i+j+1,2)
                direction{j+1} = 'SW';
            elseif path(i+j,2) < path(i+j+1,2)
                direction{j+1} = 'SE';
            else
                direction{j+1} = 'S';
            end

        else % heading east or west 
            if path(i+j,2) > path(i+j+1,2)
                direction{j+1} = 'W';
            else
                direction{j+1} = 'E';
            end    
        end
    end % for
end