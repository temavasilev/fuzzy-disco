classdef Package
    
    properties (Constant)
        size = 20;  %Size of the package is defined by the results of sampling
                    %The value is defined before package entered queue.
                    
    end
    
    properties 
        types ={'A','B','C'};            %Three types of packages
        tag;                             %with different tags which means diffrent tolerances
        tolerance;                       %The longest surivive time 
        endpoint;                        %Before global time comes to endpoint packages should be processed or droped.
                                         %It also should be used be calculated to load packages to CPUs
        age;                             %the synonymy as delay, itself is a variable, accumulated in the whole process.
                    
    end
    
    methods
        function obj = Package(generated_time)                %Constructor
            obj.tag = types(randi([1 3],1,1));
            if strcmp(obj.tag,'A')                            %Set tolerance based on type of the package
                obj.tolerance = 10;
            elseif strcmp(obj.tag, 'B')
                obj.tolerance = 7;
            else
                obj.tolerance = 3;
            end
            obj.endpoint =generated_time + tolerance;       %Set endpoint for the package
        end
            
        function living_time = getage(obj)                   %Get-function for age
            living_time = obj.age;
        end
        
        function obj = adddelay(obj,new_delay)               %Function to accumulate delay to age
            accumulate_delay = new_delay + obj.age;          %new_delay will be calculated outside? or with a constant after everty loop?
            obj.age = accumulate_delay;
        end
        
        function ending_time = getendpoint(obj)                    %Get-function for getendpoint
            ending_time = obj.endpoint;
        end
        
        function tag = gettag(obj)                     %Get-function for tag
            tag = disp(obj.tag);
        end
    end
    
end

