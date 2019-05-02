classdef Package
    
    properties (Constant)
        size = 20;  %Size of the package is defined by the results of sampling
                    %The value is defined before package entered queue.
                    
    end
    
    properties 
        delay;      %Delay itself is a variable, caculated in the whole process.
                    %Delay from transmission and waiting time should be written in. 
                    %What's the relation between delay and priority?
                    
        priority_value;     %Still not clear what the priority depends on 
    end
    
    methods
        function obj = Package(priority)                %Constructor
            if ( priority >= 0 && priority <= 150 )
            obj.priority_value = priority;
            obj.delay = 1 / priority;                   %Delay is inversely proportional to its priority
            else
                error('Package can not be created with given priority.');
            end
        end
            
        function processing_delay = get.delay(obj)      %Get-function for delay
            processing_delay = obj.delay;
        end
        
        function priority = get.priority_value(obj)     %Get-function for priority
            priority = obj.priority_value;
        end
    end
    
end

