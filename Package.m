classdef Package
    
    properties (Constant)
        size = 20;  %Size of the package is defined by the results of sampling
                    %The value is defined before package entered queue.
                    
    end
    
    properties 
        delay;      %Delay itself is a variable, caculated and accumulated in the whole process.
                    %Delay from transmission and waiting time should be written in. 
                    %What's the relation between delay and priority?
        max_delay;  %The longest accepted delay for every package. (That should be at least longer than transmission delay)
                    
        package_delay;  %Acceptable delay for package
    end
    
    methods
        function obj = Package(package_delay)                %Constructor
            if ( package_delay >= 0 && package_delay <= 150 )
            obj.package_delay = pDelay;
            %obj.delay = 1 / priority;                   %Delay is inversely proportional to its priority
            else
                error('Package can not be created with given priority.');
            end
        end
            
        function processing_delay = get.delay(obj)      %Get-function for delay
            processing_delay = obj.delay;
        end
        
        function pDelay = get.package_delay(obj)  %Get-function for package_delay
            pDelay = obj.package_delay;
        end
    end
    
end

