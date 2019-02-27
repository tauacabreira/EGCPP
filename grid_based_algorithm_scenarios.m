function [minimumPath, minimumAngles, waypoints] = ...
    grid_based_algorithm_scenarios(version, typeCost)

    load('E_model_simple.mat');
    addpath('experiments/scenarios');
    
    % version: (1) optimized, (2) original
    % typeCost (cost function): (0) angles, (1) energy

    % using a real area as a scenario for the experiments
    % you can choose from the 'experiments/scenarios' folder
    scenario = 'scenario07.waypoints';
    obstacle = 'obstacles07.waypoints';
    [area, obstPoints, ~] = waypoints2meters(scenario, obstacle);
    
    % initial configuration of the area, width and height of the projected
    % area, overlaping rate
    [area, ~, width, height, ovx, ovy] = gopro_setup(area, obstPoints);

    % finding the square area, major and minor axis (distances)
    % calculating the number and distance of waypoints/stripes
    [squareArea, distanceWaypoints, numberOfWaypoints, ... 
        distanceStripes, numberOfStripes, ~, ~] = ...
            computing_square_area(area, width, height, ovx, ovy);

    % starting corner of the square area
    squareStart = squareArea(:,4);

    % computing the initial central point based on the squareStart 
    centralPoint = [(squareStart(1) + (width/2)) (squareStart(2) - (height/2))]';

    % ==== RECTANGULAR GRID ==== %
    % Positioning the rectangular grid with all waypoints and projected areas.
    % The areaMatrix is a matrix representing the scenario with 1 marking the 
    % goal position and -1 marking the zones outside of the area of interest
    areaMatrix = ones(numberOfWaypoints, numberOfStripes);
    areaMatrix = areaMatrix * -2;
    waypoints = ones(numberOfWaypoints, 2, numberOfStripes);
    forbiddenZones = 0;

    for j = 0 : numberOfStripes - 1
        for i = 0 : numberOfWaypoints - 1    
            % creating rectangular grid
            [wp, areaMatrix, forbiddenZones] = ...
                computing_waypoints_real(area, obstPoints, j, i, width, height, centralPoint, areaMatrix,...
                                    distanceStripes, distanceWaypoints, forbiddenZones);
                waypoints(i+1,:,j+1) = wp;
        end 
    end  

    % computing the valid positions in the matrix and the number of cells
    [numCells, validPositions] = computing_valid_positions(areaMatrix);
    
    minwp = Inf;
    for i = 1 : size(validPositions,1) 
 
        wp = norm(waypoints(validPositions(i,1),:,validPositions(i,2)));
        if (wp < minwp)
            minwp = wp;
            min_i = i;
        end
    end

    % arrays containing all the correspondent data to be saved in .mat file 
    gp = zeros(numCells, 2);
    info = zeros(numCells, 4);
    
    % testing every valid cell as a starting point of the current area
    for k = 1 : 1% numCells
        tic

        % choosing and plotting the goal position
        % updating the matrix with the goal position
        % goalPosition = validPositions(k,:);
        goalPosition = validPositions(1,:);
        tempAreaMatrix = areaMatrix;
        tempAreaMatrix(goalPosition(1), goalPosition(2)) = 1; 
        hold on;

        % ==== FLOODING ALGORITHM ==== %
        % From the goal position marked as 1, all the valid neighbors with values 
        % different of -1, i.e., inside the area of interest, are marked with 2.
        % Next, all the valid neighbors of 2 are marked with 3, and so on...
        % the process continues until there is no neighbor unmarked.
        [tempAreaMatrix] = flooding_area(goalPosition, tempAreaMatrix);

        % ==== COMPUTING MINIMUM PATH ==== %
        % The goal position is added to the initial path and the recursive function 
        % is called with the current path and area matrix.
        % The recursive function will explore every cell and all of its neighbors, 
        % aiming to minimize the total cost of the path  
        path = goalPosition;
        minimumCost = Inf;
        minimumPath = path;
        minimumAngles = [];
        numOfExecutions = 0;
        numOfCompletePaths = 0;
        FIFO = [];

        % calling the recursive function
        [path, minimumCost, minimumPath, minimumAngles, numOfExecutions, ...
         numOfCompletePaths, FIFO] = ...
                recursive_search_it(tempAreaMatrix, path, minimumCost, minimumPath, ...
                                 minimumAngles, numCells, numOfExecutions, ...
                                 numOfCompletePaths, ... 
                                 waypoints, typeCost, E_table, E_rotate, ...
                                 version, 0, [0 0], FIFO);

        % ORIGINAL ALGORITHM -> computing the minimum cost path                     
        if version == 2 
           costList = zeros(size(FIFO,3),1);
           for w = 1 : size(FIFO,3)
               costList(w) = cost_path_original(FIFO(:,:,w));
           end
           minimumCost = min(costList);
           index = find(min(costList) == costList);
           path = FIFO(:,:,index);
        end
        
        % printing the minimum path
        for i = 1 : length(path(:,1)) - 1
           plotting_path(path(i,:), path(i+1,:), waypoints);  
        end

        % data from the experiments
        timeElapsed = toc;
        gp(k,:) = goalPosition;
        info_i = [minimumCost numOfCompletePaths numOfExecutions timeElapsed];
        info(k,:) = info_i ;

    end % for numCells

    % saving .mat file with all the data
    % folder: data/mat_simulations/normal/info_xx_cells.mat or 
    %         data/mat_simulations/optimized/info_xx_cells.mat
    
    if version == 1 % optimized algorithm
        if typeCost == 0 % angles-cost function
            parentFolder = 'experiments/data/mat_simulations/optimized';
        else % energy-cost function
            parentFolder = 'experiments/data/mat_simulations/optimized_energy';
        end
    else % original algorithm
        parentFolder = 'experiments/data/mat_simulations/original';
    end

    % file containing the data from the experiments: info_0X_YY_cells.mat
    filename = fullfile(parentFolder, strcat('info_07_', num2str(numCells), '_cells', '.mat'));
    save (filename, 'gp', 'info');
end