function [ t_total ] = compute_t(distance,max_speed )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 
a = 1.3;
 
t = sqrt(distance/a);
t_total = t*2;
if t > max_speed/a
    
    d_acc_dec = a*max_speed^2;
    d_const = distance - d_acc_dec;
    
    t_const_speed = d_const/max_speed;
    t_total = max_speed/a + max_speed/a + t_const_speed;
end


end

