function[numCells, validPositions] = computing_valid_positions(areaMatrix)
    
    % the function computes all valid cells of the matrix, 
    % i.e., different from '-2' (forbidden zones)
    validPositions = [];
    index = 1;
    
    for i = 1 : length(areaMatrix(:,1))
        for j = 1 : length(areaMatrix(1,:))
            if areaMatrix(i,j) == -2
                validPositions(index,:) = [i j];
                index = index + 1;
            end
        end
    end
    numCells = length(validPositions);
end