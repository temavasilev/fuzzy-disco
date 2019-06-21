classdef Record < handle
    %   Discrete representation of packet distribution
    
    properties (SetAccess = private)
        field % one-dimensional array storing discrete equidistant signal data
        size  % The actual array length of Record.field
    end
    
    methods
        function obj = Record(size)
            %Record Construct an instance of this class
            %   Initializes class properties with default values
            obj.field = zeros(1,size);
            obj.size = size;
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
        
        function set(obj,index,amplitude)
            %set Records an amplitude at the given cycle index
            
            % Check if we are within array bounds
            if((index <= 0) || (index > obj.size))
               error('Record index out of bounds! Have 1:%d but trying to access %d.', obj.size, index);
            end
            
            % Set the value at index
            obj.field(1,index) = amplitude;
        end
    end
end

