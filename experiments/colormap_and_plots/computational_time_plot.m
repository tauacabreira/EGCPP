clear all;
clc;
close all;

% info: (1) minimumCost
%       (2) numOfCompletedPaths 
%       (3) numOfExecutions 
%       (4) timeElapsed

filedir_optimized = '../data/mat/optimized';
matfiles_optimized = dir(fullfile(filedir_optimized, '*.mat'));

filedir_optimized_energy = '../data/mat/optimized_energy';
matfiles_optimized_energy = dir(fullfile(filedir_optimized_energy, '*.mat'));

filedir_original = '../data/mat/original';
matfiles_original = dir(fullfile(filedir_original, '*.mat'));
nfiles = length(matfiles_original);

for i = 1 : nfiles
    % loading the .mat files
    data_optimized = load(fullfile(filedir_optimized, matfiles_optimized(i).name));
    data_optimized_energy = load(fullfile(filedir_optimized_energy, matfiles_optimized_energy(i).name));
    data_original = load(fullfile(filedir_original, matfiles_original(i).name));
     
    % splitting the filename to get the number of cells 
    part = strsplit(matfiles_optimized(i).name, '_');
    cell = str2double(part(2));
    
    % number of cells
    x(i) = cell;
    
    % === PLOTS === %
    % time elapsed (considering every valid cell)
    %time_elapsed_optimized(i) = median(data_optimized.info(:,4));
    %time_elapsed_optimized_energy(i) = median(data_optimized_energy.info(:,4));
    %time_elapsed_original(i) = median(data_original.info(:,4));
    
    % time elapsed (only for the first valid cell)
    time_elapsed_optimized(i) = data_optimized.info(1,4);
    time_elapsed_optimized_energy(i) = data_optimized_energy.info(1,4);
    time_elapsed_original(i) = data_original.info(1,4);
end

% printing information
time_elapsed_optimized
time_elapsed_optimized_energy
time_elapsed_original

% === TIME ELAPSED === %
figure
subplot(1,2,1)
plot(x, time_elapsed_original, 'r-');
hold on
plot(x, time_elapsed_optimized, 'g-', 'color', [0 0.6 0]);
hold on;
plot(x, time_elapsed_optimized_energy, 'b-');
hold on;
axis([16 48 0 12000]);

%title('Time Elapsed');
set(gca,'XTick',x);
xlabel('Number of cells');
ylabel('Seconds')
legend('Alg. A (original)', 'Alg. B (optimized)', 'Alg. C (optimized-energy)', 'Location', 'northwest');

subplot(1,2,2)
plot(x, time_elapsed_original, 'r-');
hold on
plot(x, time_elapsed_optimized, 'g-', 'color', [0 0.6 0]);
hold on;
plot(x, time_elapsed_optimized_energy, 'b-');
hold on;
axis([16 48 0 1200]);
text(22,800,'10x Zoom','Color','black','FontSize',20)

%title('Time Elapsed');
set(gca,'XTick',x);
xlabel('Number of cells');
ylabel('Seconds')
legend('Alg. A (original)', 'Alg. B (optimized)', 'Alg. C (optimized-energy)', 'Location', 'northwest');

box on
set(gcf, 'Color', 'White');

% === TIME ELAPSED NORMALIZED === %
figure
y1 = time_elapsed_optimized;
y2 = time_elapsed_original;
y3 = time_elapsed_optimized_energy;

normalized_y2 = (y2 - y1) ./(y2);
normalized_y3 = (y2 - y3) ./(y2);

plot(x, normalized_y2, '-ob');
hold on;
plot(x, normalized_y3, '-or');
hold on;

%title('Time Elapsed');
set(gca,'XTick',x);
xlabel('Number of cells');
ylabel('Percentage of optimization')
legend('Optimization of Alg. B', 'Optimization of Alg. C', 'Location', 'northwest');

% === TIME ELAPSED all together === %
% figure
% plotyy(x, time_elapsed_optimized, x, normalized_y2);
% hold on
% plot(x, time_elapsed_optimized_energy);
% hold on;
% plot(x, time_elapsed_original);
% 
% title('Time Elapsed');
% set(gca,'XTick',x);
% xlabel('Number of Cells');
% ylabel('Optimization')