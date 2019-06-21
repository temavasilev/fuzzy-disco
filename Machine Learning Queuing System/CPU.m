classdef CPU < handle
    %CPU A simple representation of a packet processor
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        ppc % # of packages, that can be processed per cycle
        nelem % number of packages waiting to be processed
        status % Boolean: Is the CPU is busy or not (true == busy)
    end
    
    methods
        function obj = CPU(speed)
            %CPU Construct an instance of this class
            %   Detailed explanation goes here
            obj.ppc = speed;
            obj.nelem = 0;
            obj.status = false;
        end
        
        function assign(obj)
            %assign Assigns a packet to a CPU
            %   The packet is added to the processing stack and
            %   processed on the next call to process
            obj.nelem = obj.nelem + 1;
        end
        
        function obj = process(obj)
            
            % Actual processing
            obj.status = true;
            obj.nelem = obj.nelem - obj.ppc;
            
            % Are we done processing?
            if(obj.nelem <= 0)
               obj.nelem = 0;
               obj.status = false;
            end
        end
        
        function setSpeed(obj, ppc)
           obj.ppc = ppc; 
        end
        
        function status = available(obj)
            %available Returns true if the CPU is not busy
            status = (obj.status == false);
        end
    end
end

