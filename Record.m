classdef Record < handle
    %Record In german: "Aufzeichnung"
    %   Discrete recording of signal values
    %   Differs from Signal, thus reimplementation.
    
    properties (SetAccess = private)
        field % one-dimensional array storing discrete equidistant signal data
        size % The actual array length of Record.field
    end
    
    methods
        function obj = Record(size)
            %Record Construct an instance of this class
            %   Initializes class properties with default values
            %   size: The actual array length, NOT THE MAXIMUM TIME!
            obj.field = zeros(1,size);
            obj.size = size;
        end
        
        function amplitude = at(obj,t)
            %at Returns the recorded amplitude at the given time t
            %   returns the corresponding array field.
            %   Use like this:
            %   record.at(10);
            %   to return the record amplitude at time 10 TU where
            %   TU : Time unit
            index = t;
            if(index > obj.size)
               error('index exceeds record size!'); 
            end
            amplitude = obj.field(1,index);
        end
        
        function set(obj,t,amplitude)
            %set Records an amplitude at the given time t
            %   sets the corresponding array field equal to amplitude.
            %   Use like this:
            %   record.set(10, 5);
            %   to set the record amplitude at time 10 TU to 5 AU where
            %   TU : Time unit
            %   AU : Amplitude unit
            index = t;
            if(index > obj.size)
               error('Index exceeds record size!'); 
            end
            obj.field(1,index) = amplitude;
        end
    end
end

