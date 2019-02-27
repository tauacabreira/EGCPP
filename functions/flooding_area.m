function[areaMatrix, numCells] = flooding_area(goalPosition, areaMatrix)

% ==== FLOODING ALGORITHM ==== %
% from the goal position marked as 1, all the valid neighbors with values 
% different of -1, i.e., inside the area of interest, are marked with 2
% next, all the valid neighbors of 2 are marked with 3, and so on...
% the process continues until there is no neighbor unmarked

individual = goalPosition;
neighbors = individual;
floodIndex = 2;
keepWalking = true;

while keepWalking
   keepWalking = false; 
   k = 1;
   u = 1;
      
   while u <= length(individual(:,1))
        i = individual(u,1);
        j = individual(u,2);
             
        for m = -1 : 1
            for n = -1 : 1
                % the neighbor is marked if it is:
                % - inside the limits of line and column of the matrix
                % - different from -1 and 0
                % - different from the previous marked neighbors
                % - not included in the current neighbors list
                if i+m <= length(areaMatrix(:,1)) && i+m ~= 0 && ...
                   j+n <= length(areaMatrix(1,:)) && j+n ~= 0 && ...
                   ~ismember([i+m j+n], neighbors, 'rows') && ...
                   areaMatrix(i+m, j+n) ~= -1 && ...
                   areaMatrix(i+m, j+n) ~= 0 && ...
                   areaMatrix(i+m, j+n) ~= floodIndex - 1 && ...
                   areaMatrix(i+m, j+n) ~= floodIndex - 2
                   
                        areaMatrix(i+m, j+n) = floodIndex;
                        neighbors(k,:) = [i+m j+n];
                        k = k + 1;
                        keepWalking = true;
                end
            end % for
        end % for
        u = u + 1;
        
   end % while
   individual = neighbors;
   neighbors = [0 0];
   floodIndex = floodIndex + 1;
   
end % while    