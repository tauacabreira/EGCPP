close all
clc
clear all

load('data/mat_real_exp/optimized/experiment_47.mat');
addpath('../../utils');
addpath('../../EnergyModel');

E = info_energy(:,1);
N = info_normal(:,1);
[energy_cost, energy_index] = min(E(E > 0));
[normal_cost, normal_index] = min(N(N > 0));

%%%%%%%%%%%%%%%%%%% MINIMUM ENERGY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% printing the path
file_energy = strcat('result_experiment_47/Energy_workspace_41cells_k_', num2str(energy_index),'.mat');
load(file_energy);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Optimal energy path');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/optimal_energy_path_k_', num2str(energy_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);

%%%%%%%%%%%%%%%%%%% MINIMUM NORMAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% printing the path
file_normal = strcat('result_experiment_47/Normal_workspace_41cells_k_', num2str(normal_index),'.mat');
load(file_normal);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Optimal normal path');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/optimal_normal_path_k_', num2str(normal_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ENERGY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_energy = strcat('result_experiment_47/Energy_workspace_41cells_k_', num2str(normal_index),'.mat');
load(file_energy);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Energy path using optimal starting position for normal');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/energy_path_k_', num2str(normal_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NORMAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_normal = strcat('result_experiment_47/Normal_workspace_41cells_k_', num2str(energy_index),'.mat');
load(file_normal);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Normal path using optimal starting position for energy');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/normal_path_k_', num2str(energy_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ENERGY K = 45 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

energy_index = 45;
normal_index = 45;

% printing the path
file_energy = strcat('result_experiment_47/Energy_workspace_41cells_k_', num2str(energy_index),'.mat');
load(file_energy);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Energy path with k = 45');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/energy_path_k_', num2str(energy_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NORMAL K = 45 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% printing the path
file_normal = strcat('result_experiment_47/Normal_workspace_41cells_k_', num2str(normal_index),'.mat');
load(file_normal);
printing_path(area, obstPoints, minimumPath, waypoints, width, height);
title('Normal path with k = 45');

% converting from path to waypoints
[full_waypoints, waypoints_info, ~] = path2waypoints(minimumPath, waypoints);

% creating the waypoint file
waypoint_file = strcat('paths/normal_path_k_', num2str(normal_index),'.txt');
write_waypoints_file02(waypoint_file, full_waypoints, waypoints_info, home, 10);