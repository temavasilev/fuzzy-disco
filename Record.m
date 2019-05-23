classdef Record < handle
    %Record In german: "Aufzeichnung"
    %   Discrete recording of signal values
    %   Differs from Signal, thus reimplementation.
    
    properties (SetAccess = private)
        field
        size
        dist
    end
    
    methods
        function obj = Record(size,dist)
            %Record Construct an instance of this class
            %   Initializes class properties with default values
            obj.field = zeros(1,size);
            obj.size = size;
            obj.dist = dist;
        end
        
        function amplitude = at(obj,t)
            %at Returns the recorded amplitude at the given time t
            %   Detailed explanation goes here
            index = t / obj.dist;
            if(index > obj.size)
               error('index exceeds record size!'); 
            end
            amplitude = obj.field(1,index);
        end
        
        function set(obj,t,amplitude)
            %at Records an amplitude at the given time t
            %   Detailed explanation goes here
            index = t / obj.dist;
            if(index > obj.size)
               error('Index exceeds record size!'); 
            end
            obj.field(1,index) = amplitude;
        end
    end
end

