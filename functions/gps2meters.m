function z = gps2meters(lat1, long1, lat2, long2)
    % calcola la distanza x,y tra due punti gps
    earth_radius = 6378137.0;  %raggio della terra in m
    d2r = pi/180;

    lat1r = lat1*d2r;
    lon1r = long1*d2r;
    lat2r  = lat2*d2r;
    lon2r = long2*d2r;
    
    x = (lon2r - lon1r) * cos( 0.5*(lat2r+lat1r) )*earth_radius;
    y = (lat2r - lat1r)*earth_radius;

    z(1) = x;
    z(2) = y;    
end
