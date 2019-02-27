function [area, lengthOfArea, width, height, ovx, ovy] = initial_setup()
% initial configuration of the area, width and height of the projected
% area, overlaping rate 

    area = [0 0; 240 0; 240 80; 0 80; 0 0];
    
    % number of vertices of the area
    lengthOfArea = length(area) - 1; 

    % printing the area of interest
%     plot(area(:,1), area(:,2), '-b')
%     axis equal
%     hold on

    % parameters of the camera
    fieldOfView = 90;
    imageResolutionX = 480;%640;
    imageResolutionY = 480;
    aspectRatio = imageResolutionX / imageResolutionY;
    altitude = 10;

    % width and height of the projected area
    width = 2 * altitude * tand(fieldOfView / 2);
    height = width / aspectRatio;

    % initial overlaping rate
    ovx = 0; 
    ovy = 0; 
end