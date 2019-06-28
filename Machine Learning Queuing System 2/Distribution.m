classdef Distribution < handle
    %DISTRIBUTION Contains the packet distribution over time
    %   The packet distribution is stored as discrete equidistant
    %   signal data.
    
    properties
        field % one-dimensional array of signal data
        size % The size of field
        time % Array of time indexes used for plotting
    end
    
    methods
        function obj = Distribution()
            %DISTRIBUTION Construct an instance of this class
            %   Detailed explanation goes here
        end
        
        function generate(obj,scaling)
            %generate Generates a random distribution
            %   Detailed explanation goes here
            
            obj.field = zeros(1,24);
            obj.size = 24;
            
            step = 1;
            baseline = scaling/5;
            noise = scaling * (randn(24, 1)) / 20;

             time1 = step:step:6;
             time2 = (6 + step):step:12;
             time3 = (12 + step):step:18;
             time4 = (18 + step):step:24;
%             obj.time = [time1 time2 time3 time4];
            obj.time = 1:24;
            
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
        
        function load(obj,filename)
            fileID = fopen(filename);
            obj.field = fread(fileID);
            obj.size = length(obj.field);
            obj.time = 1:obj.size;
            fclose(fileID);
        end
        
        function save(obj,filename)
            fileID = fopen(filename,'w');
            fwrite(fileID,obj.field);
            fclose(fileID);
        end
        
        function adjust(obj,dist)
            if(obj.size ~= dist.size)
               error('Distributions are of different size!'); 
            end
            
            for i=1:1:obj.size
               amp = (obj.at(i) + dist.at(i))/2;
               obj.set(i,amp);
            end
        end
        
        function amp = at(obj,cycle)
            if(cycle < obj.size)
                amp = obj.field(cycle);
            else
                amp = 0;
            end
        end
        
        function set(obj,cycle,amp)
            obj.field(cycle) = amp;
        end
        
        function plot(obj,axes)
           plot(axes,obj.time,obj.field); 
        end
    end
end

