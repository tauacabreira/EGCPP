function [ z ] = gpsplusdeltaxy( lat0,lon0, dx, dy )
%GPSPLUSDELTAXY given a gps point( lat and lon) compute the point at
%distance in meters dx,dy.
%Calcola il punto gps assoluto a partire dai valori in metri dx,dy

   lat = lat0 + dy*(180/pi)/6378137;
   lon = lon0 + dx*(180/pi)/(6378137*cos(lat0*pi/180));

   z(2) = lon;
   z(1) = lat;

end

