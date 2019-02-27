close all
clc
clear all


addpath('../scenarios');

for j = 3 : size(dir('../mat_logs'),1)
    
    files = dir('../mat_logs');
    filename = ['../mat_logs/' files(j).name];
    load(filename);
    
    % planned path
    lat_wp = CMD(:,10);
    lon_wp = CMD(:,11);

    % performed path
    real_lat_wp = GPS(:,7);
    real_lon_wp = GPS(:,8);

    % removing the zeros from the waypoints, when the UAV change the speed
    lat_wp = lat_wp(lat_wp ~= 0);
    lon_wp = lon_wp(lon_wp ~= 0);

    % getting the map
    coord = [43.715717, 10.462228];
    [XX, YY, M, Mcolor] = get_google_map(coord(1), coord(2));

    % plotting the map
    figure()
    imagesc(XX,fliplr(YY),M);
    colormap(Mcolor);
    hold on

    % plotting the planned path
    [lonutm, latutm, ~] = deg2utm(lat_wp, lon_wp);
    plot(lonutm, latutm, 'bo-', 'LineWidth',2);
    hold on

    % plotting the first waypoint
    plot(lonutm(1), latutm(1), 'gx', 'LineWidth',10);
    hold on
    
    % plotting the last waypoint
    plot(lonutm(end), latutm(end), 'rx', 'LineWidth',10);
    hold on
    
    % plotting the performed path
    [real_lon_utm, real_lat_utm, zone] = deg2utm(real_lat_wp, real_lon_wp);
    plot(real_lon_utm, real_lat_utm, 'w-');
    hold on;

    % plotting the area and the obstacles
    [~, ~, ~, coord_area, coord_obst] = ...
        waypoints2meters('real_flight_area.waypoints', 'real_flight_obstacles.waypoints');
     
    area = [coord_area; coord_area(1,:)];
    [areax_utm, areay_utm, ~] = deg2utm(area(:,1), area(:,2));

    obst = [coord_obst; coord_obst(1,:)];
    [obstx_utm, obsty_utm, ~] = deg2utm(obst(:,1), obst(:,2));

    plot(areax_utm, areay_utm, 'r-', 'LineWidth', 2);
    hold on
    plot(obstx_utm, obsty_utm, 'r-', 'LineWidth', 2);
    hold on

    % plotting grid over the picture
    max_w = max(areax_utm);
    min_w = min(areax_utm);

    min_h = min(areay_utm);
    max_h = max(areay_utm);

    width_grid = max_w - min_w;
    offset_w = width_grid / 10;

    height_grid = max_h - min_h;
    offset_h = height_grid / 8;

    for i = 0 : 10    
        x = ones(1, ceil(height_grid)) * (min_w + offset_w * i);
        y = min_h:1:max_h;

        plot(x, y, 'w--','color',[0.2 0.2 0.2]);
        hold on
    end

    for i = 0 : 8
        x = min_w:1:max_w;
        y = ones(1, ceil(width_grid)) * (min_h + offset_h * i);
        plot(x, y, 'w--','color',[0.2 0.2 0.2]);
        hold on
    end

    set(gca,'Ydir','Normal');
    set(gca, 'XTickLabel',{'50','100','150','200','250'});
    %xlabel('Meters');
    set(gca, 'YTickLabel',{'0','20','40','60','80','100','120','140','160','180','200'});
    %ylabel('Meters');
end