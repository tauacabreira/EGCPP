function [ x ] = clean_values( x,max_value )
%clean array of results from complex values and values outside the maximum
%value.

    n = length( x);
    x = double (x);
    i = 1;
    while( i <= n)
       
        if (abs(imag(x(i))) > 0.00000000001 )
            x(i) = [];
            n = n -1;
       else
           if(x(i) < 0 || x(i)>max_value)
                x(i) = [];
                n = n -1;
           else
                i = i+1;
           end
       end
    end
    x = real(x);
end

