%
% What we are about to do:
% 
% have:
% 
% History
% Distribution
% Cluster
% 
% Add packets from current distribution to cluster. Based of history set behaviour of cluster. Update cluster. done
%

classdef Cluster < handle
    %Cluster CPU cluster for processing packages
    %   Detailed explanation goes here
    
    properties (SetAccess = private)
        cpu % Array of CPUs (static size = 3)
        num_cpus % Number of CPUs
        queue % Package queue
        behaviour % How aggressive do we want to be?
    end
    
    methods
        function obj = Cluster()
            %Cluster Construct an instance of this class
            %   s1: Speed of first CPU
            %   s2: Speed of second CPU
            %   ...
            
            % Initialize CPU array
            obj.cpu = 0;
            obj.num_cpus = 0;
            
            obj.setCpuCount(3);
            
            % Create empty queue
            obj.queue = List();
            
            % Initial behaviour
            obj.behaviour = Behaviour.calm;

        end
        
        function setCpuCount(obj, n)
           obj.cpu = (1:n);
        end
        
        function setCpuSpeed(obj, i, ppc)
            obj.cpu(i).setSpeed(ppc);
        end
        
        function addPacket(obj, packet)
            
            %obj.queue.append(node);
        end
        
        function update(obj,inputArg)
            %update Update queue and process packages
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

