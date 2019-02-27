close all
clc
clear all

addpath('functions');

% version: (1) optimized, (2) original
% typeCost (cost function): (0) angles, (1) energy

% all grid_based functions are called here in a single file
% you can comment and run only one at the time

% Experiments with real flights
[minimumPath, minimumAngles, waypoints] = grid_based_algorithm_real_flights(1, 1);

% Experiments with different irregular-shaped scenarios
[minimumPath, minimumAngles, waypoints] = grid_based_algorithm_scenarios(1, 1);

% COMPUTATIONAL TIME ANALYSIS
% Experiments with 48, 44, 40, 36, 32, 28, 24, 20, 16 cells
removedCells = [0 4 8 12 16 20 24 28 32];

parfor i = 1 : size(removedCells, 2)
    
    % original version
    grid_based_algorithm(2, 0, removedCells(i));
    
    % optimized version (pruning) with 
    % angle-cost function (partially computed every time) 
    grid_based_algorithm(1, 0, removedCells(i));
    
    % optimized version (pruning) with 
    % energy-cost function (partially computed every time)
    grid_based_algorithm(1, 1, removedCells(i));
end