classdef Settings < handle
    %SETTINGS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        interval
        cpus
        cycles
        scaling
        noise
    end
    
    methods
        function obj = Settings()
            %SETTINGS Construct an instance of this class
            %   Detailed explanation goes here
            obj.default();
        end
        
        function default(obj)
           obj.interval = 100;
           obj.cpus = 3;
           obj.cycles = 24;
           obj.scaling = 10;
           obj.noise = 5;
        end
        
        function load(obj,filename)
            
        end
        
        function save(obj,filename)
            
        end
    end
end

