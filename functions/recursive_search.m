function[current_list, minimumCost, minimumPath, minimumAngles, numOfExecutions, ...
         numOfCompletePaths, fileID, FIFO] = ...
                recursive_search(matrix, current_list, minimumCost, minimumPath, minimumAngles, ...
                                 numCells, numOfExecutions, numOfCompletePaths, ...
                                 fileID, waypoints, typeCost, ...
                                 E_table, E_rotate, version, tempCost, FIFO)
   
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
        if version ~=2 && size(temp_list,1) >= 3
            [currentCost, ~] = cost_function(temp_list, waypoints, typeCost, E_table, E_rotate);
            previousCost = tempCost;
            previousCost = previousCost + currentCost;
        end
        
        % Optimized version -> cutting the tree search
        if version == 1 && previousCost > minimumCost
            return;
        end

        % calling the recursive function for each neighbor (backtracking points)
        [path, minimumCost, minimumPath, minimumAngles, numOfExecutions, ...
         numOfCompletePaths, fileID, FIFO] = ...
                recursive_search(tempMatrix, temp_list, minimumCost, minimumPath, minimumAngles, ...
                                 numCells, numOfExecutions, numOfCompletePaths, ...
                                 fileID, waypoints, ...
                                 typeCost, E_table, E_rotate, version, previousCost, FIFO);
        
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
            
            else % NORMAL AND OPTIMIZED VERSION
                
                % computing the cost of the path and saving the minimum path/cost,
                [costPath, anglesPath] = cost_function([path; path(1,:)],waypoints,typeCost,E_table,E_rotate);
                costPath = costPath + tempCost;

                % saving the cost of the path into a external file
                %fprintf(fileID, '%d\n', costPath);

                % updating the minimum cost and path
                if minimumCost > costPath
                    minimumPath = path;
                    minimumCost = costPath;
                    minimumAngles = anglesPath;
                end
            end
        end
   end
   
   % returing the minimumPath
   current_list = [ minimumPath ; minimumPath(1,:)];
end