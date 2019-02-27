close all
clc
clear all

addpath('../energy_model');
load('../energy_model/E_model_full.mat');
load('../energy_model/E_angle_speed.mat');

altitude = 10;

[angles, power, time, distance] = ...
    flight_simulation_scenarios(E_model, E_angle_speed, E_rotate, e_total, altitude);

% all data is already inside this file (scenarios_data.mat), 
% but you can run the function above anyway

% load('workspace/simulation/scenarios_data.mat');
% time = time_simulation;
% power = power_simulation;

x = ['A with 37 cells'; 'B with 45 cells'; 'C with 47 cells'; 'D with 50 cells'];

figure(1)
data = [time(3) time(4); 
        time(5) time(6); 
        time(1) time(2); 
        time(7) time(8)];

hold on
for i = 1 : size(data,1)
    h01 = bar(i, data(i,2));
    set(h01,'FaceColor',[0.5 0.5 0.5]);
end
hh01 = h01;

for i = 1 : size(data,1)
    h02 = bar(i, data(i,1));
    set(h02,'FaceColor',[0.8 0.8 0.8]);
end

legend([h01 h02],'Flight time of the path generated with O-F', ...
                 'Flight time of the path generated with E-F', ...
                 'Location','southwest');
             
hold off
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel', x);
xlabel('Scenario');
ylabel('Time (s)');

box on
set(gcf, 'Color', 'White')
 
figure(2)
data = [power(3) power(4);
        power(5) power(6);
        power(1) power(2);
        power(7) power(8)];

x = ['A with 37 cells'; 'B with 45 cells'; 'C with 47 cells'; 'D with 50 cells'];

hold on
for i = 1 : size(data,1)
    h01 = barh(i, data(i,2));
    set(h01,'FaceColor',[0.5 0.5 0.5]);
end
hh01 = h01;

for i = 1 : size(data,1)
    h02 = barh(i, data(i,1));
    set(h02,'FaceColor',[0.8 0.8 0.8]);
end

legend([h01 h02], 'Energy consumption of the path generated with O-F', ...
                  'Energy consumption of the path generated with E-F', ...
                  'Location','northwest');

hold off
set(gca,'YTick',[1 2 3 4]);
set(gca,'YTickLabel', x);
xlabel('Energy (J)');

axis([0 80000 0.5 5.5])

box on
set(gcf, 'Color', 'White')     