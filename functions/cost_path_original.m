function[costPath, anglesPath] = cost_path_original(path)

    costPath = 0;
    anglesPath = zeros(size(path,1) - 2, 1);
    
    for i = 1 : size(path,1) - 2
        v2 = path(i+2,:);
        v1 = path(i+1,:);
        v3 = path(i,:);
        angle = atan2d(abs((v2(1)-v1(1))*(v3(2)-v1(2))-(v2(2)-v1(2))*(v3(1)-v1(1))),...
                           (v2(1)-v1(1))*(v3(1)-v1(1))+(v2(2)-v1(2))*(v3(2)-v1(2)));

        anglesPath(i) = 180 - angle;
        costPath = costPath + anglesPath(i);
    end
end