function [area, lengthOfArea, width, height, ovx, ovy] = gopro_setup(area, obstPoints)
% initial configuration of the area, width and height of the projected
% area, overlaping rate 

    area = [area; area(1,:)];
    obstPoints = [obstPoints; obstPoints(1,:)];
    
    % number of vertices of the area
    lengthOfArea = length(area) - 1; 

    % printing the area of interest
    plot(area(:,1), area(:,2), '-k', 'LineWidth', 1);
    hold on
    axis equal
    
    %printing the non-flight zone
    plot(obstPoints(:,1), obstPoints(:,2), '-r', 'LineWidth', 2);
    hold on;

    % parameters of the camera
    fieldOfView = 100;
    imageResolutionX = 2386;
    imageResolutionY = 2386;
    aspectRatio = imageResolutionX / imageResolutionY;
    altitude = 10;

    % width and height of the projected area
    width = 2 * altitude * tand(fieldOfView / 2);
    height = width / aspectRatio;

    % initial overlaping rate
    ovx = 0.1; 
    ovy = 0.1; 
end