classdef PacketClass < handle
    %PACKETCLASS A set of rules for packet generation
    
    properties
        probability
        range
    end
    
    methods
        function obj = PacketClass(p,min,max)
            %PACKETCLASS Construct an instance of this class
            %   Empty constructor
            obj.setProbability(p);
            obj.setRange(min,max);
        end
        
        function setProbability(obj,p)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(p < 0 || p > 1)
                error('Probability out of bounds!');
            end
            
            obj.probability = p;
        end
        
        function setRange(obj,min,max)
           obj.range = [min max]; 
        end
    end
end

