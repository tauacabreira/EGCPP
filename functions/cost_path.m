function[costPath] = cost_path(path)
    
    v2 = path(3,:);
    v1 = path(2,:);
    v3 = path(1,:);
    angle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                       (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));

    costPath = 180 - angle;
end