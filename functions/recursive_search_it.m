function[current_list, minimumCost, minimumPath, minimumAngles, numOfExecutions, ...
         numOfCompletePaths, FIFO] = ...
                recursive_search_it(matrix, current_list, minimumCost, minimumPath, minimumAngles, ...
                                    numCells, numOfExecutions, numOfCompletePaths, ...
                                    waypoints, typeCost, E_table, E_rotate, ...
                                    version, tempCost, tempPreviousWp, FIFO)
   
   % the function receives an initial path and the flooding matrix
   % using the compute_temp_matrix, the flooding matrix is updated with the current path 
   tempMatrix = compute_temp_matrix(matrix, current_list(end,:));
      
   % computing the neighbors of the last element of the path
   neighbors = computing_neighbors(current_list(end,:), tempMatrix);
   
   if isempty(neighbors)
       neighborsLength = 0;
   else    
       neighborsLength = length(neighbors(:,1));
   end
   
   if neighborsLength == 0
       return;
   end
  
   for i = 1 : length(neighbors(:,1)) 
        % selecting a cell among the neighbors and updating the path
        cell = neighbors(i,:); 
        
        temp_list = current_list;
        temp_list = [temp_list ; cell];
      
        % computing the current cost of the path (temp_list) and adding
        % to the previously cost - only for normal and optimized version  
        previousCost = 0;
        previousWaypoint = [0 0];
        
        if version ~= 2 && size(temp_list,1) >= 3
            [currentCost, previousWp] = ...
                cost_function02(temp_list, tempPreviousWp, tempCost, waypoints, ...
                                typeCost, E_table, E_rotate);
            
            previousCost = currentCost;
            previousWaypoint = previousWp;
        end
        
        % optimized version -> cutting the tree search
        if version == 1 && previousCost > minimumCost
            return;
        end

        % calling the recursive function for each neighbor (backtracking points)
        [path, minimumCost, minimumPath, minimumAngles, numOfExecutions, ...
         numOfCompletePaths, FIFO] = ...
                recursive_search_it(tempMatrix, temp_list, minimumCost, minimumPath, ...
                                    minimumAngles, numCells, numOfExecutions, ...
                                    numOfCompletePaths, waypoints, typeCost, ...
                                    E_table, E_rotate, version, previousCost, previousWaypoint, FIFO);
        
        numOfExecutions = numOfExecutions + 1;
        
        % checking if the path covers the entire area
        pathLength = length(path(:,1));
        
        if pathLength == numCells
            numOfCompletePaths = numOfCompletePaths + 1;
            
            if version == 2 % ORIGINAL ALGORITHM
                if isempty(FIFO)
                    page = 1;
                else
                    page = size(FIFO,3) + 1;
                end
                FIFO(:,:,page) = [path; path(1,:)];
            
            else % OPTIMIZED VERSION
               
                [currentCost, ~] = ...
                cost_function02([path; path(1,:)], tempPreviousWp, tempCost, ...
                                waypoints, typeCost, E_table, E_rotate);

                % updating the minimum cost and path
                if minimumCost > currentCost
                    minimumPath = path;
                    minimumCost = currentCost;
                    minimumAngles = 0;
                end
            end
        end
   end
   
   % returing the minimumPath
   current_list = [minimumPath ; minimumPath(1,:)];
end