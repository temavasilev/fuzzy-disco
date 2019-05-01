classdef Signal 
    properties (SetAccess = private) % attribute can be deleted to change to public
        frequency % how fast we need packages
        signal % polynomial function
        delay % transfer delay
        size % size of the package
    end
    methods
        function constructor = Signal(freq,sig,del,sz) % made a basic constructor just in case
            constructor.frequency = freq;
            constructor.signal = sig;
            if nargin == 4 % if all arguments are present
                constructor.delay = del;
                constructor.size = sz;
            end
            if nargin == 2 % if delay and size are constant
                constructor.delay = 0.01; % or whatever constants we will have
                constructor.size = 10;
            end 
        end            
    end
end

%{ 

Information for later:
- Matlab represents polynomials as row vectors containing coefficients
ordered by descending powers, so making polynomials should be very easy.
This means that zB. calling a constructor with Signal(freq, [2 3 5]) will
create a polynom 2x^2 + 3x + 5 that can be evaluated and manipulated as needed.
- There is a function to calculate a derivative, polyder()

%}