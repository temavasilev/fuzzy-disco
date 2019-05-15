classdef Signal 
    properties
        frequency % how fast we need packages
        signal % polynomial function
        delay % transfer delay
        size % size of the package
        discrete_sample % a discrete representation of a signal
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
        
        function discrete_signal = sampling(sig,tact,time_limit,time_type) % makes a discrete sample of a signal with a required frequency(tact) for however long(time_limit). 
            
            % I have implemented a basic switch to convert milliseconds,
            % minutes or hours into seconds, depending on the function
            % argument.
            switch time_type
                case {"ms","Ms","MS"}
                    time_limit = time_limit / 1000;
                    disp("The time limit has been converted to " + time_limit + " seconds")
                case {"s","S"}
                    disp("The time limit was set to " + time_limit + " seconds")
                case {"h","H"}
                    time_limit = time_limit * 3600;
                    disp("The time limit has been converted to " + time_limit + " seconds")
                case {"m","M"}
                    time_limit = time_limit * 60;
                    disp("The time limit has been converted to " + time_limit + " seconds")
                otherwise
                    disp("Unknown or missing time type. Defaulting to seconds")
            end
            
            sig.discrete_sample = zeros(2,floor(time_limit/tact)); % fill the field with zeros to allocate the appropriate size
            for i = 1:floor(time_limit/tact)
                % the first line will be the time (the x-axis of our
                % function) at which the sampling is made. 
                sig.discrete_sample(1,i) = tact * i;
                for polynom_calculation = 1:length(sig.signal)
                    % the second line is decated to the actual values (the
                    % y-axis). What the code basically does is it goes
                    % through the coeffients of the polynom from the highest power to
                    % lowest (sig.signal(polynom_calculation)), multiplies
                    % it by the time of the sample to the power of its appropriate exponent, ie.
                    % result = coeffient * sampling_time^exponent.
                   sig.discrete_sample(2,i) = sig.discrete_sample(2,i) + sig.signal(polynom_calculation)*sig.discrete_sample(1,i)^(length(sig.signal)-polynom_calculation);
                end
            end
            discrete_signal = sig; % copy all values to the output
                                   % yes I am fully aware it is maybe not quite
                                   % effecient, but for now the method
                                   % works as intended by calling
                                   % Signal = sampling(Signal,a,b,c). Not
                                   % completely sure how to make the code
                                   % more elegant in MatLab (or if it is indeed possible).
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