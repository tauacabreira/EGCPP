function[power_array, time_array] = flight_logs_analysis()

    power_array = [];
    time_array = [];
    
    line_ends = [1629 1794 1642 1808];
    
    % open every log file
    for j = 3 : size(dir('mat_logs'),1)
        log = dir('mat_logs');
        log_path = ['mat_logs/' log(j).name];
        load(log_path) 

        % flight time
        %time = (CURR(end,2) - CMD(1,2)) / 1000;
        time_ini = min(find(CURR(:,6) > 500));

        time = (CURR(end,2) - time_ini) / 1000;
    
        line_ini = CMD(4,1);
        [~,gps_line_ini] = min(abs(GPS(:,1) - line_ini));
        
        time_ini = GPS(gps_line_ini,3);
        
%         line_end = find(GPS(:,11) > 1);
%         line_end = line_end(end);
%         
        line_end = line_ends(j - 2);
        
        time_end = GPS(line_end,3);
        
        
        
        time = (time_end - time_ini)/1000;
        
        % energy consumption
        total_power = 0;
        
        [~,line_p_ini] = min(abs(CURR(:,1) - line_ini)) 
        
        [~,line_p_end] = min(abs   (   CURR(:,1) - GPS(line_end,1)  ))
        
       for i = line_p_ini : line_p_end - line_p_ini
       %for i = 1 : size(CURR(:,5),1)
            voltage = CURR(i,5)/100;
            current = CURR(i,6)/100;

            total_power = total_power + voltage * current;
        end
        
        power_array(end+1,:) = total_power;
        time_array(end+1,:) = time;   
    end
end