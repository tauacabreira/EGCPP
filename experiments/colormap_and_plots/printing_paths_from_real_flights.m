close all
clc
clear all

num_files = size(dir('../workspace/real flights/'),1);

for i = 3 : num_files
    workspace = dir('../workspace/real flights/');
    filename = ['../workspace/real flights/' workspace(i).name];
    load(filename);
    
    figure;
    printing_workspace(area, obstPoints, minimumPath, waypoints, width, height); 
    tempAreaMatrix
end