classdef Clustermode < int32
    %CLUSTERMODE Summary of this class goes here
    %   Detailed explanation goes here
    
    enumeration
       short(1)     % Use all Resources and have CPUs free after cycle
       medium(2)    % Use a bunch of resources for longer
       long(3)      % Use the least amount of resources for a long time
    end
    
    methods(Static)
        function s = text(mode)
            if(mode == Clustermode.short)
                s = 'short';
            elseif(mode == Clustermode.medium)
                s = 'medium';
            elseif(mode == Clustermode.long)
                s = 'long';
            end
        end
    end
end

