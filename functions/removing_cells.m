function[areaMatrix] = removing_cells(areaMatrix, removedCells)
    
    col = size(areaMatrix,2);
    line = size(areaMatrix,1);
    
    while removedCells > 0    
        areaMatrix(line,col) = -1;
        line = line - 1;
        removedCells = removedCells - 1;

        if line == 0
            line = size(areaMatrix,1);
            col = col - 1;
        end
        
        if col == 0
            col = size(areaMatrix,2);
        end
    end
end