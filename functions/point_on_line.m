function[onTheLine] = point_on_line(a, b, c)
   % checking if the a point 'c' is on a line between the points 'a' and 'b'
   
   crossproduct = (c(2) - a(2)) * (b(1) - a(1)) - (c(1) - a(1)) * (b(2) - a(2));
   dotproduct = (c(1) - a(1)) * (b(1) - a(1)) + (c(2) - a(2))*(b(2) - a(2));
   squaredlengthba = (b(1) - a(1))*(b(1) - a(1)) + (b(2) - a(2))*(b(2) - a(2));

   if abs(crossproduct) > 0.01 || dotproduct < 0 || dotproduct > squaredlengthba
        onTheLine = false;
   else
        onTheLine = true;
   end 
end