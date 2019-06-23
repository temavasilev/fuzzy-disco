classdef PacketGenerator < handle
    %PacketGenerator Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        probability_low
        probability_med
        probability_high
        
        probpos_low
        probpos_med
        probpos_high
        
        range_low
        range_med
        range_high
    end
    
    methods
        function obj = PacketGenerator()
            %PacketGenerator Construct an instance of this class
            %   Detailed explanation goes here
            obj.probability_low = 0.33;
            obj.probability_med = 0.33;
            obj.probability_high = 0.33;
            
            obj.probpos_low = obj.probability_low;
            obj.probpos_med = obj.probpos_low + obj.probability_med;
            obj.probpos_high = obj.probpos_med + obj.probability_high;
            
            obj.range_low = [50 100];
            obj.range_med = [20 50];
            obj.range_high = [5 20];
        end
        
        function packets = generate(obj, n)
            packets = zeros(1,n);
            for i=1:1:n
                % Randomly determine package class
                class = rand(1);
                % LOW Priority
                if(class >= 0 && class <= obj.probpos_low)
                    packets(i) = (obj.range_low(2) - obj.range_low(1)) * rand(1) + obj.range_low(1);
                % Medium priority
                elseif(class > obj.probpos_low && class <= obj.probpos_med)
                    packets(i) = (obj.range_med(2) - obj.range_med(1)) * rand(1) + obj.range_med(1);
                % High prioroty
                elseif(class > obj.probpos_med && class <= obj.probpos_high)
                    packets(i) = (obj.range_high(2) - obj.range_high(1)) * rand(1) + obj.range_high(1);
                end
                
                packets(i) = round(packets(i));
            end
        end
    end
end





% classdef PacketGenerator < handle
%     %PACKETGENERATOR Generates packets and manages packet classes
%     
%     properties
%         classes = PacketClass.empty;
%         cumulated = 1; % sum over all proababilities
%     end
%     
%     methods
%         function obj = PacketGenerator()
%             %PACKETGENERATOR Construct an instance of this class
%             %   Statically initializes the packet classes with
%             %   predetermined hardcoded values
%             lo = PacketClass(0.33,50,100);
%             me = PacketClass(0.33,20,50);
%             hi = PacketClass(0.33,5,20);
%             obj.classes = [lo me hi];
%             obj.cumulated = 0.33 + 0.33 + 0.33;
%         end
%         
%         % THIS IS FOR LATER, IF SOMEONE WOULD LIKE TO IMPLEMENT
%         % DYNMAIC PACKET CLASSES.
%         function addPacketClass(obj, class)
%            if(isempty(obj.classes))
%               obj.classes = class;
%            else
%                % TODO: Check for conflicts before adding
%                obj.classes = [obj.classes; class];
%                %obj.cumulated = obj.cumulated + class....
%            end
%         end
%         
%         function packets = generate(obj,amount)
%             %generate Generate packets
%             %   Generates a number of 'amount' packets according
%             %   to the rules defined in the packet classes
%             packets = zeros(1,amount);
%             nelem = length(obj.classes);
%             
%             for i=1:1:amount
%                 % Randomly determine packet class
%                 class = rand(1) + 1 - obj.cumulated;
%                 
%                 p = 0;
%                 value = 0;
%                 for k=1:1:nelem
%                     if(p >= class)
%                         value = (obj.classes(k).range(2) - obj.classes(k).range(1)) * (rand(1) + 1 - obj.cumulated) + obj.classes(k).range(1);
%                         break; 
%                     else
%                         p = p + obj.classes(k).probability;
%                     end
%                 end
%                 
%                 packets(i) = round(value);
%             end
%         end
%     end
% end
% 
