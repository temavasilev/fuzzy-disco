classdef Distribution < handle
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        field % 1d array of discrete equidistant packet distribution
        size % size of field
        time % ???
    end
    
    methods
        function obj = Distribution(cycles)
            %UNTITLED6 Construct an instance of this class
            %   Detailed explanation goes here
            obj.field = zeros(1,cycles);
            obj.size = cycles;
        end
        
        function generate(obj,scaling)
            %generate Generates a random distribution
            %   Detailed explanation goes here
            step = 1;
            baseline = scaling/5;
            noise = scaling * (randn(24, 1)) / 20;

            time1 = step:step:6;
            time2 = (6 + step):step:12;
            time3 = (12 + step):step:18;
            time4 = (18 + step):step:24;
            obj.time = [time1 time2 time3 time4];
            
            s1=(time1.*time1)*(baseline/36);
            s2=cos(((time2-6) / 6 * 2 * pi / 3)-pi/2)*scaling + baseline;
            s3=sin(((time3-12) / 6 * 2 * pi / 3) + pi/3)*scaling*1.2 + baseline;
            s4=fliplr(s1);
            
            BASESIGNAL= [s1 s2 s3 s4];
            BASESIGNAL=BASESIGNAL';
            FINALSIGNAL= BASESIGNAL + noise;
            
            for i = 1:1:(24)
                obj.field(i) = floor(FINALSIGNAL(i)); 
                if obj.field(i) < 1
                    obj.field(i) = 1;
                end
            end
            
        end
        
        function set(obj,index,amplitude)
            %set Records an amplitude at the given cycle index
            
            % Check if we are within array bounds
            if((index <= 0) || (index > obj.size))
               error('Record index out of bounds! Have 1:%d but trying to access %d.', obj.size, index);
            end
            
            % Set the value at index
            obj.field(1,index) = amplitude;
        end

        function amplitude = at(obj,index)
            %at Returns the recorded amplitude at the given cycle index

            % Check if we are within array bounds
            if((index <= 0) || (index > obj.size))
               error('Record index out of bounds! Have 1:%d but trying to access %d.', obj.size, index); 
            end
            
            % Return the value at index
            amplitude = obj.field(1,index);
        end
    end
end

