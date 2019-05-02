classdef Package
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties (Constant)
        size = 20;  %随便写的
    end
    
    properties 
        delay;
        priority_value;
    end
    
    methods
        function obj = Package(priority)
            if ( priority >= 0 && priority <= 150 )
            obj.priority_value = priority;
            obj.delay = 1 / priority;  %随便写的
            else
                error('Package can not be created with given priority.');
            end
        end
        
        function processing_delay = get.delay(obj)
            processing_delay = obj.delay;
        end
        
        function priority = get.priority_value(obj)
            priority = obj.priority_value;
        end
    end
    
end

