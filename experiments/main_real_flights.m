close all
clc
clear all

addpath('../energy_model');
load('../energy_model/E_model_full.mat');
load('../energy_model/E_angle_speed.mat');

altitude = 10;

% calling the functions
[power_simulation, time_simulation, distance_array] = flight_simulation_analysis(E_model, E_angle_speed, E_rotate, e_total, altitude);
[power_log, time_log] = flight_logs_analysis();

x = ['Energy 14'; 'Normal 14'; 'Energy 29'; 'Normal 29'];
str1 = ['Cell(4,2) ' char(10) 'with Alg. C'];

x = {'Cell(4,2) Energy'; 'Cell(4,2) Original'; 'Cell(6,1) Energy'; 'Cell(6,1) Original'};

figure(1)
data = [time_log(1) time_simulation(1); 
        time_log(2) time_simulation(2); 
        time_log(3) time_simulation(3); 
        time_log(4) time_simulation(4)];

hold on
for i = 1 : size(data,1)
    h01 = bar(i, data(i,2));
    
    if mod(i,2) == 0
        set(h01,'FaceColor',[1 0.7 0]);
    else
        set(h01,'FaceColor',[1 0.7 0]);
    end  
end
hh01 = h01;

for i = 1 : size(data,1)
    h01 = bar(i, data(i,1));
    
    if mod(i,2) == 0
        set(h01,'FaceColor',[0.5 0 0]);
        hh02 = h01;
    else
        set(h01,'FaceColor',[0 0.5 0]);
        hh03 = h01;
    end  
end

legend([hh01 hh02 hh03],'Estimated time with the energy model','Measured time of the real flight','Measured time of the real flight','Location','southeast')


hold off
set(gca,'XTick',[1 2 3 4]);
set(gca,'XTickLabel', x);
xlabel('Path');
ylabel('Time (s)');

box on
set(gcf, 'Color', 'White')
%export_fig time_bars.pdf
 
figure(2)
data = [power_log(1) power_simulation(1);
        power_log(2) power_simulation(2);
        power_log(3) power_simulation(3);
        power_log(4) power_simulation(4)];
    
    data = [power_log(1) power_simulation(1);
            power_log(3) power_simulation(3);
            power_log(2) power_simulation(2);
            power_log(4) power_simulation(4)];
    
x = {'Cell(4,2) E-F'; 'Cell(6,1) E-F'; 'Cell(4,2) O-F';  'Cell(6,1) O-F'};
        
hold on
for i = 1 : size(data,1)
    h01 = barh(i, data(i,2));
    set(h01,'FaceColor',[1 0.7 0]);
end
hh01 = h01;

for i = 1 : size(data,1)
    h02 = barh(i, data(i,1));
    set(h02,'FaceColor',[0 0.5 0]);
end
legend([h01 h02],'Estimated energy with the energy model','Measured energy of the real flight','Location','northwest')

hold off
set(gca,'YTick',[1 2 3 4]);
set(gca,'YTickLabel', x);
xlabel('Energy (J)');
axis([0 80000 0.5 5.5])
box on
set(gcf, 'Color', 'White')
     