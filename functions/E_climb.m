function [E,t_end] = E_climb(E_model,h_init,h_end)
    % computes the energy and the time required to climb or descend

    % if initial height is equal to final height then return 0
    if h_init == h_end
        E = 0;
        t_end = 0;
        
        return;
    end
    
    % if final height is greater then the initial then descending, else
    % climbing
    if  (h_end > h_init)
        speed = E_model.v_climb;
        Energy = E_model.p_climb;
    else
        speed = E_model.v_descend;
        Energy = E_model.p_descend;
    end
    
    % compute t, E, and E_t
    t_init = 0;
    t_end = abs((h_end - h_init))/speed;
    E = Energy*(t_end -t_init);
  
     
end
