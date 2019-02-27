function grid_based_algorithm(version, typeCost, removedCells)

    load('E_model_simple.mat');
    addpath('functions');
    
    % version: (1) optimized, (2) original
    % typeCost (cost function): (0) angles, (1) energy
    % removedCells: number of cells that should be removed from the scenario
        
    % arrays containing all the correspondent data to be saved in .mat file 
    info = [];
    gp = [];

    % initial configuration of the area, width and height of the projected
    % area, overlaping rate
    [area, ~, width, height, ovx, ovy] = initial_setup();

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
                computing_waypoints(area, j, i, width, height, centralPoint, areaMatrix,...
                                    distanceStripes, distanceWaypoints, forbiddenZones);
                waypoints(i+1,:,j+1) = wp;
        end 
    end  

    % removing cells for the experiments
    [areaMatrix] = removing_cells(areaMatrix, removedCells);

    % computing the valid positions in the matrix and the number of cells
    [numCells, validPositions] = computing_valid_positions(areaMatrix);
      
    % testing every valid cell as a starting point of the current area
    for k = 1 : 1% numCells
        tic

        % choosing and plotting the goal position
        % updating the matrix with the goal position
        % goalPosition = validPositions(k,:);
        goalPosition = [1 1];
        
        tempAreaMatrix = areaMatrix;
        tempAreaMatrix(goalPosition(1), goalPosition(2)) = 1; 
        plot(waypoints(goalPosition(1),1,goalPosition(2)), waypoints(goalPosition(1),2,goalPosition(2)), '*r');
        hold on;

        % ==== FLOODING ALGORITHM ==== %
        % From the goal position marked as 1, all the valid neighbors with values 
        % different of -1, i.e., inside the area of interest, are marked with 2.
        % Next, all the valid neighbors of 2 are marked with 3, and so on...
        % the process continues until there is no neighbor unmarked.
        [tempAreaMatrix] = flooding_area(goalPosition, tempAreaMatrix)

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

        timeElapsed = toc;
        gp(k,:) = goalPosition;
        info_i = [minimumCost numOfCompletePaths numOfExecutions timeElapsed];
        info(k,:) = info_i;

    end % for numCells

    % saving .mat file with all the data
    if version == 1 % optimized algorithm
        if typeCost == 0 % angles-cost function
            parentFolder = 'experiments/data/mat/optimized';
        else % energy-cost function
            parentFolder = 'experiments/data/mat/optimized_energy';
        end
    else % original algorithm
        parentFolder = 'experiments/data/mat/original';
    end

    filename = fullfile(parentFolder, strcat('info_', num2str(numCells), '_cells', '.mat'));
    save (filename, 'gp', 'info');
end